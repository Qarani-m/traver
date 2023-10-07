import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController{
      final  text =[
      "Personal Information",
      "FAQ",
      "Customer care",
      "Logout"
    ];
    @override
    void onInit()async{
      super.onInit();
      await getPrefs();
      print( prefsList);
      personalInfoFieldFiller();

    }
      List<String> prefsList =[];
      TextEditingController namecontroller = TextEditingController();
      TextEditingController phonecontroller = TextEditingController();
      TextEditingController emailcontroller = TextEditingController();
      TextEditingController idNumbercontroller = TextEditingController();
      TextEditingController locationcontroller = TextEditingController();
    Future<List<String>> getPrefs()async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String name  =  prefs.getString("name")??"";
      String email  = prefs.getString("email")??"";
      String phone  = prefs.getString("phone")??"";
      String idNumber  = prefs.getString("idNumber")??"";
      String location  = prefs.getString("location")??"";

      prefsList.clear();
      prefsList.add(name); //0
      prefsList.add(email);//1
      prefsList.add(phone);//2
      prefsList.add(idNumber);//3
      prefsList.add(location);//4
      return prefsList;
    }

    void personalInfoFieldFiller(){
      namecontroller.text=prefsList[0].isEmpty?"-":prefsList[0];
      emailcontroller.text=prefsList[1].isEmpty?"-":prefsList[1];
      phonecontroller.text=prefsList[2].isEmpty?"-":prefsList[2];
      idNumbercontroller.text=prefsList[3].isEmpty?"-":prefsList[3];
      locationcontroller.text=prefsList[4].isEmpty?"-":prefsList[4];
    }
    

}