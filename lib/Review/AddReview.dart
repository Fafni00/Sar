import 'package:ecommerce_app/Order/MyOrder.dart';
import 'package:ecommerce_app/Services/Reviewservices.dart';
import 'package:ecommerce_app/Utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class AddReview extends StatefulWidget {
  const AddReview({Key? key}) : super(key: key);

  @override
  State<AddReview> createState() => _AddReviewState();
}

class _AddReviewState extends State<AddReview> {
  //declaring global form key
  final _formkey = GlobalKey<FormState>();
  final ReviewServices _reviewServices = ReviewServices();
  // editing controllers
  final productname = TextEditingController();
  final storename = TextEditingController();
  final username = TextEditingController();
  final review = TextEditingController();

  Widget _textField({
    TextEditingController? controller,
    String? label,
    TextInputType? inputType,
    int? maxLine,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: inputType,
      maxLines: maxLine,
      decoration: InputDecoration(
        label: Text(label!),
        labelStyle: TextStyle(
            color: AppColors.buttonColor.withOpacity(0.5), fontSize: 14),
        contentPadding:
            EdgeInsets.only(top: 15, bottom: 15, left: 20, right: 20),
        border: InputBorder.none,
        fillColor: Colors.white,
        filled: true,
        //for focused border
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.vertical(),
            borderSide: BorderSide(
              width: 1.0,
              color: AppColors.textboxColor,
            )),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.vertical(),
            borderSide: BorderSide(
              width: 2.0,
              color: AppColors.textboxColor,
            )),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'enter $label';
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.buttonnavigation,
          title: Text(
            'Reviews',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => MyOrder())));
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(children: [
              SizedBox(height: 40),
              // productnamefield
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _textField(
                    label: ' Enter Product Name',
                    inputType: TextInputType.text,
                    controller: productname),
              ),
              SizedBox(height: 10),

              //storenamefield
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _textField(
                    label: ' Enter Store Name',
                    inputType: TextInputType.text,
                    controller: storename),
              ),
              SizedBox(height: 10),

              // usernamefield
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _textField(
                    label: ' Enter UserName',
                    inputType: TextInputType.text,
                    controller: username),
              ),
              SizedBox(height: 10),

              // reviewfield
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _textField(
                    label: ' Add Review',
                    inputType: TextInputType.text,
                    controller: review,
                    maxLine: 10),
              ),
              SizedBox(height: 10),

              ElevatedButton(
                  child: Text('Add Review'),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xFF056608))),
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      _reviewServices.addReview(data: {
                        'productName': productname.text,
                        'storeName': storename.text,
                        'userName': username.text,
                        'review': review.text
                      }).then((value) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                          'Review Added Successfully',
                        )));
                        productname.clear();
                        storename.clear();
                        username.clear();
                        review.clear();
                      });
                    }
                  })
            ]),
          ),
        ));
  }
}
