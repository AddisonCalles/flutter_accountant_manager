

import 'package:accountant_manager/domain/entities/money_transaction.dart';
import 'package:accountant_manager/domain/entities/money_transaction_filter.dart';

abstract class MoneyTransactionRepository<Context> {
  Future<MoneyTransaction> getByUUID(String uuid);
  Future<List<MoneyTransaction>> search(MoneyTransactionFilter filter, Context? context);
  Future<bool> create(MoneyTransaction moneyTransaction, Context? context);
  Future<bool> update(MoneyTransaction moneyTransaction, Context? context);
}