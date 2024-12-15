import 'package:accountant_manager/domain/entities/money_account.dart';
import 'package:accountant_manager/domain/entities/money_transaction.dart';
import 'package:accountant_manager/domain/exceptions/invalid_money_transaction.dart';
import 'package:accountant_manager/domain/ports/data_transaction_port.dart';
import 'package:accountant_manager/domain/repositories/money_account_repository.dart';
import 'package:accountant_manager/domain/repositories/money_transaction_repository.dart';
import 'package:accountant_manager/domain/usecases/money_account/transfer_amount_money_account_usecase.dart';
import 'package:accountant_manager/domain/values/account_types.dart';
import 'package:accountant_manager/domain/values/money_transaction_status.dart';

class TransferAmountMoneyAccountUsecaseImp
    implements TransferAmountMoneyAccountUsecase {
  final MoneyAccountRepository _moneyAccountRepository;
  final MoneyTransactionRepository _moneyTransactionRepository;
  final DataTransactionPort _dataTransactionPort;

  TransferAmountMoneyAccountUsecaseImp(
      {required MoneyAccountRepository moneyAccountRepository,
      required MoneyTransactionRepository moneyTransactionRepository,
      required DataTransactionPort dataTransactionPort})
      : _moneyAccountRepository = moneyAccountRepository,
        _moneyTransactionRepository = moneyTransactionRepository,
        _dataTransactionPort = dataTransactionPort;

  @override
  Future<MoneyTransaction> execute(MoneyTransaction transaction) async {
    print("transfer amounts. ${transaction.fromAccountUuid} -> ${transaction.toAccountUuid}");
    await _dataTransactionPort.transaction((context) async {

      // Update Transaction
      transaction = transaction.copyWith(
          status: MoneyTransactionStatus.completed, updated: DateTime.now());
      await _moneyTransactionRepository.update(transaction, context);
      print("1");
      // Update origin account
      if (transaction.fromAccountUuid != null) {

        MoneyAccount from = await _moneyAccountRepository
            .getByUUID(transaction.fromAccountUuid!, context);
        print("2");
        if (from.balance < transaction.amount &&
            from.accountType != MoneyAccountTypes.creditCard) {
          throw InvalidMoneyTransaction("La cuenta no tiene suficiente saldo");
        }

        from = from.copyWith(
            balance: from.balance - transaction.amount,
            updated: DateTime.now());
        print("new withdraw transaction ${transaction.fromAccountUuid}: final balance: ${from.balance}");
        await _moneyAccountRepository.update(from, context);
      }

      // Update destination account
      if (transaction.toAccountUuid != null) {
        print("3 ${transaction.toAccountUuid}");
        MoneyAccount to =
            await _moneyAccountRepository.getByUUID(transaction.toAccountUuid!, context);
        to = to.copyWith(
            balance: to.balance + transaction.amount, updated: DateTime.now());
        print("4.1");
        print("new deposit transaction ${transaction.toAccountUuid}: final balance: ${to.balance}");
        await _moneyAccountRepository.update(to, context);
      }
      return;
    });
    print("4");
    return transaction;
  }
}
