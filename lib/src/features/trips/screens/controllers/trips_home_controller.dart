import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:traver/src/features/home/models/booking_model.dart';

class TripsController extends GetxController {


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
