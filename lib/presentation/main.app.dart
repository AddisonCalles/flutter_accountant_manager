import 'package:accountant_manager/domain/usecases/money_account/create_money_account_usecase.dart';
import 'package:accountant_manager/domain/usecases/money_account/search_money_account_usecase.dart';
import 'package:accountant_manager/domain/usecases/money_transaction/create_money_transaction_usecase.dart';
import 'package:accountant_manager/domain/usecases/money_transaction/search_money_transaction_usecase.dart';
import 'package:accountant_manager/presentation/main.routes.dart';
import 'package:accountant_manager/presentation/money_accounts/bloc/money_account_bloc.dart';
import 'package:accountant_manager/presentation/money_transactions/bloc/money_transaction_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  final Map<String, Widget Function(BuildContext)> mainRoutes =
  MainRoutesFactory.getRoutes();


  CreateMoneyTransactionUseCase createMoneyTransactionUseCase;
  SearchMoneyTransactionUseCase searchMoneyTransactionUseCase;
  CreateMoneyAccountUseCase createMoneyAccountUseCase;
  SearchMoneyAccountUseCase searchMoneyAccountUseCase;

  MyApp(
      {super.key,
        required this.createMoneyTransactionUseCase,
        required this.searchMoneyTransactionUseCase,
        required this.createMoneyAccountUseCase,
        required this.searchMoneyAccountUseCase
      });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<MoneyTransactionBloc>(
            create: (context) => MoneyTransactionBloc(
                createMoneyTransactionUseCase: createMoneyTransactionUseCase,
                searchAccountUseCase: searchMoneyTransactionUseCase),
          ),
          BlocProvider<MoneyAccountBloc>(
            create: (context) => MoneyAccountBloc(
                createMoneyAccountUseCase: createMoneyAccountUseCase,
                searchMoneyAccountUseCase: searchMoneyAccountUseCase),
          ),
        ],
        child: MaterialApp(
          routes: mainRoutes,
          title: 'Punto de venta',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            useMaterial3: true,
          ),
        ));
  }
}
