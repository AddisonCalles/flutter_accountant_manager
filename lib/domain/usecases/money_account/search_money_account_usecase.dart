

import 'package:accountant_manager/domain/entities/money_account.dart';
import 'package:accountant_manager/domain/entities/money_account_filter.dart';
import 'package:accountant_manager/domain/repositories/money_account_repository.dart';

abstract class SearchMoneyAccountUseCase {
  SearchMoneyAccountUseCase(MoneyAccountRepository repository);
  Future<List<MoneyAccount>> execute(MoneyAccountFilter query);
}