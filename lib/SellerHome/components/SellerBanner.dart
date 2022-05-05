// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';

import 'package:ecommerce_app/Utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

import '../../Services/CategoryServices.dart';

class SellerBanner extends StatefulWidget {
  const SellerBanner({Key? key}) : super(key: key);

  @override
  State<SellerBanner> createState() => _SellerBannerState();
}

class _SellerBannerState extends State<SellerBanner> {
  final CategoryService _service = CategoryService();
  double scrollPosition = 0;
  final List _bannerImage = [];

  @override
  void initState() {
    getBanners();
    super.initState();
  }

  getBanners() {
    return _service.homeBanner.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        // to get the documents form the database for banner
        ////add those docs in a list
        setState(() {
          _bannerImage.add(doc['image']);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Container(
            color: AppColors.mainColor.withOpacity(0.2),
            height: 200,
            width: MediaQuery.of(context).size.width,
            child: PageView.builder(
              itemCount: _bannerImage.length,
              itemBuilder: (BuildContext context, int index) {
                return CachedNetworkImage(
                    imageUrl: _bannerImage[index],
                    fit: BoxFit.cover,
                    placeholder: (context, url) => GFShimmer(
                        showShimmerEffect: true,
                        mainColor: AppColors.breadcrumbColor.withOpacity(0.4),
                        secondaryColor:
                            AppColors.breadcrumbColor.withOpacity(0.3),
                        child: Container(
                          height: 160,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 2.0,
                              color: AppColors.mainColor.withOpacity(0.2),
                            ),
                          ),
                        )));
              },
              onPageChanged: (val) {
                setState(() {
                  scrollPosition = val.toDouble();
                });
              },
            ),
          ),
        ),
      ),
      Positioned(
        bottom: 10.0,
        child: DotsiniWidget(scrollPosition: scrollPosition),
      )
    ]);
  }
}

class DotsiniWidget extends StatelessWidget {
  const DotsiniWidget({
    Key? key,
    required this.scrollPosition,
  }) : super(key: key);

  final double scrollPosition;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          child: DotsIndicator(
            position: scrollPosition,
            dotsCount: 3,
            decorator: DotsDecorator(
                color: AppColors.mainColor,
                spacing: EdgeInsets.all(2),
                size: Size.fromRadius(4),
                activeSize: Size(16, 6),
                activeColor: AppColors.buttonColor,
                activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4))),
          ),
        ),
      ],
    );
  }
}
