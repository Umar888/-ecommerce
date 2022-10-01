import 'dart:convert';
import 'dart:math';


import 'package:ecommerce/constants/colors_constants.dart';
import 'package:ecommerce/utils/modules/home/bloc/home_bloc.dart';
import 'package:ecommerce/utils/modules/home/models/categories.dart';
import 'package:ecommerce/utils/modules/home/models/second_list.dart';
import 'package:ecommerce/utils/modules/home/models/top_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class CategoriesListWidget extends StatelessWidget {
  CategoriesListWidget({Key? key, required this.categories, required this.index, required this.buildContext}): super(key: key);

  Categories categories;
  final BuildContext buildContext;
  int index;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Container(
        width: MediaQuery.of(context).size.width*0.925,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: searchBackgroundColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            SizedBox(
              height: 130,
              width: double.infinity,
              child: Image.asset(categories.image!,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 7,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                  categories.time!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.normal,fontSize: 12,color: Colors.black87)
              ),
            ),
            const SizedBox(height: 3,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                  categories.title!,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                      overflow:TextOverflow.ellipsis,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,color: Colors.black87)
              ),
            ),
            const SizedBox(height: 3),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                children: [
                  Image.asset("assets/images/home_static_assets/location_icon.png",
                  width: 16,),
                  SizedBox(width: 5,),
                  Text(
                      categories.location!,
                      textAlign: TextAlign.start,
                      maxLines: 2,

                      style: const TextStyle(
                          overflow:TextOverflow.ellipsis,
                          fontSize: 12,color: Colors.black)
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [

                  InkWell(
                    onTap:(){
                      BlocProvider.of<HomeBloc>(buildContext).add(CategoriesFavChange(index: index));
                    },
                    child: Image.asset(categories.isFave!?"assets/images/home_static_assets/heart_fill.png":"assets/images/home_static_assets/heart.png",
                      width: 22,
                    color: Color(0xff7C7C7C),),
                  ),
                  SizedBox(width: 10),
                  InkWell(
                    onTap:(){
                      BlocProvider.of<HomeBloc>(buildContext).add(CategoriesShare(index: index));
                    },
                    child: Image.asset("assets/images/home_static_assets/share_icon.png",
                    //width: 22,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
