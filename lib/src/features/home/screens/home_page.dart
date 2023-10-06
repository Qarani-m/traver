import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:traver/src/constants/size.dart';
import 'package:traver/src/features/auth/controllers/auth_controller.dart';
import 'package:traver/src/features/home/controller/homepage_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
  AuthController authController = Get.put(AuthController());
  HomePageController homePageController = Get.put(HomePageController());

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
            left: AppSizes.horizontalPadding,
            right: AppSizes.horizontalPadding,
            top: 60.h),
        child: Obx(()=> Column(
            children: [
              Text("Name: ${homePageController.name.value}", style: Theme.of(context).textTheme.bodySmall,),
              Text("Email: ${homePageController.email.value}",style: Theme.of(context).textTheme.bodySmall,),
              Text("Phone: ${homePageController.phone.value}",style: Theme.of(context).textTheme.bodySmall,),
              SizedBox(
                child: Row(
                  children: [
                    Text("Itrests: ",style: Theme.of(context).textTheme.bodySmall,),
                    Row(children: List.generate(homePageController.intrests.length, (index){
                      return Text(" ${homePageController.intrests[index]} , ",style: Theme.of(context).textTheme.bodySmall,);
                    }),)
                  ],
                ),
              ),

              // Text("Intrests: ${}"),
              Center(
                child: TextButton(
                  onPressed: () async{
        
                    authController.signoutUser();
                  },
                  child: Text("Log out"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
