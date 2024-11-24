import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {

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
              'Punto de venta',
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
          ListTile(
            leading: const Icon(Icons.store_mall_directory),
            title: const Text('Transacciones'),
            onTap: () {
              _gotoMenuOption(context, '/money_transactions');
            },
          ),
          ListTile(
            leading: const Icon(Icons.inventory),
            title: const Text('Productos'),
            onTap: () {
              _gotoMenuOption(context, '/edibles');
            },
          ),
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text('Configuraciones'),
            onTap: () {

            },
          ),
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text('Clientes'),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Clientes - En construcción'),
                  showCloseIcon: true,
                  backgroundColor: Colors.redAccent,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
