

import 'package:accountant_manager/application/ports/uuid_generator.dart';
import 'package:accountant_manager/domain/entities/money_transaction.dart';
import 'package:accountant_manager/domain/exceptions/invalid_money_transaction.dart';
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

    if (moneyTransaction.fromAccountUuid == null && moneyTransaction.toAccountUuid == null) {
      throw InvalidMoneyTransaction("La transacción debe tener una cuenta de origen o destino");
    }

    if (moneyTransaction.amount <= 0) {
      throw InvalidMoneyTransaction("El monto de la transacción debe ser mayor a 0");
    }

    moneyTransaction = moneyTransaction.copyWith(uuid: uuid, created: DateTime.now());
    await _repository.create(moneyTransaction, null);
    return moneyTransaction;
  }
}