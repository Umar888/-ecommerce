import 'package:flutter/material.dart';

class SmallTextButton extends StatelessWidget {
  final Function()? onPressed;
  final Color buttonBorderColor;
  final String text;
  final double leftPadding;
  final double rightPadding;

  const SmallTextButton({Key? key,
    required this.text,
    required this.buttonBorderColor,
    required this.onPressed,
    required this.leftPadding,
    required this.rightPadding
    ,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(border: Border.all(color: buttonBorderColor),
          borderRadius: const BorderRadius.all(Radius.circular(16)),
        ),
        child:  Padding(padding: EdgeInsets.fromLTRB(leftPadding, 1.5, rightPadding, 1.5),
          child: Text(text, style: const TextStyle(fontSize: 10.0),),
        ),
      ),
    );
  }
}
