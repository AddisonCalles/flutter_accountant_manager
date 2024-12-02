import 'package:accountant_manager/presentation/money_accounts/views/create_money_transaction_page/create_money_account_view.dart';
import 'package:accountant_manager/presentation/money_accounts/views/money_account_list_page/money_money_account_list_page.dart';
import 'package:accountant_manager/presentation/money_transactions/views/create_money_transaction_page/create_money_transaction_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:accountant_manager/presentation/money_transactions/views/money_transaction_list_page/money_transaction_list_page.dart';

class MainRoutesFactory {


  static Map<String, Widget Function(BuildContext)> getRoutes(){

    return {
      '/':(context)=> const MoneyAccountListPage(key: Key('money_account_list_page')),
      // '/ingredients/add':(context)=> IngredientCreatePage(title: 'Agregar ingrediente', colorAdapter: colorAdapter),
      '/money_accounts':(context)=>  const MoneyAccountListPage(key: Key('money_account_list_page')),
      '/money_accounts/add':(context)=>  const CreateMoneyAccountPage(key: Key('create_money_account_page')),
      '/money_transactions':(context)=>  const MoneyTransactionListPage(key: Key('money_transaction_list_page')),
      '/money_transaction/add':(context)=>  const CreateMoneyTransactionPage(key: Key('create_money_transaction_page')),
    };
  }
}