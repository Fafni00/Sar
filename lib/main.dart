// ignore_for_file: prefer_const_constructors

import 'package:ecommerce_app/Provider/CartProvider.dart';
import 'package:ecommerce_app/Cart/CartScreen.dart';

import 'package:ecommerce_app/Provider/SellerProvider.dart';
import 'package:ecommerce_app/SellerHome/SellerNavigation.dart';
import 'package:ecommerce_app/SellerProduct/AddProduct/AddProductScreen.dart';
import 'package:ecommerce_app/SellerProduct/AllProduct/AllProduct.dart';
import 'package:ecommerce_app/SellerProfile/SellerProfileSection.dart';
import 'package:ecommerce_app/SellerProfile/ViewOrder.dart';
import 'package:ecommerce_app/UserLoginRegistration/UserLogin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';
import 'Provider/ProductProvider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Provider.debugCheckInvalidValueType = null;
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => SellerProvider()),
      ChangeNotifierProvider(create: (_) => ProductProvider()),
      ChangeNotifierProvider(create: (_) => CartProvider()),
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
        ProductOrder.id: (context) => ProductOrder(),
        CartScreen.id: (context) => CartScreen(),
      },
    );
  }
}
