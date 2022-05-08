import 'package:flutter/material.dart';

class ColoredButton extends StatefulWidget {
  ColoredButton({
    required this.title,
    required this.backgroundColor,
    required this.onPressed,
  });

  String title;
  Color backgroundColor;
  Function onPressed;

  @override
  State<ColoredButton> createState() => _ColoredButtonState();
}

class _ColoredButtonState extends State<ColoredButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
          backgroundColor: widget.backgroundColor, primary: Colors.white),
      onPressed: () {
        widget.onPressed();
      },
      child: Text(widget.title),
    );
  }
}
