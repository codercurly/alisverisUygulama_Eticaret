import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:food_delivery/controllers/location_controller.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/src/places.dart';
class LocationDialogue extends StatelessWidget {
  final GoogleMapController mapController;
  const LocationDialogue({Key? key, required this.mapController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller =TextEditingController();
    return Container(
      alignment: Alignment.topCenter,
      padding: EdgeInsets.all(Dimensions.width30),
      child: Material(shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.radius20/2)
      ),
        child: SizedBox(width: Dimensions.screenWidth,
          child: TypeAheadField(
            textFieldConfiguration: TextFieldConfiguration(
                controller: controller,
                textInputAction: TextInputAction.search,
                autofocus: false,
                textCapitalization: TextCapitalization.words,
                keyboardType: TextInputType.streetAddress,
                decoration: InputDecoration(
                    hintText: "yer ara",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Dimensions.radius15),
                        borderSide: const BorderSide(width: 0,
                            style: BorderStyle.none)
                    )
                )
            ),
            onSuggestionSelected: ( suggestion)  {

              controller.text = suggestion;
              Get.back();

            },
            suggestionsCallback: ( pattern) async {

              return await Get.find<LocationController>().searchLocation(pattern);
            },
            itemBuilder: (context, suggestion){
              return Row(
                children: [
                  const Icon(Icons.location_on),
                  Expanded(child: Text(suggestion,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:TextStyle(color: Colors.black,
                          fontSize: Dimensions.font20
                      )

                      )),
                ],);
            },
          ),
        ),
      ),
    );

  }
}
