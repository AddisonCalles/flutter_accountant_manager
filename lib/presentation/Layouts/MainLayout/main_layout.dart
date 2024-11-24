import 'package:flutter/material.dart';
import 'package:accountant_manager/presentation/commons/drawer_menu.dart';
import 'package:accountant_manager/presentation/commons/menu_appbar.dart';

class MainLayout extends StatelessWidget {
  String title;
  Widget child;
  Widget? floatingActionButton;
  Widget? bottomNavigationBar;
  FloatingActionButtonLocation? floatingActionButtonLocation;
  MainLayout(
      {super.key,
      required this.title,
      required this.child,
      this.floatingActionButton,
      this.bottomNavigationBar,
      this.floatingActionButtonLocation});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MenuAppBar(title: title),
        drawer:  DrawerMenu(),
        floatingActionButtonLocation: floatingActionButtonLocation,
        bottomNavigationBar: bottomNavigationBar,
        floatingActionButton: floatingActionButton,
        body: Container(padding: const EdgeInsets.all(4), child: child)
        /*floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),*/ // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
