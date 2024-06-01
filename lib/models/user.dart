import 'package:flutter/material.dart';

class User1{
  final String uid;
  User1({this.uid = ""});
}

class UserData{
  final String uid;
  final String name;
  final String sugars;
  final int strength;
  UserData({required this.uid,required this.name,required this.sugars,required this.strength});

}