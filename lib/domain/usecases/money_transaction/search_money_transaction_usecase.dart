

import 'package:accountant_manager/domain/entities/money_transaction.dart';
import 'package:accountant_manager/domain/entities/money_transaction_filter.dart';
import 'package:accountant_manager/domain/repositories/money_account_repository.dart';

abstract class SearchMoneyTransactionUseCase {
  SearchMoneyTransactionUseCase(MoneyAccountRepository repository);
  Future<List<MoneyTransaction>> execute(MoneyTransactionFilter query);
}