import 'dart:async';

import 'package:accountant_manager/presentation/commons/interfaces/item_list.dart';
import 'package:accountant_manager/presentation/money_accounts/bloc/money_account_bloc.dart';
import 'package:accountant_manager/presentation/money_accounts/bloc/money_account_state.dart';
import 'package:accountant_manager/presentation/commons/list_search_selector_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListSearchSelectorDropDown<ValueType> extends StatefulWidget {
  ItemList<ValueType>? selected;
  final void Function(ItemList<ValueType> bank) onSelected;
  final List<ItemList<ValueType>> items;
  final InputDecoration? decoration;

  ListSearchSelectorDropDown(
      {super.key, bool? validated, required this.onSelected, required this.items,  this.decoration, this.selected});

  @override
  ListSearchSelectorDropDownState<ValueType> createState() =>
      ListSearchSelectorDropDownState<ValueType>();
}

class ListSearchSelectorDropDownState<T>
    extends State<ListSearchSelectorDropDown<T>> {
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textController.text =
    widget.selected != null ? widget.selected!.title : '';
  }

  void validate() {
    setState(() {
    });
  }

  @override
  void dispose() {
    // Asegúrate de liberar el controlador cuando el widget se destruya
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoneyAccountBloc, MoneyAccountState>(
        builder: (context, state) {
          return
            TextFormField(
                readOnly: true,
                //keyboardType: TextInputType.none,
                // autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: widget.decoration,
                controller: _textController,

                onSaved: (String? value) {
                  /*if (value != null &&
                      value.isNotEmpty &&
                      value != '0') {
                      setState(() {
                      moneyAccount = moneyAccount
                          .copyWith(balance: double.parse(value));
                      });
                      }*/
                },
                onTap: () => {_showIngredientsModal(context)},
                //make price validation
                validator: (value) {
                  if (value == null || value.isEmpty || value == '0') {
                    return 'Este campo es requerido';
                  }

                  return null;
                });
        });
  }

  void _showIngredientsModal(BuildContext context) async {
    Completer<ItemList<dynamic>> completer = Completer<ItemList<dynamic>>();

    await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      sheetAnimationStyle: AnimationStyle(
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 500),
        reverseCurve: Curves.easeInOut,
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: ListSearchSelectorView<T>(
            selected: widget.selected,
            listItems: widget.items,
            onSelected: (item) {
              completer.complete(
                  item); // Pasamos los valores seleccionados al Completer
              Navigator.pop(context); // Cerramos el modal
            },
          ),
        );
      },
    );

    // Esperamos el valor del Completer
    ItemList item = await completer.future;

    // Actualizamos el estado de la pantalla con los nuevos valores
    setState(() {
      widget.onSelected(ItemList<T>(item.title, item.value,
          item.data)); // Pasamos el primer valor seleccionado al padre

      _textController.text =
          item.title; // Actualizamos el valor del campo de texto
    });
  }
}

