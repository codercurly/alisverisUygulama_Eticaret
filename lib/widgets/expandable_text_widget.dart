import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/small_text.dart';

class ExpandableText extends StatefulWidget {
  final String? text;
  const ExpandableText({Key? key, required this.text}) : super(key: key);

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  late String firstHalf;
  late String secondHalf;

  bool hiddenText=true;
  double textHeight= Dimensions.screenHeight/5.63;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.text!.length>textHeight){
      firstHalf = widget.text!.substring(0, textHeight.toInt());
      secondHalf = widget.text!.substring(textHeight.toInt()+1, widget.text!.length);
    }
    else{
      secondHalf="";
      firstHalf=widget.text!;
    }
  }

  @override

  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty?SmallText(text: firstHalf,color: AppColors.paraColor,size: Dimensions.font23):

      Column(

        children: [
                SmallText(size: Dimensions.font23,height:1.5,color: AppColors.paraColor,text: hiddenText?(firstHalf+"..."):firstHalf+secondHalf),

                  InkWell(

                    onTap: (){

                      setState(() {

                        hiddenText=!hiddenText;

                      });


                    },

                    child: Row(

                      children: [

                        SmallText(text: "daha fazla", color: AppColors.mainColor,),

                        Icon(hiddenText?Icons.arrow_drop_down_outlined:Icons.arrow_drop_up, color: AppColors.mainColor)

                      ],

                    ),

                  ),
              ],
      ));
  }
}
