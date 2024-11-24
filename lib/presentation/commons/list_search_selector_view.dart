import 'package:accountant_manager/presentation/money_accounts/bloc/money_account_bloc.dart';
import 'package:accountant_manager/presentation/money_accounts/bloc/money_account_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:accountant_manager/presentation/commons/search_list.dart';
class ItemList<T> {
  final String title;
  final T value;

  const ItemList(this.title, this.value);

}

class ListSearchSelectorView<T> extends StatefulWidget {
  final List<ItemList<T>> listItems;
  List<ItemList<T>> filteredList;
  ItemList<T>? selected;
  void Function(ItemList<dynamic>) onSelected;

  ListSearchSelectorView({super.key,required this.onSelected, required this.listItems, this.selected}): filteredList = listItems;

  @override
  State<ListSearchSelectorView> createState() =>  ListSearchSelectorViewState();

}



class ListSearchSelectorViewState extends State<ListSearchSelectorView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoneyAccountBloc, MoneyAccountState>(
        builder: (context, state) {
      return SearchList(
        finishButton: state.selected.isNotEmpty,
        listItems: widget.filteredList,
        onSearchChanged: (query) {
          setState(() {
            widget.filteredList = widget.listItems
                .where((element) => element.title
                    .toLowerCase()
                    .contains(query.toLowerCase()))
                .toList();
          });
        },
        itemBuilder: (context, item, index) {
          final isSelected =  widget.selected == item.value;
          final textStyle =
              TextStyle(color: isSelected ? Colors.blue[700] : null);
          return ListTile(
            title: Text(item.title, style: textStyle),
            //tileColor:
            leading: Icon(
              isSelected ? Icons.check_circle : Icons.circle,
              color: isSelected ? Colors.green : Colors.black12,
            ),
            onTap: () {
              // ejecute on selected
              print("item selected -1: ${item.title}");
              widget.onSelected(item);
            },
          );
        },
      );
    });
  }
}
