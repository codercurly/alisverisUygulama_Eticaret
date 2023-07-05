import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/location_controller.dart';
import 'package:get/get.dart';

class MyList extends StatelessWidget {
  const MyList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController edit =TextEditingController();
    return GetBuilder<LocationController>(builder: (sController){

      return  Scaffold(
        body: ListView(
          children: [TextField(
          controller: edit,
          ),
         // Text(sController.searchLocation(edit).toString())
          ],
        ),
      );
    });
    
  }
}
