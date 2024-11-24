import 'package:flutter/material.dart';
import 'package:accountant_manager/presentation/pages/home_page/home_page.state.dart';

class HomePage extends StatefulWidget {

  const HomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  final String title;
  @override
  State createState() =>  HomePageState();
}
