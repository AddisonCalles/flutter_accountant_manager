import 'package:accountant_manager/domain/entities/money_account.dart';
import 'package:accountant_manager/domain/entities/money_account_filter.dart';

abstract class MoneyAccountRepository {
  Future<MoneyAccount> getByUUID(String uuid);
  Future<List<MoneyAccount>> search(MoneyAccountFilter filter);
  Future<bool> create(MoneyAccount moneyAccount);
  Future<bool> update(MoneyAccount moneyAccount);
}