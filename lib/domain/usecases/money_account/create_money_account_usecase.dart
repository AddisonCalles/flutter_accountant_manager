  import 'package:accountant_manager/domain/entities/money_account.dart';

abstract class CreateMoneyAccountUseCase {
  Future<MoneyAccount> execute(MoneyAccount account);
}
