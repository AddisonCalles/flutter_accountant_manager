  import 'package:accountant_manager/domain/entities/money_account.dart';
import 'package:accountant_manager/domain/repositories/money_account_repository.dart';

abstract class CreateMoneyAccountUseCase {
  CreateMoneyAccountUseCase(MoneyAccountRepository repository);
  Future<MoneyAccount> execute(MoneyAccount account);
}
