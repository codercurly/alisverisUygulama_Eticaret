import 'package:flutter/material.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/icon_and_text.dart';
import 'package:food_delivery/widgets/small_text.dart';

class AppColumn extends StatelessWidget {
  final String? text;
  const AppColumn({Key? key,required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(text: text, size: Dimensions.font26),
        SizedBox(
          height: Dimensions.height10,
        ),
        Row(
          children: [
            Wrap(
                children: List.generate(
                    5,
                        (index) => Icon(
                      Icons.star,
                      color: AppColors.mainColor,
                      size: 12,
                    ))),
            SizedBox(width: 10),
            SmallText(text: "4.5"),
            SizedBox(width: 15),
            SmallText(text: "1250"),
            SizedBox(width: 5),
            SmallText(text: "Yorum"),
          ],
        ),
        SizedBox(height: Dimensions.height20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconAndText(
              text: "normal",
              iconData: Icons.circle_sharp,
              iconColor: AppColors.iconColor1,
            ),
            IconAndText(
              text: "1.2km",
              iconData: Icons.location_on,
              iconColor: AppColors.mainColor,
            ),
            IconAndText(
              text: "20dk",
              iconData: Icons.access_time,
              iconColor: AppColors.iconColor2,
            ),
          ],
        )
      ],
    );

  }
}
