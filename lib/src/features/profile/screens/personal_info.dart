import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:traver/src/constants/colors.dart';
import 'package:traver/src/constants/size.dart';
import 'package:traver/src/features/auth/widgets/text_field.dart';
import 'package:traver/src/features/profile/controller/profile_controller.dart';
import 'package:traver/src/widget/auth/button.dart';

class PersonalInfo extends StatelessWidget {
  PersonalInfo({super.key});
  ProfileController profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var brightness = MediaQuery.of(context).platformBrightness;

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
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Stack(
                  children: [
                    GestureDetector(
                      onTap: () => profileController.changeProfilePic(),
                      child: Container(
                        width: 390.w,
                        alignment: Alignment.center,
                        child: Container(
                          height: 70.h,
                          width: 70.h,
                          decoration: BoxDecoration(
                            color: AppColors.fadedTextColor.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: profileController.profilePicImageUrl.value
                                  .startsWith("https")
                              ? ClipOval(
                                  child: Image(
                                  height: 70.h,
                                  width: 70.h,
                                  image: NetworkImage(profileController
                                      .profilePicImageUrl.value),
                                  fit: BoxFit.cover,
                                ))
                              : Center(
                                  child: Text(
                                  "${profileController.prefsList[0].split(" ")[0][0]}.${profileController.prefsList[0].split(" ")[1][0]}",
                                  style: Theme.of(context).textTheme.bodyLarge,
                                )),
                        ),
                      ),
                    ),
                    Positioned(
                        left: 180.w,
                        child: Container(
                            decoration: BoxDecoration(
                              color: brightness == Brightness.light
                                  ? Colors.white
                                  : AppColors.darkColor,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.camera)))
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(profileController.prefsList[0]),
                SizedBox(
                  height: 30.h,
                ),
                TextFielAuth(
                  readonly: true,
                  obscureText: false,
                  controller: profileController.namecontroller,
                  label: "Person Responsible",
                  hint: "",
                ),
                SizedBox(
                  height: 15.h,
                ),
                TextFielAuth(
                  numberKeyboard: true,
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
                  readonly: true,
                  controller: profileController.emailcontroller,
                  label: "Email",
                  hint: "",
                ),
                SizedBox(
                  height: 15.h,
                ),
                TextFielAuth(
                  numberKeyboard: true,
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
                  controller: profileController.locationController,
                  label: "City",
                  hint: "",
                ),
                SizedBox(
                  height: 30.h,
                ),
                LargeButton(
                    text: "Update profile",
                    onTap: () {
                      profileController.updateFieldValues();
                    }),
                SizedBox(
                  height: 10.h,
                ),
                Center(
                  child: profileController.errorStatus.value
                      ? Text("Invalid ${profileController.errorValue}",
                          style: textTheme.bodySmall
                              ?.copyWith(color: AppColors.likeColor))
                      : Container(),
                ),
                Center(
                  child: profileController.successStatus.value
                      ? Text("Profile was succesfully updated",
                          style: textTheme.bodySmall
                              ?.copyWith(color: AppColors.accentColor))
                      : Container(),
                ),
                SizedBox(
                  height: 30.h,
                ),
                profileController.isUpdatingProfilePic.value
                    ? Center(
                        child: LoadingAnimationWidget.threeArchedCircle(
                            color: AppColors.secondaryColor, size: 40.h),
                      )
                    : Container()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
