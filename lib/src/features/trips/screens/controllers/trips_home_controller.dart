import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:traver/src/features/home/controller/homepage_controller.dart';
import 'package:traver/src/features/home/models/booking_model.dart';

class TripsController extends GetxController {
  String email= "";
@override
void onInit()async{
  super.onInit();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  email = prefs.getString("email")??"";

}


  getPrefs()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("email")??"";
  }



 
Future<void> getBookedTours(String email) async {
 try{
  
 }catch(e){

 }
}



}
