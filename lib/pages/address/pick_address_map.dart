import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/location_controller.dart';
import 'package:food_delivery/pages/address/widgets/ahead.dart';
import 'package:food_delivery/pages/address/widgets/location_dialogue.dart';
import 'package:food_delivery/route/route_helper.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/custom_button.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PickAddressMap extends StatefulWidget {
  final bool fromSignup;
  final bool fromAddress;
  final GoogleMapController? googleMapController;

  const PickAddressMap(
      {Key? key,
      required this.fromSignup,
      required this.fromAddress,
      this.googleMapController})
      : super(key: key);

  @override
  State<PickAddressMap> createState() => _PickAddressMapState();
}

class _PickAddressMapState extends State<PickAddressMap> {
  late LatLng _initialPosition;
  late GoogleMapController _mapController;
  late CameraPosition _cameraPosition;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Get.find<LocationController>().addressList.isEmpty) {
      _initialPosition = LatLng(45.51563, -122.677433);
      _cameraPosition = CameraPosition(target: _initialPosition, zoom: 17);
    } else {
      if (Get.find<LocationController>().addressList.isNotEmpty) {
        _initialPosition = LatLng(
            double.parse(Get.find<LocationController>().getAddress['latitude']),
            double.parse(
                Get.find<LocationController>().getAddress['longitude']));

        _cameraPosition = CameraPosition(target: _initialPosition, zoom: 17);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(builder: (locationController){
      return Scaffold(
        body: SafeArea(
          child: Center(
            child: (SizedBox(
              width: double.maxFinite,
              child: Stack(
                children: [
                  GoogleMap(
                    initialCameraPosition:
                    CameraPosition(target: _initialPosition, zoom: 17),
                    zoomControlsEnabled: false,
                    zoomGesturesEnabled: true,
                    onCameraMove: (CameraPosition cameraPostion) {
                      _cameraPosition = cameraPostion;
                    },
                    onCameraIdle: () {
                      Get.find<LocationController>()
                          .updatePosition(_cameraPosition, false);
                    },
                    onMapCreated: (GoogleMapController mapController){
                      _mapController=mapController;
                    },
                  ),
                  Center(
                    child: !locationController.loading?
                    Image.asset("assets/pick.png", width: 50, height: 50,):
                    CircularProgressIndicator(),
                  ),
                  Positioned(
                      top: Dimensions.height30,
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                      child: InkWell(
                        onTap: ()=>
                          Get.dialog(LocationDialogue(mapController: _mapController,)),

                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
                          height: Dimensions.height10*5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.radius20/4),
                            color: AppColors.mainColor
                          ),
                          child: Row(

                            children: [
                              Icon(Icons.location_on, color: Colors.white,size:
                              Dimensions.iconSize31-4,),
                              Expanded(child: Text("${locationController.pickPlaceMark.name??''}",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: Dimensions.font20,color: Colors.white),
                              )),
                              SizedBox(width: Dimensions.width15),
                              Icon(Icons.search, color: Colors.orange,size:
                              Dimensions.iconSize31)
                            ],
                          ),
                        ),
                      )),
                  Positioned(
                      bottom: Dimensions.height20*5,
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                      child: locationController.isLoding?Center(child: CircularProgressIndicator(),):
                      CustomButton(buttonText: locationController.inZone?widget.fromAddress?'adresi seç':'konumu seç':'Hizmet bölgenizde mevcut değil',
                      onPressed: (locationController.buttonDisabled||locationController.loading)?null:
                          (){if(locationController.pickPosition.latitude!=0&&
                      locationController.pickPlaceMark.name!=null){
                         if(widget.fromAddress){
                           if(widget.googleMapController!=null){
                             print("adres seçildi");
                             widget.googleMapController!.moveCamera(CameraUpdate.newCameraPosition(
                                 CameraPosition(target: LatLng(locationController.pickPosition.latitude,
                                 locationController.pickPosition.longitude))));
                             locationController.setAddAddressData();
                           }
                          Get.toNamed(RouteHelper.getAddressPage());}
                      }

                      },
                      ))
                ],
              ),
            )),
          ),
        ),
      );
    });
  }
}
