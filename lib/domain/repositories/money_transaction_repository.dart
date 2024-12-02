

import 'package:accountant_manager/domain/entities/money_transaction.dart';
import 'package:accountant_manager/domain/entities/money_transaction_filter.dart';
import 'package:accountant_manager/domain/repositories/money_account_repository.dart';

abstract class MoneyTransactionRepository {
  Future<MoneyTransaction> getByUUID(String uuid);
  Future<List<MoneyTransaction>> search(MoneyTransactionFilter filter);
  Future<bool> create(MoneyTransaction moneyTransaction);
  Future<bool> update(MoneyTransaction moneyTransaction);
}