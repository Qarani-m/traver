import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:traver/src/constants/colors.dart';
import 'package:traver/src/constants/image_strings.dart';
import 'package:traver/src/constants/size.dart';
import 'package:traver/src/features/profile/screens/customer_care.dart';
import 'package:traver/src/features/profile/screens/faqs.dart';
import 'package:traver/src/features/profile/screens/personal_info.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var iconTheme = Theme.of(context).iconTheme;
    var brightness = MediaQuery.of(context).platformBrightness;
    final  text =[
      "Personal Information",
      "FAQ",
      "Customer care",
      "Logout"
    ];
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          left: AppSizes.horizontalPadding,
          right: AppSizes.horizontalPadding,
          top: 50.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Your profile",
              style: textTheme.titleMedium,
            ),
            SizedBox(
              height: 50.h,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 60.h,
                  width: 60.h,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage(AppImageStrings.onboarding[2]),
                          fit: BoxFit.cover)),
                ),
                SizedBox(
                  width: 25.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello, Martin ",
                      style: textTheme.bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      "Nairobi, Kenya ",
                      style: textTheme.bodySmall?.copyWith(fontSize: 12.sp),
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: 40.h,
            ),

            Column(
              children: List.generate(
                text.length,
                (index) => Setting(
                  index:index,
                    text: text[index],
                    icon:index ==text.length-1? const SizedBox(): IconTheme(
                        data: iconTheme, child: Icon(Icons.arrow_forward_ios, size: 20.h,))),
              ),
            )

            // Setting(text: "Personal ",icon: IconTheme(data: iconTheme, child: Icon(Icons.person_2_outlined))),
          ],
        ),
      ),
    );
  }
}

class Setting extends StatelessWidget {
  const Setting({super.key, required this.index, required this.text, this.icon = const SizedBox()});
  final String text;
  final Widget icon;
  final int index;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var brightness = MediaQuery.of(context).platformBrightness;

    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: GestureDetector(
        onTap: (){
          if(index==0){
            Get.to(PersonalInfo());

          }
          if(index==1){
            Get.to(Faqs());
          }
          if(index==2){
            Get.to(CustomerCare());
          }
          if(index ==3){
            Get.bottomSheet(
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                height: 200.h,
                width: 390.w,
                decoration: BoxDecoration(
                  color: brightness==Brightness.dark?AppColors.darkColor:Colors.white,
                  
                  borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  topRight: Radius.circular(20.r),
                )),
                child: Column(
                  
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Logout", style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(textAlign:TextAlign.center,"Are you sure you want to logout of Martin Karani's account", style: textTheme.bodySmall),
                    ),
                    SizedBox(height: 17.h,),
                    SizedBox(
                      height: 60.h,
                      width: 390.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                           GestureDetector(
                            onTap: () {},
                            child: Container(
                              alignment: Alignment.center,
                              height: 50.h,
                              width: 150.w,
                              decoration: BoxDecoration(
                                border: Border.all(color:AppColors.fadedTextColor),
                                  borderRadius: BorderRadius.circular(15.r)),
                              child:
                                  Text("Logout", style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500, fontSize: 15.sp)),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {Get.back();},
                            child: Container(
                              alignment: Alignment.center,
                              height: 50.h,
                              width: 150.w,
                              decoration: BoxDecoration(
                                  color: AppColors.secondaryColor,
                                  borderRadius: BorderRadius.circular(15.r)),
                              child:
                                  Text("Cancel", style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500, fontSize: 15.sp)),
                            ),
                          )
                        ],
                      ),
                    )

                  ],
                ),
              )
            );
          }
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
          height: 70.h,
          decoration: BoxDecoration(
              border: Border.all(
                  color: brightness == Brightness.dark
                      ? AppColors.fadedTextColor.withOpacity(0.1)
                      : AppColors.fadedTextColor),
              borderRadius: BorderRadius.circular(20.r)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: textTheme.bodySmall,
              ),
              icon
            ],
          ),
        ),
      ),
    );
  }
}
