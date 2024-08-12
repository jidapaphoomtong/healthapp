// import 'dart:convert';
// import 'package:health/users/model/user.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class RememberUserPrefs
// {
//   static Future<void> saveRememberUser(User userInfo)  async{
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     String userJsonData = jsonEncode(userInfo.toString());
//     await preferences.setString("currentUser", userJsonData); 
//   }
// }