import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {
  double? height;
  Color? color;
  final String? text;
  double? size;


  SmallText({Key? key,this.color = const Color(0xFFccc7c5),
    required this.text,
    this.size=15, this.height=1.2}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Text(text!,
      style: TextStyle(color: color,
          height: height,
          fontSize: size),
    );
  }
}
