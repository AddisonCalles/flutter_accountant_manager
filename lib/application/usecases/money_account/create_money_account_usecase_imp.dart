import 'package:accountant_manager/application/ports/uuid_generator.dart';
import 'package:accountant_manager/domain/entities/money_account.dart';
import 'package:accountant_manager/domain/repositories/money_account_repository.dart';
import 'package:accountant_manager/domain/usecases/money_account/create_money_account_usecase.dart';

class CreateMoneyAccountUseCaseMock implements CreateMoneyAccountUseCase {
  final MoneyAccountRepository repository;
  final UUIDGenerator uuidGenerator;

  CreateMoneyAccountUseCaseMock({required this.repository, required this.uuidGenerator});

  @override
  Future<MoneyAccount> execute(MoneyAccount moneyAccount) async {
    String uuid = uuidGenerator.generate();
    moneyAccount = moneyAccount.copyWith(uuid: uuid, created: DateTime.now());
    await repository.create(moneyAccount);
    return moneyAccount;
  }
}
