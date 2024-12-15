
import 'package:flutter/material.dart';



class ToggleButtonsApp<T> extends StatefulWidget {

  final Set<T> selection;
  final List<(T,String)> listItems;
  final void Function (T, String) onChanged;
  const ToggleButtonsApp({super.key,
    required this.listItems,
    required this.selection,
    required this.onChanged});

  @override
  State<ToggleButtonsApp<T>> createState() => _ToggleButtonsAppState<T>();
}

class _ToggleButtonsAppState<T> extends State<ToggleButtonsApp<T>> {

  List<bool> _toggleButtonsSelection = [];

  @override
  void initState() {
    super.initState();
    _toggleButtonsSelection = List<bool>.generate(widget.listItems.length, (int index) => index == 0);
  }

  @override
  Widget build(BuildContext context) {


    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text('SegmentedButton'),
          const SizedBox(height: 10),
          SegmentedButton<T>(
            // ToggleButtons above allows multiple or no selection.
            // Set `multiSelectionEnabled` and `emptySelectionAllowed` to true
            // to match the behavior of ToggleButtons.
            multiSelectionEnabled: false,
            emptySelectionAllowed: true,
            // Hide the selected icon to match the behavior of ToggleButtons.
            showSelectedIcon: false,
            // SegmentedButton uses a Set<T> to track its selection state.
            selected: widget.selection,
            // This callback updates the set of selected segment values.
            onSelectionChanged: (Set<T> newSelection) {
              setState(() {
                widget.onChanged(newSelection.first, widget.listItems.first.$2);
              });
            },
            // SegmentedButton uses a List<ButtonSegment<T>> to build its children
            // instead of a List<Widget> like ToggleButtons.
            segments: widget.listItems
                .map<ButtonSegment<T>>(((T, String) shirt) {
              return ButtonSegment<T>(
                  value: shirt.$1, label: Text(shirt.$2));
            }).toList(),
          ),
        ],
      ),
    );
  }
}