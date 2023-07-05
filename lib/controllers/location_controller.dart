import 'dart:convert';
import 'package:food_delivery/data/api/api_checker.dart';
import 'package:google_maps_webservice/src/places.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/data/repository/location_repo.dart';
import 'package:food_delivery/main.dart';
import 'package:food_delivery/models/address_model.dart';
import 'package:food_delivery/models/response_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationController extends GetxController implements GetxService{
 LocationRepo locationRepo;
 LocationController({required this.locationRepo});
 bool _loading = false;
 late Position _position;
 late Position _pickPosition;

 bool _isloading = false;
 bool get isLoding => _isloading;
 bool _inZone=false;
 bool get inZone => _inZone;
 bool _buttonDisabled=true;
 bool get buttonDisabled =>_buttonDisabled;


 Placemark _placeMark = Placemark();
 Placemark _pickPlaceMark = Placemark();

 Placemark get placeMark => _placeMark;
 Placemark get pickPlaceMark => _pickPlaceMark;

 List<AddressModel> _addressList = [];
 List<AddressModel> get addressList => _addressList;
 late List<AddressModel> _allAddressList=[];
  List<AddressModel> get allAddressList=>_allAddressList;
final List<String> _addressTypeList = ["home", "office", "others"];
List<String> get addressTypeList => _addressTypeList;
int _addressTypeIndex=0;
int get addressTypeIndex =>_addressTypeIndex;

late GoogleMapController _mapController;
 GoogleMapController get mapController=> _mapController;

bool _updateAddressdata=true;
bool _changeAddress=true;

bool get loading=> _loading;
Position get position=> _position;
Position get pickPosition=> _pickPosition;

 List<dynamic> data=[];

void setMapcontroller(GoogleMapController mapController){
 _mapController=mapController;
}

  Future<void> updatePosition(CameraPosition position, bool fromAddress) async {
if(_updateAddressdata){
 _loading=true;
 update();

 try{
  if(fromAddress){

   _position=Position(longitude: position.target.longitude,
       latitude: position.target.latitude, timestamp: DateTime.now(),
       accuracy: 1, altitude: 1,
       heading: 1, speed: 1, speedAccuracy: 1);
  }
  else{
   _pickPosition=Position(longitude: position.target.longitude,
       latitude: position.target.latitude, timestamp: DateTime.now(),
       accuracy: 1, altitude: 1,
       heading: 1, speed: 1, speedAccuracy: 1);
  }
  var a = position.toString().split("LatLng(")[1];
  var b = a.toString().split(")")[0];
  List<String> c = b.split(", ");
  print("bakıyoz"+c[0]+c[1]);
  ResponseModel _responseModel = await getZone(c[0], c[1],
      false);
  if(_responseModel.isSuccess){
   _buttonDisabled=false;
  }else{ _buttonDisabled=true;}

  if(_changeAddress){
   print(position.toString());
   var a = position.toString().split("LatLng(")[1];
   var b = a.toString().split(")")[0];
   List<String> c = b.split(", ");
   //print(b.toString());
   String _address = await getAddressFromGeocode(
   c[0], c[1]
   );
   print(_address);
   fromAddress?_placeMark=Placemark(name: _address):_pickPlaceMark=Placemark(name: _address);
 print(_address);
  print(placeMark.name);
  }else{
   _changeAddress=true;
  }
 }catch(e){
//print(" ${e}");
 }
 _loading=false;
 update();
}else{
 _updateAddressdata=true;
}
  }
  Future<String> getAddressFromGeocode(String lat, String lng) async {
 String _address="adres bilinmiyor";
 Response response =await locationRepo.getAddressFromGeocode(lat, lng);
 final rbody = response.body;
 String status = rbody.toString().split("||")[0];
 var bolge = rbody.toString().split("||")[1];
print(status);

 //if(deneme["status"]==200) {
   if(status=="200") {
//   print("adres alma başarılı adres:" +bolge);
  _address = bolge.toString();
 }
 else{
  print("api hata");
 }
 update();
 return _address;
  }


 late Map<String, dynamic> _getAddress;
 Map get getAddress => _getAddress;

 AddressModel getUserAddress(){
 late AddressModel _addressModel;
 _getAddress =jsonDecode(locationRepo.getUserAddress());
 try{
  _addressModel = AddressModel.fromJson(jsonDecode(locationRepo.getUserAddress()));
 }catch(e){
  print(e);
 }
 return _addressModel;
  }

  void setAddressTypeIndex(int index){
  _addressTypeIndex=index;
  update();
  }

  Future<ResponseModel> addAddress(AddressModel addressModel) async {
  _loading=true;
  update();
  Response response = await locationRepo.addAddress(addressModel);
  ResponseModel responseModel;
  if(response.statusCode==200){
  await getAddressList();
   String message = response.body['message'];
   responseModel = ResponseModel(true, message);
   await saveUserAddress(addressModel);
  }else{
   print("adres kaydedilemedi");
   responseModel = ResponseModel(false, response.statusText!);
  }
  update();
  return responseModel;
  }

  Future<void> getAddressList()async{
  Response response = await locationRepo.getAllAddress();
  if(response.statusCode==200){
   _addressList=[];
   _allAddressList=[];
   response.body.forEach((address){
    _addressList.add(AddressModel.fromJson(address));
    _allAddressList.add(AddressModel.fromJson(address));
   });
  }else{
   _addressList=[];
   _allAddressList=[];
  }
  update();
  }

Future<bool> saveUserAddress(AddressModel addressModel) async {
String userAddress = jsonEncode(addressModel.toJson());
return await locationRepo.saveUserAddress(userAddress);
 }

 void clearAddressList(){
  _addressList=[];
  _allAddressList=[];
  update();
 }

  String getUserAddressFromlocalStroage() {
  return locationRepo.getUserAddress();
  }

  void setAddAddressData(){
  _position=_pickPosition;
  _placeMark=_pickPlaceMark;
  _updateAddressdata=false;
  update();
}

Future<ResponseModel> getZone(String lat, String lng, bool markerLoad) async{
late ResponseModel _responseModel;
  if(markerLoad){
   _loading=true;
  }else{
   _isloading=true;
  }
  update();
   Response response = await locationRepo.getZone(lat, lng);
   if(response.statusCode==200){
    _inZone=true;
    _responseModel =ResponseModel(true, response.body["zone_id"].toString());
    update();
   }else{
    _inZone=false;
    _responseModel =ResponseModel(true, response.statusText!);
   }
if(markerLoad){
 _loading=false;
}else{
 _isloading=false;
}
   print(response.statusCode);
update();
  return _responseModel;
}
 Future<List> searchLocation(String text) async {
if(text.isNotEmpty) {
 Response response = await locationRepo.searchLocation(text);
 if (response.statusCode == 200) {
  //print("kodunuzz 200 geldi");
  data =[];
  Map<String, dynamic> map = json.decode(response.body);
 data = map["predictions"];
  print(data);
  //  response.body['predictions'].forEach((prediction)=>  _predictionList.add(
  //jsonDecode(prediction))).toString();
 }
 else {
  ApiChecker.checkApi(response);
 }
}
  return data;
 }
 setLocation(String lat, String lng, String address, GoogleMapController mapController) async {
  _loading=true;
  update();
  PlacesDetailsResponse detail;
  Response response =await locationRepo.getAddressFromGeocode(lat, lng);
  final rbody = response.body;
  String status = rbody.toString().split("||")[0];
  var bolge = rbody.toString().split("||")[1];
  detail = PlacesDetailsResponse.fromJson(rbody);
  _pickPosition=Position(longitude: detail.result.geometry!.location.lat,
      latitude: detail.result.geometry!.location.lng,
      timestamp: DateTime.now(), accuracy: 1, altitude: 1,
      heading: 1, speed: 1, speedAccuracy: 1);
  _pickPlaceMark=Placemark(name: address);
  _changeAddress=false;
  _loading=false;
  if(!mapController.isNull){
   mapController.animateCamera(CameraUpdate.newCameraPosition(
       CameraPosition(target: LatLng(detail.result.geometry!.location.lat,
        detail.result.geometry!.location.lng),zoom: 17)));
  }
  update();
 }

}