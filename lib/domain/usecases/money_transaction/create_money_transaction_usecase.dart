import 'package:accountant_manager/domain/entities/money_transaction.dart';
import 'package:accountant_manager/domain/repositories/money_account_repository.dart';

abstract class CreateMoneyTransactionUseCase {
  CreateMoneyTransactionUseCase(MoneyAccountRepository repository);
  Future<MoneyTransaction> execute(MoneyTransaction moneyTransaction);
}
