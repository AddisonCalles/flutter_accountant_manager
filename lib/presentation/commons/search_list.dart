import 'package:flutter/material.dart';
import 'package:accountant_manager/presentation/commons/search_bar_field.dart';
class SearchList<T> extends StatelessWidget {
  final List<T> listItems;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final ValueChanged<String>? onSearchChanged;
  final String? pleaseHolder;
  final bool finishButton;

  const SearchList(
      {Key? key,
      required this.listItems,
      required this.itemBuilder,
      this.finishButton = false,
      this.pleaseHolder,
      this.onSearchChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SearchBarField(onSearchChanged: onSearchChanged, pleaseHolder: pleaseHolder),
      if(finishButton) FilledButton.tonal(
          onPressed: () => (Navigator.pop(context)),
          style: ButtonStyle(
            fixedSize: MaterialStateProperty.all<Size>(const Size(8000, 40)),
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.lightBlueAccent),
          ),
          child: Text("Completar")),
      Expanded(
        child: SingleChildScrollView(
          child: ListView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: listItems.length,
            itemBuilder: (context, index) {
              final item = listItems[index];
              return itemBuilder(context, item, index);
            },
          ),
        ),
      ),
    ]);
  }
}

