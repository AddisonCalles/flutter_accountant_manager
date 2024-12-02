import 'package:accountant_manager/domain/values/money_transaction_status.dart';
import 'package:accountant_manager/presentation/money_transactions/views/create_money_transaction_page/create_money_transaction_view.state.dart';
import 'package:flutter/material.dart';


class CreateMoneyTransactionPage extends StatefulWidget {
  final List<MoneyTransactionStatus> moneyTransactionCategories = const [
    MoneyTransactionStatus.cancelled,
    MoneyTransactionStatus.completed,
    MoneyTransactionStatus.pending,
  ];

  const CreateMoneyTransactionPage({super.key});

  @override
  State<CreateMoneyTransactionPage> createState() =>  CreateMoneyTransactionPageState();
}

