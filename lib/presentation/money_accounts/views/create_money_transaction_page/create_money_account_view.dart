import 'package:accountant_manager/domain/values/money_transaction_status.dart';
import 'package:accountant_manager/presentation/money_accounts/views/create_money_transaction_page/create_money_account_view.state.dart';
import 'package:flutter/material.dart';


class CreateMoneyAccountPage extends StatefulWidget {
  final List<MoneyTransactionStatus> moneyTransactionCategories = const [
    MoneyTransactionStatus.cancelled,
    MoneyTransactionStatus.completed,
    MoneyTransactionStatus.pending,
  ];


  const CreateMoneyAccountPage({super.key});

  @override
  State<CreateMoneyAccountPage> createState() =>  CreateMoneyAccountPageState();
}

