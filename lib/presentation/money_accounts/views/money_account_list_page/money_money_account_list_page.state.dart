import 'package:accountant_manager/presentation/money_accounts/bloc/events/search_money_account_event.dart';
import 'package:accountant_manager/presentation/money_accounts/bloc/money_account_state.dart';
import 'package:accountant_manager/presentation/money_accounts/views/money_account_list_page/money_money_account_list_page.dart';
import 'package:accountant_manager/presentation/money_accounts/widgets/money_account_bank_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:accountant_manager/presentation/Layouts/MainLayout/main_layout.dart';
import 'package:accountant_manager/presentation/money_accounts/bloc/money_account_bloc.dart';

class MoneyAccountListPageState extends State<MoneyAccountListPage> {
  @override
  void initState() {
    super.initState();
    print("LOAD INGREDIENTS");
    // Carga los datos iniciales aquí
    context.read<MoneyAccountBloc>().add(const SearchMoneyAccountEvent.clean());
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Cuentas \$',
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/money_accounts/add').then((value) =>
              context
                  .read<MoneyAccountBloc>()
                  .add(const SearchMoneyAccountEvent.clean()));
        },
        backgroundColor: Colors.pink,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      child: BlocBuilder<MoneyAccountBloc, MoneyAccountState>(
          builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.moneyAccounts.isEmpty) {
          return const Center(
            child: Text("Cuentas no disponibles"),
          );
        }
        return ListView.builder(
            itemCount: state.moneyAccounts.length,
            itemBuilder: (context, index) {
              final account = state.moneyAccounts[index];
              return MoneyAccountBankCardWidget(account: account,
              onDelete: (account) => {
              },
              onEdit: (account)=>{
              });
            });
      }),
    );
  }
}
