import 'package:accountant_manager/domain/entities/money_account.dart';
import 'package:accountant_manager/domain/entities/money_transaction.dart';
import 'package:accountant_manager/domain/exceptions/invalid_money_transaction.dart';
import 'package:accountant_manager/domain/ports/data_transaction_port.dart';
import 'package:accountant_manager/domain/repositories/money_account_repository.dart';
import 'package:accountant_manager/domain/repositories/money_transaction_repository.dart';
import 'package:accountant_manager/domain/usecases/money_account/transfer_amount_money_account_usecase.dart';
import 'package:accountant_manager/domain/values/account_types.dart';
import 'package:accountant_manager/domain/values/money_transaction_status.dart';

class TransferAmountMoneyAccountUsecaseMock
    implements TransferAmountMoneyAccountUsecase {

  TransferAmountMoneyAccountUsecaseMock();

  @override
  Future<MoneyTransaction> execute(MoneyTransaction transaction) async {
      return transaction.copyWith(
        status: MoneyTransactionStatus.completed,
        updated: DateTime.now(),
      );
  }
}
