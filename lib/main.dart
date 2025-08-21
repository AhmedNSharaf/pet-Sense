import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_sense/app/view/app/modules/screens/pet%20owner/pet_owner_home.dart';
import 'package:pet_sense/core/utils/app_translation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppTranslations.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      
      debugShowCheckedModeBanner: false,
      title: 'Pet Sense',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),

      /// Localization
      translations: AppTranslations(),
      locale: Locale('en', 'US'), // اللغة الافتراضية
      fallbackLocale: const Locale('ar', 'EG'), // لو حصلت مشكلة في الترجمة
      // supportedLocales: const [Locale('en', 'US'), Locale('ar', 'EG')],
      home: PetOwnerHome(),
    );
  }
}
