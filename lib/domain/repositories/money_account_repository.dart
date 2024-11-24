import 'package:accountant_manager/domain/entities/money_account.dart';
import 'package:accountant_manager/domain/entities/money_transaction.dart';
import 'package:accountant_manager/domain/repositories/money_transaction_repository.dart';

abstract class MoneyAccountRepository {
  MoneyAccountRepository(MoneyTransactionRepository repository);
  Future<MoneyAccount> getByUUID(String uuid);
  Future<List<MoneyAccount>> list();
  Future<bool> create(MoneyAccount moneyAccount);
  Future<bool> createTransaction(MoneyTransaction moneyTransaction);
}