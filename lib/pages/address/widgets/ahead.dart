import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:food_delivery/controllers/location_controller.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final TextEditingController _typeAheadController = TextEditingController();

class haci extends StatelessWidget {
  final GoogleMapController mapController;
  const haci({Key? key, required this.mapController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _selectedCity;
    return Scaffold(
      body: Form(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: Column(
            children: <Widget>[
              Text(
                  'What is your favorite city?'
              ),
              TypeAheadFormField(
                textFieldConfiguration: TextFieldConfiguration(
                    controller: _typeAheadController,
                    decoration: InputDecoration(
                        labelText: 'City'
                    )
                ),
                suggestionsCallback: (pattern) {
                  return Get.find<LocationController>().searchLocation(pattern);
                },
                itemBuilder: (context, suggestion) {
                  return ListTile(
                    title: Text(suggestion),
                  );
                },
                transitionBuilder: (context, suggestionsBox, controller) {
                  return suggestionsBox;
                },
                onSuggestionSelected: (suggestion) {
                 _typeAheadController.text = suggestion;
                },

              ),

            ],
          ),
        ),
      ),
    );
  }
}

