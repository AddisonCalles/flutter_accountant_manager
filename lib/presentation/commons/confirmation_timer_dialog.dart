import 'dart:async';

import 'package:flutter/material.dart';

class ConfirmationTimerDialog extends StatefulWidget {
  final String title;
  final String message;
  final String buttonTitle;
  final int time;
  final VoidCallback onConfirm;

  const ConfirmationTimerDialog({
    super.key,
    required this.title,
    required this.message,
    required this.buttonTitle,
    required this.time,
    required this.onConfirm,
  });

  @override
  State<ConfirmationTimerDialog> createState() =>
      _ConfirmationTimerDialogState();
}

class _ConfirmationTimerDialogState extends State<ConfirmationTimerDialog> {
  int secondsLeft = 0;

  void startCountdown() {
    setState(() {
      secondsLeft = widget.time;
    });

    const oneSec = Duration(seconds: 1);
    Timer.periodic(oneSec, (timer) {
      if (secondsLeft > 0) {
        setState(() {
          secondsLeft--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startCountdown();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: Text(widget.message),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Cancelar"),
        ),
        ElevatedButton(
          onPressed: secondsLeft == 0 ? widget.onConfirm : null,
          child: Text(
              "${widget.buttonTitle} ${secondsLeft > 0 ? secondsLeft : ""}"),
        ),
      ],
    );
  }
}
