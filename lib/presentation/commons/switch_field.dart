import 'package:flutter/material.dart';

enum SwitchFieldPosition { left, right }

class SwitchField extends StatefulWidget {
  final void Function(bool state)? onChanged;
  final String label;
  final bool value;
  final SwitchFieldPosition position;

  const SwitchField(
      {super.key,
      this.onChanged,
      required this.label,
      required this.value,
      SwitchFieldPosition? position})
      : position = position ?? SwitchFieldPosition.right;

  @override
  State<SwitchField> createState() => SwitchFieldState();
}

class SwitchFieldState extends State<SwitchField> {
  Widget _switch() {
    return Switch(
      value: widget.value,
      activeColor: Colors.pink,
      activeTrackColor: Colors.pinkAccent.withOpacity(0.5),
      onChanged: (bool value) {
        if (widget.onChanged != null) widget.onChanged!(value);
      },
    );
  }

  Widget _left() {
    return Row(
      children: [
        Text(widget.label),
        const Spacer(),
        _switch(),
      ],
    );
  }

  Widget _right() {
    return Row(
      children: [_switch(), const Spacer(), Text(widget.label)],
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.position == SwitchFieldPosition.left ? _left() : _right();
  }
}
