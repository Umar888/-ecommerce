import 'dart:convert';
import 'dart:math';


import 'package:ecommerce/constants/colors_constants.dart';
import 'package:ecommerce/utils/modules/home/bloc/home_bloc.dart';
import 'package:ecommerce/utils/modules/home/models/top_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class TopListWidget extends StatelessWidget {
  TopListWidget({Key? key, required this.topList, required this.index, required this.buildContext}): super(key: key);

  TopList topList;
  final BuildContext buildContext;
  int index;


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[

          Stack(
            children: [
              Image.asset(topList.image!,
                height: 150,
              ),
              topList.isNew!?Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0,horizontal: 4),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.yellow,
                  ),
                  child: const Padding(
                    padding:  EdgeInsets.symmetric(vertical: 1.0,horizontal: 4),
                    child: Text("new",
                    style:
                    TextStyle(
                      color: Colors.black,
                      fontSize: 11
                    ),),
                  ),
                ),
              ):const SizedBox(width: 0,height: 0,)
            ],
          ),
          const SizedBox(height: 5,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              children: [
                Text(
                    topList.price!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: primaryColorDark)
                ),
                const Spacer(),
                InkWell(
                  onTap: (){
                    BlocProvider.of<HomeBloc>(buildContext).add(TopFavChange(index: index));
                  },
                  child: Image.asset(topList.isFav!?"assets/images/home_static_assets/heart_fill.png":"assets/images/home_static_assets/heart.png",
                  width: 18),
                )
              ],
            ),
          ),
          const SizedBox(height: 4,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13.0),
            child: Text(
                topList.description!,
                textAlign: TextAlign.start,
                maxLines: 2,

                style: const TextStyle(
                    overflow:TextOverflow.ellipsis,
                    fontSize: 11,color: searchTextColor)
            ),
          ),
        ],
      ),
    );
  }
}
