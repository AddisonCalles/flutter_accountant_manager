import 'package:accountant_manager/application/ports/uuid_generator.dart';
import 'package:accountant_manager/domain/entities/money_account.dart';
import 'package:accountant_manager/domain/entities/money_account_filter.dart';
import 'package:accountant_manager/domain/repositories/money_account_repository.dart';
import 'package:accountant_manager/domain/usecases/money_account/create_money_account_usecase.dart';
import 'package:accountant_manager/domain/usecases/money_account/search_money_account_usecase.dart';

class SearchMoneyAccountUseCaseImp implements SearchMoneyAccountUseCase {
  final MoneyAccountRepository repository;
  final UUIDGenerator uuidGenerator;

  const SearchMoneyAccountUseCaseImp({required this.repository, required this.uuidGenerator});

  @override
  Future<List<MoneyAccount>> execute(MoneyAccountFilter query) {
      return repository.search(query, null);
  }
}
