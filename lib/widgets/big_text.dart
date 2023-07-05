
import 'package:flutter/material.dart';
import 'package:food_delivery/utils/dimensions.dart';

class BigText extends StatelessWidget {
  Color? color;
  final String? text;
 final double? size;
  TextOverflow? overflow;


   BigText({Key? key,this.color = const Color(0xFF332d2d),
   required this.text,
    this.size=19,
  this.overflow=TextOverflow.ellipsis}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Text(text!,
      maxLines: 1,
      overflow: overflow,
      style: TextStyle(color: color,
      fontSize: size),
    );
  }
}
