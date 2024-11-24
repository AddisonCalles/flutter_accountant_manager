import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:accountant_manager/presentation/Layouts/MainLayout/main_layout.dart';
import 'package:accountant_manager/presentation/money_transactions/bloc/events/search_money_transaction_event.dart';
import 'package:accountant_manager/presentation/money_transactions/bloc/money_transaction_bloc.dart';
import 'package:accountant_manager/presentation/money_transactions/bloc/money_transaction_state.dart';
import 'package:accountant_manager/presentation/money_transactions/views/money_transaction_list_page/money_transaction_list_page.dart';

class MoneyTransactionListPageState extends State<MoneyTransactionListPage> {


  @override
  void initState() {
    super.initState();
    print("LOAD INGREDIENTS");
    // Carga los datos iniciales aquí
    context.read<MoneyTransactionBloc>().add(const SearchMoneyTransactionEvent.clean());
  }

  @override
  Widget build(BuildContext context) {

    return MainLayout(
      title: 'Transacciones',
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/money_transaction/add').then((value) =>
              context.read<MoneyTransactionBloc>().add(const SearchMoneyTransactionEvent.clean()));
        },
        backgroundColor: Colors.pink,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      child: BlocBuilder<MoneyTransactionBloc, MoneyTransactionState>(
          builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.moneyTransactions.isEmpty) {
          return const Center(
            child: Text("No transacciones disponibles"),
          );
        }
        return ListView.builder(
            itemCount: state.moneyTransactions.length,
            itemBuilder: (context, index) {
              final transaction = state.moneyTransactions[index];
              return Card(
                key: ValueKey(transaction.uuid),
                child: ListTile(
                  leading: Container(
                      margin: const EdgeInsets.only(right: 0),
                      width: 30,
                      height: 30,
                      /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(20),

                      ),*/
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [Icon(Icons.remove_circle, color: Colors.red, size: 20)],)),
                  title: Text("+ \$ ${transaction.amount} \t"),
                  subtitle: Text("${transaction.concept} \n${transaction.status.toText()}"),
                  trailing: const Icon(Icons.more_vert),
                ),
              );
            });
      }),
    );
  }
}