import 'dart:convert';
import 'dart:math';


import 'package:ecommerce/constants/colors_constants.dart';
import 'package:ecommerce/utils/modules/home/bloc/home_bloc.dart';
import 'package:ecommerce/utils/modules/home/models/second_list.dart';
import 'package:ecommerce/utils/modules/home/models/top_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class SecondListWidget extends StatelessWidget {
  SecondListWidget({Key? key, required this.secondList, required this.index, required this.buildContext}): super(key: key);

  SecondList secondList;
  final BuildContext buildContext;
  int index;


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width*0.85,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          Padding(

            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Container(
              height: 130,
              width: double.infinity,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.asset(secondList.image!,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 7,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              children: [
                Text(
                    secondList.title!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: primaryColorDark)
                ),
                const Spacer(),
                Text(
                   "Within "+ secondList.time!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 13,color: primaryColorDark)
                ),
              ],
            ),
          ),
          const SizedBox(height: 3,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13.0),
            child: Text(
                secondList.description!,
                textAlign: TextAlign.start,
                maxLines: 2,

                style: const TextStyle(
                    overflow:TextOverflow.ellipsis,
                    fontSize: 11,color: Colors.black87)
            ),
          ),
          const SizedBox(height: 2),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13.0),
            child: Text(
                "${secondList.rating!}(${secondList.totalRatings!})",
                textAlign: TextAlign.start,
                maxLines: 2,

                style: const TextStyle(
                    overflow:TextOverflow.ellipsis,
                    fontSize: 12,color: Colors.black)
            ),
          ),
        ],
      ),
    );
  }
}
