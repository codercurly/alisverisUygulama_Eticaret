import 'package:flutter/material.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/small_text.dart';

class IconAndText extends StatelessWidget {
  final IconData? iconData;
  final String? text;
  final Color? iconColor;
  const IconAndText({Key? key, this.iconData, this.text, this.iconColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Row(
      children: [
        Icon(iconData, color: iconColor, size: Dimensions.iconSize24,),
        SizedBox(width:2),
        SmallText(text: text, size: 13,)
      ],
    );
  }
}
