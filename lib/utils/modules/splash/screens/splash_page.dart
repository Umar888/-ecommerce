import 'package:ecommerce/constants/colors_constants.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color:appBackgroundColor,
          child: Center(child: CircularProgressIndicator())),
    );
  }




  @override
  void didChangeDependencies() {

    super.didChangeDependencies();
  }
}
