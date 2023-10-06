import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:traver/firebase_options.dart';
import 'package:traver/src/constants/colors.dart';
import 'package:traver/src/features/auth/controllers/auth_controller.dart';
import 'package:traver/src/features/auth/views/explore.dart';
import 'package:traver/src/features/auth/views/forgot_password.dart';
import 'package:traver/src/features/auth/views/login.dart';
import 'package:traver/src/features/auth/views/onboarding.dart';
import 'package:traver/src/features/auth/views/register.dart';
import 'package:traver/src/features/home/screens/basepage.dart';
import 'package:traver/src/features/home/screens/home_page.dart';
import 'package:traver/src/utils/bindings/app_binding.dart';
import 'package:traver/src/utils/theme/app_theme.dart';

void main() async{
 
  GoogleFonts.config.allowRuntimeFetching = false;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
).then((value) => Get.put(AuthController()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Brightness statusBarIconBrightness =
        MediaQuery.of(context).platformBrightness == Brightness.light
            ? Brightness.dark
            : Brightness.light;


     SystemChrome.setSystemUIOverlayStyle(
     SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: statusBarIconBrightness,
    ),
  );
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder:(_, child)=> GetMaterialApp(
        initialBinding: AppBindings(),
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme() ,
        darkTheme: AppTheme.darkTheme() ,
        themeMode: ThemeMode.system,
        initialRoute: "/logo",
        getPages:[
          GetPage(name: "/logo", page:()=>  const LogoOne()),
          GetPage(name: "/onboarding", page:()=>  const Onboarding()),
          GetPage(name: "/login", page:()=>  const Login()),
          GetPage(name: "/register", page:()=>  const RegisterName()),
          GetPage(name: "/registerEmail", page:()=>  const RegisterEmail()),
          GetPage(name: "/registerPassword", page:()=>  const RegisterPassword()),
          GetPage(name: "/registerVerification", page:()=>  const RegisterVerification()),
          GetPage(name: "/registerSucces", page:()=>  const Succes()),
          GetPage(name: "/explore", page:()=>  const Explore()),
          GetPage(name: "/homepage", page:()=>  const BasePage()),
          GetPage(name: "/forgotPassword", page:()=>  const ForgotPassword()),
          
        ],
      ),
    );
  }
}

class LogoOne extends StatelessWidget {
  const LogoOne({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Logo(),),
    );
  }
}