
import 'package:ecommerce/constants/colors_constants.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart' as lottie;


class NoInternetConnection extends StatelessWidget {
  const NoInternetConnection({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
              SizedBox(
              height: size.width*0.5,
              child: OverflowBox(
                  minHeight: size.width*0.8,
                  maxHeight:size.width*0.8,
                  child: lottie.Lottie.asset("assets/lottie/no_internet.json")),
            ),
                SizedBox(height: size.height*0.1),
                const Text("Network error. Please check your network connection.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: primaryColorDark)),
              ],
            ),
          ),
        )
    );
  }
}