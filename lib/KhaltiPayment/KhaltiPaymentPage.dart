import 'package:ecommerce_app/Order/MyOrder.dart';
import 'package:ecommerce_app/Provider/CartProvider.dart';
import 'package:ecommerce_app/Services/Cartservices.dart';
import 'package:ecommerce_app/Services/Orderservices.dart';
import 'package:ecommerce_app/Utils/Colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:provider/provider.dart';

class KhaltiPaymentPage extends StatefulWidget {
  static const String id = 'khaltipayment';
  const KhaltiPaymentPage({Key? key}) : super(key: key);

  @override
  State<KhaltiPaymentPage> createState() => _KhaltiPaymentPageState();
}

class _KhaltiPaymentPageState extends State<KhaltiPaymentPage> {
  final userId = FirebaseAuth.instance.currentUser?.uid;
  TextEditingController amountController = TextEditingController();
  final OrderServices _order = OrderServices();
  final CartServices _cart = CartServices();
  TextEditingController deliveryController = TextEditingController();

  getAmt() {
    return int.parse(amountController.text) * 100; // Converting to paisa
  }

  @override
  Widget build(BuildContext context) {
    var _cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.buttonnavigation,
        title: const Text('Khalti Payment Integration'),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: ListView(
          children: [
            const SizedBox(height: 15),
            // For Amount
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  labelText: "Enter Amount to pay",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  )),
            ),
            const SizedBox(
              height: 8,
            ),
            TextFormField(
              controller: deliveryController,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                  hintText: "Add Address",
                  hintStyle: TextStyle(fontSize: 15),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  )),
            ),
            SizedBox(height: 20),
            // For Button
            MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(color: Colors.red)),
                height: 50,
                color: const Color(0xFF56328c),
                child: const Text(
                  'Pay With Khalti',
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
                onPressed: () {
                  KhaltiScope.of(context).pay(
                    config: PaymentConfig(
                      amount: getAmt(),
                      productIdentity: 'dells-sssssg5-g5510-2021',
                      productName: 'Product Name',
                    ),
                    preferences: [
                      PaymentPreference.khalti,
                    ],
                    onSuccess: (su) {
                      const successsnackBar = SnackBar(
                        content: Text('Payment Successful'),
                      );

                      ScaffoldMessenger.of(context)
                          .showSnackBar(successsnackBar);
                      _saveOrder(_cartProvider);
                      EasyLoading.showSuccess('Your order is submitted');
                    },
                    onFailure: (fa) {
                      const failedsnackBar = SnackBar(
                        content: Text('Payment Failed'),
                      );
                      ScaffoldMessenger.of(context)
                          .showSnackBar(failedsnackBar);
                    },
                    onCancel: () {
                      const cancelsnackBar = SnackBar(
                        content: Text('Payment Cancelled'),
                      );
                      ScaffoldMessenger.of(context)
                          .showSnackBar(cancelsnackBar);
                    },
                  );
                }),
          ],
        ),
      ),
    );
  }

  _saveOrder(CartProvider cartProvider) {
    _order.saveOrder({
      'products': cartProvider.cartList,
      'userId': userId,
      'orderStatus': 'ordered',
      'Delivery Address': deliveryController.text,
    }).then((value) {
      _cart.deleteCart().then((value) {
        _cart.checkData().then((value) {
          Navigator.pushNamed(context, MyOrder.id);
        });
      });
    });
  }
}
