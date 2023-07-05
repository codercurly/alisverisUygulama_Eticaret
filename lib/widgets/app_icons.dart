import 'package:flutter/material.dart';
import 'package:food_delivery/utils/dimensions.dart';

class AppIcon extends StatelessWidget {
  final Color? iconColor;
  final Color? BgColor;
  final double top;
  final double left;
  final double right;
final double? size;
  final double? size1;
  final IconData? icon;
  const AppIcon({Key? key, this.iconColor=const Color(0xFF756d54), this.BgColor= const Color(0xFFfcf4e4),
    required this.icon, this.size1 = 40, this.top=10, this.size=40, this.left=3, this.right=3}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Container(
        margin: EdgeInsets.only(left: left,right: right,top: top),
child: Icon(icon,
size: size, color: iconColor,),
        height: size1,
        width: size1,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size!/2),
          color: BgColor
        ),

      );

  }
}
