// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:ecommerce_app/SellerLoginRegistration/SellerLogin.dart';
import 'package:ecommerce_app/Services/SellerRegistrationServices.dart';
import 'package:ecommerce_app/Utils/Colors.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class SellerRegistrationForm extends StatefulWidget {
  const SellerRegistrationForm({Key? key}) : super(key: key);

  @override
  State<SellerRegistrationForm> createState() => _SellerRegistrationFormState();
}

class _SellerRegistrationFormState extends State<SellerRegistrationForm> {
  final _auth = FirebaseAuth.instance;
  final SellerRegistrationServices _service = SellerRegistrationServices();
  final _formKey = GlobalKey<FormState>();
  final _storeName = TextEditingController();
  final _ownerName = TextEditingController();
  final _contactNumber = TextEditingController();
  final _emailAddress = TextEditingController();
  final _panNumber = TextEditingController();
  final _vatNumber = TextEditingController();
  final _address = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();

  String? _StoreName;
  String? _Registrationtype;
  XFile? _storeImage;
  String? _storeImageUrl;
  final ImagePicker _picker = ImagePicker();

  Widget _formField(
      {TextEditingController? controller,
      String? label,
      TextInputType? type,
      TextInputAction? inputaction,
      String? Function(String?)? validator}) {
    return TextFormField(
      controller: controller,
      keyboardType: type,
      textInputAction: inputaction,
      validator: validator,
      onChanged: (value) {
        if (controller == _storeName) {
          setState(() {
            _StoreName = value;
          });
        }
      },
      decoration: InputDecoration(
        labelText: label,
        prefixText: controller == _contactNumber ? '+977' : null,
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
    );
  }

  Future<XFile?> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    return image;
  }

  _scaffold(message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          message,
        ),
        action: SnackBarAction(
          label: 'ok',
          onPressed: () {
            ScaffoldMessenger.of(context).clearSnackBars();
          },
        )));
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Scaffold(
            body: SingleChildScrollView(
                child: Column(children: [
          SizedBox(
            height: 300,
            child: Stack(
              children: [
                _storeImage == null
                    ? Container(
                        height: 250,
                        width: 300,
                        margin: EdgeInsets.only(top: 60),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 2,
                                offset: Offset(3, 3),
                                color:
                                    AppColors.breadcrumbColor.withOpacity(0.1),
                              ),
                              BoxShadow(
                                blurRadius: 2,
                                offset: Offset(-3, -3),
                                color:
                                    AppColors.breadcrumbColor.withOpacity(0.1),
                              ),
                            ]),
                        child: TextButton(
                          child: Center(
                            child: Text('Tap to add image',
                                style: TextStyle(color: AppColors.buttonColor)),
                          ),
                          onPressed: () {
                            _pickImage().then((value) {
                              setState(() {
                                _storeImage = value;
                              });
                            });
                          },
                        ))
                    : InkWell(
                        onTap: () {
                          _pickImage().then((value) {
                            setState(() {
                              _storeImage = value;
                            });
                          });
                        },
                        child: Container(
                          height: 240,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: FileImage(
                                File(_storeImage!.path),
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
            child: Column(
              children: [
                //for Storename
                _formField(
                    controller: _storeName,
                    label: 'Store Name',
                    type: TextInputType.text,
                    inputaction: TextInputAction.next,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Store Name';
                      }
                      return null;
                    }),
                SizedBox(height: 30),

                //for Ownername
                _formField(
                    controller: _ownerName,
                    label: 'Owner Name',
                    type: TextInputType.text,
                    inputaction: TextInputAction.next,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Owner Name';
                      }
                      return null;
                    }),
                SizedBox(height: 30),

                //for Contact Number
                _formField(
                    controller: _contactNumber,
                    label: 'Contact Number',
                    type: TextInputType.phone,
                    inputaction: TextInputAction.next,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Contact Number';
                      }
                    }),
                SizedBox(height: 30),

                //for Email Address
                _formField(
                    controller: _emailAddress,
                    label: 'Email',
                    type: TextInputType.emailAddress,
                    inputaction: TextInputAction.next,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Email';
                      }
                      bool _isValid = (EmailValidator.validate(value));
                      if (_isValid == false) {
                        return 'Invalid Email';
                      }
                    }),
                SizedBox(height: 30),

                ////for Dropdown Registration Number
                Row(
                  children: [
                    Text('Registration Number:',
                        style: TextStyle(
                            color: AppColors.buttonColor.withOpacity(0.5))),
                    Expanded(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButtonFormField(
                            style: const TextStyle(
                              color: Color(0xFF1F9D0C),
                            ),
                            value: _Registrationtype,
                            validator: (String? value) {
                              if (value == null) {
                                return 'Select Registration Type';
                              }
                            },
                            hint: Text('Select Type',
                                style: TextStyle(
                                    color: AppColors.buttonColor
                                        .withOpacity(0.5))),
                            items: <String>['PAN Number', 'VAT Number']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              setState(() {
                                _Registrationtype = value;
                              });
                            }),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20),

                //for PAN Number field
                if (_Registrationtype == "PAN Number")
                  _formField(
                      controller: _panNumber,
                      label: 'PAN Number',
                      type: TextInputType.emailAddress,
                      inputaction: TextInputAction.next,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter PAN Number';
                        }
                      }),

                //for PAN Number field
                if (_Registrationtype == "VAT Number")
                  _formField(
                      controller: _vatNumber,
                      label: 'VAT Number',
                      type: TextInputType.emailAddress,
                      inputaction: TextInputAction.next,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter VAT Number';
                        }
                      }),

                SizedBox(height: 30),

                //for Address
                _formField(
                    controller: _address,
                    label: 'Address',
                    type: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Store Address';
                      }
                    }),
                SizedBox(height: 30),

                //for Password
                _formField(
                  controller: _password,
                  label: 'Password',
                  type: TextInputType.text,
                  inputaction: TextInputAction.next,
                  validator: (value) {
                    RegExp regex = RegExp(r'^.{6,}$');
                    if (value!.isEmpty) {
                      return ("Please Enter Password");
                    }
                    if (!regex.hasMatch(value)) {
                      return ("Please Enter Correct password(Min. 6 Characters)");
                    }
                  },
                ),
                SizedBox(height: 30),

                //for Confirm Password
                _formField(
                  controller: _confirmPassword,
                  label: 'Confirm Password',
                  type: TextInputType.text,
                  validator: (value) {
                    if (_confirmPassword.text != _password.text) {
                      return "Password Doesn't Match";
                    }
                    return null;
                  },
                )
              ],
            ),
          ),

          SizedBox(height: 20),

          //for Register Button
          Row(children: [
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        child: Text('Register'),
                        style: ElevatedButton.styleFrom(
                            primary: AppColors.buttonColor),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            signUp().then((value) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                      content: Text(
                                'Seller Registered Successfully',
                              )));
                              Navigator.pushAndRemoveUntil(
                                  (context),
                                  MaterialPageRoute(
                                      builder: (context) => SellerLoginpage()),
                                  (route) => false);
                            });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Registration Failed')));
                          }
                        })))
          ])
        ]))));
  }

  Future<void> signUp() async {
    String? _newUid = null;
    _newUid = await _auth
        .createUserWithEmailAndPassword(
            email: _emailAddress.text, password: _password.text)
        .then((value) => FirebaseAuth.instance.currentUser?.uid)
        .catchError((e) {
      Fluttertoast.showToast(msg: e!.message);
    });
    if (_storeImage == null) {
      _scaffold('Shop Image not Selecetd');
      return;
    }
    _service
        .uploadImage(_storeImage, 'seller/${_service.user?.uid}/__shopImage')
        .then((String? url) {
      if (url != null) {
        _storeImageUrl = url;
      }
    }).then((value) {
      _service.addSeller(data: {
        'storeImage': _storeImageUrl,
        'storeName': _storeName.text,
        'ownerName': _ownerName.text,
        'contactNumber': '+977${_contactNumber.text}',
        'emailAddress': _emailAddress.text,
        'password': _password.text,
        'registrationtype': _Registrationtype,
        'panNumber': _panNumber.text,
        'vatNumber': _vatNumber.text,
        'address': _address.text,
        'approved': true,
        'uid': _newUid
      });
    });
  }
}
