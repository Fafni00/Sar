// ignore_for_file: prefer_const_constructors

import 'package:ecommerce_app/Sellerprofile%20pages/AddproductUI/AddProductspage.dart';
import 'package:ecommerce_app/UserProfile/UserProflie.dart';
import 'package:ecommerce_app/UserRegistration/UserLogin.dart';

import 'package:ecommerce_app/Sellerprofile%20pages/AllProducts/AllProduct.dart';
import 'package:ecommerce_app/Sellerprofile%20pages/SellerProfileSection.dart';
import 'package:ecommerce_app/Sellerprofile%20pages/Sellerprovider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'Sellerprofile pages/AddProduct/product_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  Provider.debugCheckInvalidValueType = null;
  runApp(
    MultiProvider(providers: [
      Provider<SellerProvider>(create: (_) => SellerProvider()),
      ChangeNotifierProvider(create: (_) => ProductProvider()),
    ], child: MyApp()),
  );
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: Loginpage(),
      routes: {
        SellerProfileSection.id: (context) => SellerProfileSection(),
        AddProductScreen.id: (context) => AddProductScreen(),
        AllProduct.id: (context) => AllProduct(),
        Loginpage.id: (context) => Loginpage(),
      },
    );
  }
}
