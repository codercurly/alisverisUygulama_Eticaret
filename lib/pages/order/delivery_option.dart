import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/order_controller.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:get/get.dart';

class DeliveryOption extends StatelessWidget {
  final String title;
  final String value;
  final double amount;
  final bool isFree;
  const DeliveryOption({Key? key, required this.title,
    required this.value, required this.amount,
    required this.isFree}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(builder: (orderController) {
      return Row(
        children: [Radio(value: value,
            groupValue: orderController.orderType, onChanged: (String? value)=>
        orderController.setDeliveryType(value!)
        ),
          SizedBox(width: Dimensions.width10),
          Text(title,
              style: TextStyle(fontSize: Dimensions.font20)),
          SizedBox(width: Dimensions.width10),
          Text('(${(value == "gel al" || isFree) ? 'ücretsiz' : '${amount /
              10} TL'})',
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: Dimensions.font20)),
        ],
      );
    });
  }}
