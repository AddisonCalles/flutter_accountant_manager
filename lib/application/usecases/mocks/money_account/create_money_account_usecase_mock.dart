import 'package:accountant_manager/domain/entities/money_account.dart';
import 'package:accountant_manager/domain/usecases/money_account/create_money_account_usecase.dart';

class CreateMoneyAccountUseCaseMock
    implements CreateMoneyAccountUseCase {
  @override
  Future<MoneyAccount> execute(MoneyAccount item) {
    return Future.value(item.copyWith(
      created: DateTime.now(),
    ));
  }
}