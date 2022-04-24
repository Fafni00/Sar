/*import 'package:ecommerce_app/Sellerregistration/SellerLogin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'SellerRegistrationForm.dart';

class SellerLoginService extends StatelessWidget {
  const SellerLoginService({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //user is not signed in
          if (!snapshot.hasData) {
            return const SellerLoginpage();
          }

          return const SellerRegistrationForm();
        });
  }
}*/
