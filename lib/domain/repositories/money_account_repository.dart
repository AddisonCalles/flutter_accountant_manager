import 'package:accountant_manager/domain/entities/money_account.dart';
import 'package:accountant_manager/domain/entities/money_account_filter.dart';
import 'package:accountant_manager/domain/entities/money_transaction.dart';
import 'package:accountant_manager/domain/ports/data_transaction_port.dart';

abstract class MoneyAccountRepository<Context> {
  Future<MoneyAccount> getByUUID(String uuid, Context? context);
  Future<List<MoneyAccount>> search(MoneyAccountFilter filter, Context? context);
  Future<bool> create(MoneyAccount moneyAccount, Context? context);
  Future<bool> update(MoneyAccount moneyAccount, Context? context);
}