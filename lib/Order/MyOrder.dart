// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:ecommerce_app/Services/Orderservices.dart';
import 'package:ecommerce_app/Utils/Colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyOrder extends StatelessWidget {
  const MyOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final OrderServices _order = OrderServices();
    User? user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.buttonnavigation,
        title: Text(
          'My Orders',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: StreamBuilder<QuerySnapshot>(
                  stream: _order.orders
                      .where('userId', isEqualTo: user!.uid)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    print(user.uid);
                    if (snapshot.hasError) {
                      return Text('Something went Wrong');
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (!snapshot.hasData) {
                      return Center(child: Text('No Orders, Continue'));
                    }

                    return Expanded(
                      child: ListView(
                          shrinkWrap: true,
                          children: snapshot.data!.docs
                              .map((DocumentSnapshot document) {
                            return Container(
                              color: Colors.white,
                              child: Column(children: [
                                ListTile(
                                  leading: CircleAvatar(
                                      backgroundColor: AppColors.buttonColor,
                                      radius: 14,
                                      child: Icon(Icons.list)),
                                  title: Text(
                                    document['orderStatus'],
                                  ),
                                  trailing: Text(
                                      'Amount: Rs.${document['total'].toStringAsFixed(0)}'),
                                ),
                                ExpansionTile(
                                    title: Text('Order Details',
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.black)),
                                    subtitle: Text('View Other details',
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.black)),
                                    children: [
                                      ListView.builder(
                                        shrinkWrap: true,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return ListTile(
                                            leading: CircleAvatar(
                                                child: Image.network(
                                                    document['products'][index]
                                                        ['img'])),
                                            title: Text(document['products']
                                                [index]['productName']),
                                          );
                                        },
                                        itemCount: document['products'].length,
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              left: 12,
                                              right: 12,
                                              top: 8,
                                              bottom: 8),
                                          child: Card(
                                              color: const Color(0xFFe2efdd),
                                              child: Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Column(children: [
                                                    Row(
                                                      children: [
                                                        Text('Seller :'),
                                                        Text(document[
                                                            'storeName']),
                                                      ],
                                                    )
                                                  ]))))
                                    ]),
                              ]),
                            );
                          }).toList()),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}