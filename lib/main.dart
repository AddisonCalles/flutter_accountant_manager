import 'package:accountant_manager/application/usecases/mocks/money_account/create_money_account_usecase_mock.dart';
import 'package:accountant_manager/application/usecases/mocks/money_account/search_money_account_usecase_mock.dart';
import 'package:accountant_manager/domain/entities/money_account.dart';
import 'package:accountant_manager/domain/entities/money_transaction.dart';
import 'package:accountant_manager/domain/entities/money_transaction_filter.dart';
import 'package:accountant_manager/domain/repositories/money_transaction_repository.dart';
import 'package:accountant_manager/domain/usecases/money_account/create_money_account_usecase.dart';
import 'package:accountant_manager/domain/usecases/money_transaction/create_money_transaction_usecase.dart';
import 'package:accountant_manager/domain/usecases/money_transaction/search_money_transaction_usecase.dart';
import 'package:accountant_manager/domain/values/money_transaction_status.dart';
import 'package:accountant_manager/presentation/main.app.dart';
import 'package:flutter/material.dart';

import 'package:sqflite/sqflite.dart';

class CreateMoneyTransactionUseCaseMock
    implements CreateMoneyTransactionUseCase {
  @override
  Future<MoneyTransaction> execute(MoneyTransaction moneyTransaction) {
    return Future.value(moneyTransaction.copyWith(
      created: DateTime.now(),
    ));
  }
}



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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // GENERATORS
  // UUIDGenerator uuidGenerator = UUIDDartGenerator();

  //DatabasePort<Database> database = SQLiteDatabaseFactory.getInstance();

  // REPOSITORIES

  runApp(MyApp(
    createMoneyTransactionUseCase: CreateMoneyTransactionUseCaseMock(),
    searchMoneyTransactionUseCase: SearchMoneyTransactionUseCaseMock(),
    createMoneyAccountUseCase: CreateMoneyAccountUseCaseMock(),
    searchMoneyAccountUseCase: SearchMoneyAccountUseCaseMock(),
  ));
}
