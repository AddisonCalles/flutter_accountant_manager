import 'package:accountant_manager/domain/entities/money_account.dart';
import 'package:accountant_manager/domain/entities/money_account_filter.dart';
import 'package:accountant_manager/domain/usecases/money_account/search_money_account_usecase.dart';
import 'package:accountant_manager/domain/values/account_types.dart';
import 'package:accountant_manager/domain/values/banks.dart';

class SearchMoneyAccountUseCaseMock implements SearchMoneyAccountUseCase {
  @override
  Future<List<MoneyAccount>> execute(MoneyAccountFilter query) {
    return Future.value([
      MoneyAccount(
        balance: 5000,
        title: 'Cuenta nómina',
        uuid: '1',
        bank: Banks.banamex,
        created: DateTime.now(),
        accountType: MoneyAccountTypes.debitCard,
        accountNumber: '245656234554566',
      ),
      MoneyAccount(
        balance: 56300,
        title: 'Mercado pago Debito',
        uuid: '2',
        bank: Banks.mercadoPago,
        created: DateTime.now(),
        accountType: MoneyAccountTypes.debitCard,
        accountNumber: '245656234554566',
      ),
    ]);
  }
}
