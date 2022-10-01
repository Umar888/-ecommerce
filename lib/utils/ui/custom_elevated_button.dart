import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final Function()? onPressed;
  final Color buttonColor;
  final String text;
  final double height, width;

  const CustomElevatedButton({
    Key? key,
    required this.text,
    required this.width,
    required this.height,
    required this.buttonColor,
    required this.onPressed,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      clipBehavior: Clip.hardEdge,
      style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(0.0),
          backgroundColor: buttonColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(80.0))),
      child: Ink(
        child: Container(
          constraints: BoxConstraints(maxWidth: width, minHeight: height),
          alignment: Alignment.center,
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
