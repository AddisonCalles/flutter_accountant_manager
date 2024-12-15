import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:accountant_manager/domain/entities/money_account.dart';
import 'package:accountant_manager/presentation/money_accounts/bloc/money_account_bloc.dart';
import 'package:accountant_manager/presentation/money_accounts/bloc/money_account_state.dart';
import 'package:accountant_manager/presentation/money_accounts/widgets/money_account_bank_card.dart';
import 'package:accountant_manager/presentation/Layouts/MainLayout/main_layout.dart';
import 'package:accountant_manager/presentation/money_transactions/bloc/events/search_money_transaction_event.dart';
import 'package:accountant_manager/presentation/money_transactions/bloc/money_transaction_bloc.dart';
import 'package:accountant_manager/presentation/money_transactions/bloc/money_transaction_state.dart';
import 'package:accountant_manager/presentation/money_transactions/views/money_transaction_list_page/money_transaction_list_page.dart';

class MoneyTransactionListPageState extends State<MoneyTransactionListPage> {
  @override
  void initState() {
    print("LOAD INGREDIENTS");

    context
        .read<MoneyTransactionBloc>()
        .add(const SearchMoneyTransactionEvent.clean());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Datos de ejemplo para la cuenta seleccionada
    // Carga los datos iniciales aquí

    return BlocBuilder<MoneyAccountBloc, MoneyAccountState>(
        builder: (context, moneyAccountState) {
      final MoneyAccount? selectedAccount = moneyAccountState.selectedToEdit;
      final int offsetAccount = selectedAccount == null ? 0 : 1;
      return MainLayout(
        title: 'Transacciones',
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            SearchMoneyTransactionEvent event =
                const SearchMoneyTransactionEvent.clean();

            if (offsetAccount == 1) {
              event =
                  SearchMoneyTransactionEvent.byAccount(selectedAccount!.uuid!);
            }
            Navigator.pushNamed(context, '/money_transaction/add').then(
                (value) => context.read<MoneyTransactionBloc>().add(event));
          },
          backgroundColor: Colors.pink,
          child: const Icon(Icons.add, color: Colors.white),
        ),
        child: BlocBuilder<MoneyTransactionBloc, MoneyTransactionState>(
          builder: (context, transactionState) {
            if (transactionState.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            final transactions = transactionState.moneyTransactions;

            return ListView.builder(
              itemCount: transactions.isEmpty
                  ? offsetAccount
                  : transactions.length + offsetAccount,
              itemBuilder: (context, index) {
                // Si el índice es 0, muestra el contenedor con los datos de la cuenta
                if (index == 0 && offsetAccount == 1) {
                  return MoneyAccountBankCardWidget(
                      account: selectedAccount!,
                      onTouch: (MoneyAccount _) => {},
                      onDelete: (MoneyAccount _) => {});
                }

                // Lista de transacciones
                final transaction = transactions[index - offsetAccount];

                final deposit = transaction.toAccountUuid == selectedAccount?.uuid;
                return Card(
                  key: ValueKey(transaction.uuid),
                  child: ListTile(
                    leading: Container(
                      margin: const EdgeInsets.only(right: 0),
                      width: 30,
                      height: 30,
                      child:  Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(deposit ? Icons.add_circle : Icons.remove_circle, color: deposit?Colors.green : Colors.red, size: 20)
                        ],
                      ),
                    ),
                    title: Text("${deposit ? "+": "-"} \$ ${transaction.amount} \t"),
                    subtitle: Text(
                        "${transaction.concept} \n${transaction.status.toText()}\n ${transaction.updated?.toLocal().toString().split(".")[0]}"),
                    trailing: const Icon(Icons.more_vert),
                  ),
                );
              },
            );
          },
        ),
      );
    });
  }
}
