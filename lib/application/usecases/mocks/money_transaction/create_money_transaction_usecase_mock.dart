import 'package:accountant_manager/domain/entities/money_transaction.dart';
import 'package:accountant_manager/domain/usecases/money_transaction/create_money_transaction_usecase.dart';

class CreateMoneyTransactionUseCaseMock
    implements CreateMoneyTransactionUseCase {
  @override
  Future<MoneyTransaction> execute(MoneyTransaction moneyTransaction) {
    return Future.value(moneyTransaction.copyWith(
      created: DateTime.now(),
    ));
  }
}
