import 'package:flutter/cupertino.dart';

abstract class StateFulFormStep extends StatefulWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool validate(){
    return formKey.currentState!.validate();
  }

  StateFulFormStep({Key? key}): super(key: key ?? GlobalKey<State<StateFulFormStep>>());


  static State<StateFulFormStep>? of(BuildContext context) {
    return context.findAncestorStateOfType<State<StateFulFormStep>>();
  }
}