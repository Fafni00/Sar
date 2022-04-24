// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:ecommerce_app/Banner/Categoryforhomepage.dart';
import 'package:ecommerce_app/Banner/banner_widge_page.dart';
import 'package:ecommerce_app/Banner/producthighlights.dart';
import 'package:ecommerce_app/Utils/Colors.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: [
      //code for the background picture and Text on the topleft corner of the screen
      Container(
        //inserting background picture and adjusting its size
        height: 130,
        margin: EdgeInsets.only(right: 240),
        alignment: Alignment.topLeft,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/Decor3.png"), fit: BoxFit.cover),
        ),
      ),

      // to create the app title
      SearchWidget(searchController: searchController),
      SizedBox(height: 6),

      //to create the announcement in the page
      Container(
        color: const Color(0xFF228B22),
        child: Column(children: [
          Container(
            height: 35,
            margin: EdgeInsets.only(left: 20, right: 10),
            child: Row(children: [
              Row(children: [
                Icon(Icons.info_rounded, color: Colors.white, size: 18),
                Text('Promoting Local Business',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ))
              ]),
              SizedBox(
                width: 10,
              ),
              Row(children: [
                Icon(Icons.info_outline, color: Colors.white, size: 18),
                Text('100% Genuine Products',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ))
              ])
            ]),
          )
        ]),
      ),
      SizedBox(height: 2),

      //to display banner
      BannerWigetPage(),
      SizedBox(height: 5),

      //to show product highlights
      ProductHighlights(),
      SizedBox(height: 5),

      //to display the categorylabel
      CategoryHomepage(),
    ])));
  }
}

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    Key? key,
    required this.searchController,
  }) : super(key: key);

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 400,
        margin: EdgeInsets.only(left: 30, top: 0),
        child: Row(
          children: <Widget>[
            Column(
              children: <Widget>[
                Text('Sār',
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF056608),
                    )),
              ],
            ),

            //to create the search bar on the header section
            Column(children: [
              Container(
                  margin: EdgeInsets.only(left: 20),
                  height: 45,
                  width: 220,
                  decoration: BoxDecoration(
                    color: AppColors.textboxColor,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10,
                        spreadRadius: 5,
                        offset: Offset(1, 10),
                        color: Colors.grey.withOpacity(0.3),
                      ),
                    ],
                  ),
                  // to create the hint text and prefix icon in the search bar
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: "Search",
                      hintStyle:
                          TextStyle(fontSize: 14, color: AppColors.text1Color),
                      prefixIcon: Icon(
                        Icons.search,
                        color: AppColors.text1Color,
                      ),

                      //for focused border
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            width: 1.0,
                            color: Colors.white,
                          )),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            width: 1.0,
                            color: Colors.white,
                          )),
                    ),
                  )),
            ])
          ],
        ));
  }
}
