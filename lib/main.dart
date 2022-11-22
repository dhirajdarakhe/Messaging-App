import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'helper/authentication.dart';
import 'package:chat_app/views/chatScreen.dart';
import 'helper/seach.dart';
import 'services/shared.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {    // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
   bool isLoggedIn = false;
  void initState() {
    isTheUserLoggedInOrNot();
    // TODO: implement initState
    super.initState();
  }
  isTheUserLoggedInOrNot() async{
    await HelperFunction.getUserLoggedInSharedPreference().then((val){
      isLoggedIn = val;
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: isLoggedIn ? ChatRoom() :Authentication(),
    );
  }
}
