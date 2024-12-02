import 'package:accountant_manager/application/ports/database_port.dart';
import 'package:accountant_manager/application/ports/uuid_generator.dart';
import 'package:accountant_manager/application/usecases/mocks/money_account/create_money_account_usecase_mock.dart';
import 'package:accountant_manager/application/usecases/mocks/money_account/search_money_account_usecase_mock.dart';
import 'package:accountant_manager/application/usecases/mocks/money_transaction/search_money_transaction_usecase_mock.dart';
import 'package:accountant_manager/application/usecases/money_account/create_money_transaction_usecase_imp.dart';
import 'package:accountant_manager/domain/repositories/money_transaction_repository.dart';
import 'package:accountant_manager/infrastructure/adapters/uuid_dart_generator.dart';
import 'package:accountant_manager/infrastructure/sqlite/sqlite_database_factory.dart';
import 'package:accountant_manager/infrastructure/sqlite/sqlite_repositories/money_account_sqlite_repository.dart';
import 'package:accountant_manager/infrastructure/sqlite/sqlite_repositories/money_transaction_sqlite_repository.dart';
import 'package:accountant_manager/presentation/main.app.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DatabasePort<Database> database = SQLiteDatabaseFactory.getInstance();
  // GENERATORS
  UUIDGenerator uuidGenerator = UUIDDartGenerator();

  // REPOSITORIES
  MoneyTransactionRepository moneyTransactionRepository =
      MoneyTransactionSqliteRepository(database);

  MoneyAccountSqliteRepository moneyAccountRepository =
      MoneyAccountSqliteRepository(database);

  // USE CASES
  CreateMoneyTransactionUseCaseImpl createMoneyAccountUseCase =
      CreateMoneyTransactionUseCaseImpl(
          uuidGenerator: uuidGenerator, repository: moneyTransactionRepository);

  runApp(MyApp(
    createMoneyTransactionUseCase: createMoneyAccountUseCase,
    searchMoneyTransactionUseCase: SearchMoneyTransactionUseCaseMock(),
    createMoneyAccountUseCase: CreateMoneyAccountUseCaseMock(),
    searchMoneyAccountUseCase: SearchMoneyAccountUseCaseMock(),
  ));
}
