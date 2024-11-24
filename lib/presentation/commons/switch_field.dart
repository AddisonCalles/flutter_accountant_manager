import 'package:flutter/material.dart';

enum SwitchFieldPosition { left, right }

class SwitchField extends StatefulWidget {
  void Function(bool state)? onSubmit;
  final String label;
  final bool value;
  final SwitchFieldPosition position;

  SwitchField(
      {super.key,
      this.onSubmit,
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
        if (widget.onSubmit != null) widget.onSubmit!(value);
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
