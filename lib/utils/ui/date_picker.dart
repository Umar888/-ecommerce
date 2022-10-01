import 'dart:ui';

import 'package:ecommerce/constants/colors_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class DatePickerWidget extends StatelessWidget {
  final DateTime initialDate;
  final DateTime minimumDate;
  final DateTime maximumDate;
  final void Function(DateTime)  onChange;
  final void Function() onSelect;
  const DatePickerWidget({required this.initialDate,required this.minimumDate,required this.maximumDate,required this.onChange,required this.onSelect,Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Container(
        height: MediaQuery.of(context).copyWith().size.height * 0.35,
        color: appBackgroundColor,
        child: NotificationListener(
          onNotification: (ScrollNotification notification) {
            if (notification.depth == 0 && notification is ScrollEndNotification && notification.metrics is FixedExtentMetrics) {
            }
            else if(notification is ScrollStartNotification ){
            }
            return false;
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: CupertinoDatePicker(

                  mode: CupertinoDatePickerMode.date,
                  onDateTimeChanged: onChange,
                  initialDateTime: initialDate,
                  maximumDate: maximumDate,
                  minimumDate:  minimumDate,
                ),
              ),
              Padding(
                  padding:
                  const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 40,
                  ),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        primaryColorDark,
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                      ),
                    ),
                    onPressed:onSelect,
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.center,
                      mainAxisSize:
                      MainAxisSize.max,
                      children:  const [
                        Padding(
                          padding:
                          EdgeInsets.symmetric(
                            vertical:
                            16,
                          ),
                          child:
                          Text('Done',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white
                            ),
                          ),
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}