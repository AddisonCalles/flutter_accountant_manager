import 'package:accountant_manager/domain/entities/money_transaction.dart';
import 'package:accountant_manager/domain/entities/money_transaction_filter.dart';
import 'package:accountant_manager/domain/repositories/money_transaction_repository.dart';
import 'package:accountant_manager/domain/usecases/money_transaction/search_money_transaction_usecase.dart';

class SearchMoneyTransactionUsecaseImp implements SearchMoneyTransactionUseCase {
  final MoneyTransactionRepository repository;

  SearchMoneyTransactionUsecaseImp({required this.repository});

  @override
  Future<List<MoneyTransaction>> execute(MoneyTransactionFilter query) async {
    return await repository.search(query, null);
  }
}