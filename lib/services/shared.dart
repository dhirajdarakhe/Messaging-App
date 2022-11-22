import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class HelperFunction{

  static String sharedPreferencesUserLoggedKey = "ISLOGGEDIN";
  static String sharedPreferencesUserNameKey = "USERNAMEKEY";
  static String sharedPreferencesUserEmaildKey = "USEREMAILKEY";

  // save data in shared preferences

  static Future<bool> saveUserLoggedInSharedPreference( bool isUserLoggedIn) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(sharedPreferencesUserLoggedKey, isUserLoggedIn);
  }
  static Future<bool> saveUserNameSharedPreference( String isUserName) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferencesUserNameKey, isUserName);
  }
  static Future<bool> saveUserEmailSharedPreference( String isUserEmail) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferencesUserEmaildKey, isUserEmail);
  }

// get the data from shared preferences

  static Future<bool> getUserLoggedInSharedPreference() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getBool(sharedPreferencesUserLoggedKey);
  }
  static Future<String> sgetUserNameSharedPreference() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString(sharedPreferencesUserNameKey);
  }
  static Future<String> getUserEmailSharedPreference(  ) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString(sharedPreferencesUserEmaildKey);
  }



}