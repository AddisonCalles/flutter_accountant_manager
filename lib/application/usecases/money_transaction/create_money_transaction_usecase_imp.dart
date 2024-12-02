

import 'package:accountant_manager/application/ports/uuid_generator.dart';
import 'package:accountant_manager/domain/entities/money_transaction.dart';
import 'package:accountant_manager/domain/repositories/money_transaction_repository.dart';
import 'package:accountant_manager/domain/usecases/money_transaction/create_money_transaction_usecase.dart';

class CreateMoneyTransactionUseCaseImpl implements CreateMoneyTransactionUseCase{
  final MoneyTransactionRepository _repository;
  final UUIDGenerator _uuidGenerator;
  CreateMoneyTransactionUseCaseImpl({required MoneyTransactionRepository repository,
    required UUIDGenerator uuidGenerator}): _repository = repository, _uuidGenerator = uuidGenerator;

  @override
  Future<MoneyTransaction> execute(MoneyTransaction moneyTransaction) async {
    String uuid = _uuidGenerator.generate();
    moneyTransaction = moneyTransaction.copyWith(uuid: uuid, created: DateTime.now());
    await _repository.create(moneyTransaction);

    return moneyTransaction;
  }
}