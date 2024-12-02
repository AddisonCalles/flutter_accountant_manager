import 'package:accountant_manager/domain/entities/money_transaction.dart';
import 'package:accountant_manager/domain/entities/money_transaction_filter.dart';
import 'package:accountant_manager/domain/usecases/money_transaction/search_money_transaction_usecase.dart';
import 'package:accountant_manager/domain/values/money_transaction_status.dart';

class SearchMoneyTransactionUseCaseMock
    implements SearchMoneyTransactionUseCase {
  @override
  Future<List<MoneyTransaction>> execute(MoneyTransactionFilter query) {
    return Future.value([
      MoneyTransaction(
        amount: 100,
        fromAccountUuid: 'uuids',
        status: MoneyTransactionStatus.completed,
        uuid: '2',
        concept: 'Pago de servicio de internet totalplay',
        created: DateTime.now(),
        spentUuid: 'uuids',
      ),
      MoneyTransaction(
        amount: 200,
        fromAccountUuid: 'uuids',
        status: MoneyTransactionStatus.completed,
        uuid: '2',
        concept: 'Compra de medicamentos farmancia guadalajara',
        created: DateTime.now(),
        spentUuid: 'uuids',
      ),
    ]);
  }
}