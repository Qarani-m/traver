import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:traver/src/constants/colors.dart';
import 'package:traver/src/constants/image_strings.dart';
import 'package:traver/src/constants/size.dart';
import 'package:traver/src/features/auth/widgets/text_field.dart';
import 'package:traver/src/features/profile/controller/profile_controller.dart';
import 'package:traver/src/widget/auth/button.dart';

class PersonalInfo extends StatelessWidget {
   PersonalInfo({super.key});
  ProfileController profileController = Get.put(ProfileController());


  @override
  Widget build(BuildContext context) {
        var textTheme = Theme.of(context).textTheme;
    var iconTheme = Theme.of(context).iconTheme;
    var brightness = MediaQuery.of(context).platformBrightness;
        // TextEditingController controller = TextEditingController();
    // controller.text = "Martin Karani";

    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(left: 47.w),
          child: Text(
            "Personal Information",
            style: textTheme.bodyMedium,
          ),
        ),
      
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: AppSizes.horizontalPadding,
            right: AppSizes.horizontalPadding,
            // top: 50.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20.h,),
              Stack(
                children: [
                  Container(
                    width: 390.w,
                    alignment: Alignment.center,
                    child: Container(
                    height: 70.h,
                    width: 70.h,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage(AppImageStrings.onboarding[2]),
                            fit: BoxFit.cover)),
                    ),
                  ),
                  Positioned(
                    left: 180.w,
                    child: Container(
                      decoration: BoxDecoration(
                      color:brightness==Brightness.light?Colors.white:AppColors.darkColor,
        
                        shape: BoxShape.circle,
        
                      ),
                      child: Icon(Icons.camera)))
                ],
              ),
              SizedBox(height: 10.h,),
              Text(profileController.prefsList[0]),
              SizedBox(
                      height: 30.h,
                    ),
                    TextFielAuth(
                      obscureText: false,
                      controller: profileController.namecontroller,
                      label: "Person Responsible",
                      hint: "",
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    TextFielAuth(
                      obscureText: false,
                      controller: profileController.phonecontroller,
                      label: "Phone Number",
                      hint: "",
                    ),
                     SizedBox(
                      height: 15.h,
                    ),
                    TextFielAuth(
                      obscureText: false,
                      controller: profileController.emailcontroller,
                      label: "Email",
                      hint: "",
                    ),
                     SizedBox(
                      height: 15.h,
                    ),
                    TextFielAuth(
                      obscureText: false,
                      controller: profileController.idNumbercontroller,
                      label: "ID Number",
                      hint: "",
                    ),
                     SizedBox(
                      height: 15.h,
                    ),
                    TextFielAuth(
                      obscureText: false,
                      controller: profileController.locationcontroller,
                      label: "Location",
                      hint: "",
                    ),


                    SizedBox(height: 30.h,),
                    LargeButton(text: "Update profile", onTap: (){})
        
        
            ],
          ),
        ),
      ),
    );
  }
}