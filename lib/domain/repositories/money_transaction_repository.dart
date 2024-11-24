

import 'package:accountant_manager/domain/entities/money_transaction.dart';

abstract class MoneyTransactionRepository {
  Future<MoneyTransaction> getByUUID(String uuid);
  Future<List<MoneyTransaction>> search();
  Future<bool> create(MoneyTransaction moneyTransaction);
  Future<bool> update(MoneyTransaction moneyTransaction);
}