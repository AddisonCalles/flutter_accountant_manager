import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:accountant_manager/presentation/money_accounts/bloc/events/remove_selection_to_edit_money_account_event.dart';
import 'package:accountant_manager/presentation/money_accounts/bloc/money_account_bloc.dart';


class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});


  void _gotoMenuOption(BuildContext context, String route) {
    Navigator.of(context).pushNamedAndRemoveUntil(route, (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: const Text(
              'Finanzas',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Inicio'),
            onTap: () {
              _gotoMenuOption(context, '/');
            },
          ),
          const Divider(),

          ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: const Text('Cuentas'),
            onTap: () {
              _gotoMenuOption(context, '/money_accounts');
            },
          ),
          /*ListTile(
            leading: const Icon(Icons.store_mall_directory),
            title: const Text('Transacciones'),
            onTap: () {
              context.read<MoneyAccountBloc>().add(const RemoveSelectionToEditMoneyAccountEvent());
              _gotoMenuOption(context, '/money_transactions');
            },
          ),*/
        ],
      ),
    );
  }
}
