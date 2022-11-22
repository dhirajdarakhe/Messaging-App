import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../widget.dart';
import 'package:chat_app/helper/authentication.dart';
import 'package:chat_app/services/shared.dart';
import 'chatScreen.dart';
import 'package:chat_app/services/databus.dart';
import 'package:chat_app/services/shared.dart';
import 'package:chat_app/services/databus.dart';
import 'package:chat_app/services/auth.dart';

class SignIn extends StatefulWidget {
  final Function toggle;
  SignIn(this.toggle);
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  late QuerySnapshot snapshot;
  final _formKey = GlobalKey<FormState>();
  Authmethods authmethods = new Authmethods();
  DataBus dataBus = new DataBus();
  TextEditingController EmailTextEditingController =
      new TextEditingController();
  TextEditingController PasswordTextEditingController =
      new TextEditingController();
  bool isLoading = false;
  signIn() {
    if (_formKey.currentState!.validate()) {
      HelperFunction.saveUserEmailSharedPreference(EmailTextEditingController.text);
      setState(() {
        isLoading = true;
      });
      dataBus.getUserDAtaOnSearchEmail(EmailTextEditingController.text)
      .then((val) {
        snapshot = val;
        HelperFunction.saveUserNameSharedPreference(snapshot.docs[0]['name']);
       // TODO::In above line of code error might come because, i have used QuerySnapShoot
      });
      authmethods
          .signInWithEmailAndPassword(EmailTextEditingController.text,
              PasswordTextEditingController.text)
          .then((val) {
        if (val != null) {
          HelperFunction.saveUserLoggedInSharedPreference(true);
          Navigator.pushReplacement(
              context,
              new MaterialPageRoute(
                  builder: (BuildContext context) => ChatRoom()));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              child: Image.asset(
                "assets/image/tk.png",
                height: 60.0,
                width: 1350.0,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    validator: (value) {
                      if (RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value.toString())) {
                        return null;
                      }
                      return "enter valid";
                    },
                    controller: EmailTextEditingController,
                    decoration: kInputDecoration("Email"),
                  ),
                  TextFormField(
                    obscureText: true,
                    validator: (value) {
                      return (value.toString().length < 6)
                          ? 'Please enter 6+ charactor password'
                          : null;
                    },
                    controller: PasswordTextEditingController,
                    decoration: kInputDecoration("Password"),
                  ),
                ],
              ),
            ),
            // TextField(
            //   decoration: kInputDecoration("Email"),
            // ),
            // TextField(
            //   decoration: kInputDecoration("Password"),
            // ),
            SizedBox(
              height: 5,
            ),
            Container(
              alignment: Alignment.bottomRight,
              child: TextButton(
                child: Text(
                  "Forget Password?",
                  textAlign: TextAlign.right,
                  style: TextStyle(color: Colors.black54),
                ),
                onPressed: () {},
              ),
            ),
            SizedBox(
              height: 8,
            ),
            GestureDetector(
              onTap: () {
                signIn();
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 19.0),
                decoration: BoxDecoration(
                  color: Colors.lightBlue,
                  borderRadius: BorderRadius.all(
                    Radius.circular(25.0),
                  ),
                ),
                child: Center(
                  child: Text(
                    "Sign In",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 19.0),
              decoration: BoxDecoration(
                color: Colors.lightGreen,
                borderRadius: BorderRadius.all(
                  Radius.circular(25.0),
                ),
              ),
              child: Center(
                child: Text(
                  "Sign In With Google",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  // alignment: Alignment.center,
                  child: Text(
                    "Don't have account ?",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        color: Colors.black54,
                        // ,fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  // alignment: Alignment.center,
                  child: TextButton(
                    child: Text("Registration now",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            color: Colors.black54,
                            decoration: TextDecoration.underline)),
                    onPressed: () {
                      widget.toggle();
                      // Navigator.pushReplacement(
                      //     context,
                      //     new MaterialPageRoute(
                      //         builder: (BuildContext context) =>
                      //             Authentication()));
                    },
                  ),
                ),
                // ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
