import 'package:flutter/material.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({Key? key, required this.loadingColor}) : super(key: key);
  final Color loadingColor;
  @override
  Widget build(BuildContext context) {
    return  CircularProgressIndicator(color: loadingColor);
  }
}
