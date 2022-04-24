import 'package:flutter/foundation.dart';

class UserModel {
  String? name;
  String? username;
  String? contact;
  String? email;
  String? password;

  UserModel(
      {this.name, this.username, this.contact, this.email, this.password});

  // getting data from the server
  factory UserModel.fromMap(map) {
    return UserModel(
        name: map['name'],
        username: map['username'],
        contact: map['contact'],
        email: map['email'],
        password: map['password']);
  }

  // sending data to the server
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'username': username,
      'contact': contact,
      'email': email,
      'password': password,
    };
  }
}
