import 'package:flutter/material.dart';
import 'package:accountant_manager/presentation/Layouts/MainLayout/main_layout.dart';
import 'package:accountant_manager/presentation/commons/main_menu_button.dart';
import 'package:accountant_manager/presentation/pages/home_page/home_page.dart';

class HomePageState extends State<HomePage> {

  void _gotoMenuOption(BuildContext context, String routeName) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
    Navigator.pushNamed(context, routeName);
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: "Punto de Venta",
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(10),
              children: [
                MainMenuButton(
                  icon: Icons.store_mall_directory_sharp,
                  label: 'Transactions',
                  onPressed: () {
                    _gotoMenuOption(context, '/money_transactions');
                  },
                ),
                MainMenuButton(
                  icon: Icons.add_business_outlined,
                  label: 'Settings',
                  onPressed: () {
                    _gotoMenuOption(context, '/settings');
                  },
                ),
              ]),
        ],
      )),
    );
  }
}
