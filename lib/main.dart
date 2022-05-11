// ignore_for_file: prefer_const_constructors

import 'package:ecommerce_app/KhaltiPayment/KhaltiPaymentPage.dart';
import 'package:ecommerce_app/Order/MyOrder.dart';
import 'package:ecommerce_app/Provider/CartProvider.dart';
import 'package:ecommerce_app/Cart/CartScreen.dart';
import 'package:ecommerce_app/Provider/SellerProvider.dart';
import 'package:ecommerce_app/SellerProduct/AddProduct/AddProductScreen.dart';
import 'package:ecommerce_app/SellerProduct/AllProduct/AllProduct.dart';
import 'package:ecommerce_app/SellerProduct/ProductOrder/ProductOrder.dart';
import 'package:ecommerce_app/SellerProfile/SellerProfileNavigation.dart';
import 'package:ecommerce_app/SellerProfile/SellerProfileSection.dart';
import 'package:ecommerce_app/Splashscreen/Splashpage.dart';
import 'package:ecommerce_app/UserLoginRegistration/UserLogin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';
import 'Provider/ProductProvider.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

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
    return KhaltiScope(
        publicKey: "test_public_key_bc6096f2b51342a483ac04906c1a1096",
        builder: (context, navigatorKey) {
          return GetMaterialApp(
            navigatorKey: navigatorKey,
            supportedLocales: const [
              Locale('en', 'US'),
              Locale('ne', 'NP'),
            ],
            localizationsDelegates: const [
              KhaltiLocalizations.delegate,
            ],
            debugShowCheckedModeBanner: false,
            title: 'Sar',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              scaffoldBackgroundColor: Colors.white,
            ),
            home: Splashpage(),
            builder: EasyLoading.init(),
            routes: {
              SellerProfileSection.id: (context) => SellerProfileSection(),
              AddProductScreen.id: (context) => AddProductScreen(),
              AllProduct.id: (context) => AllProduct(),
              Loginpage.id: (context) => Loginpage(),
              CartScreen.id: (context) => CartScreen(),
              ProductOrder.id: (context) => ProductOrder(),
              KhaltiPaymentPage.id: (context) => KhaltiPaymentPage(),
              MyOrder.id: (context) => MyOrder(),
              SellerProfileNavigation.id: (context) =>
                  SellerProfileNavigation(),
            },
          );
        });
  }
}
