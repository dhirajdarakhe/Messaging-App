import 'package:flutter/material.dart';
import 'chatScreen.dart';
import '../widget.dart';
import 'package:chat_app/services/auth.dart';
import 'package:chat_app/services/shared.dart';
import 'package:chat_app/services/databus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUp extends StatefulWidget {
  // const SignUp({Key? key}) : super(key: key);
  final Function toggle;
  SignUp(this.toggle);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  // HelperFunction   helperFunction =  new   HelperFunction();
  DataBus dataBus = new DataBus();
  Authmethods authmethods = new Authmethods();
  final _formKey = GlobalKey<FormState>();
  // GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController UserNameTextEditingController =
      new TextEditingController();
  TextEditingController EmailTextEditingController =
      new TextEditingController();
  TextEditingController PasswordTextEditingController =
      new TextEditingController();
  bool isLoading = false;
  signMeUP() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      HelperFunction.saveUserNameSharedPreference(UserNameTextEditingController.text);
      HelperFunction.saveUserEmailSharedPreference(EmailTextEditingController.text);

      authmethods
          .signUnWithEmailAndPassword(EmailTextEditingController.text,
              PasswordTextEditingController.text)
          .then((val) {
          Map<String, String> userInfo= {
            "name" : UserNameTextEditingController.text,
            "email": EmailTextEditingController.text,
          };

        dataBus.uploaddatBus(userInfo);
          HelperFunction.saveUserLoggedInSharedPreference(true);
          Navigator.pushReplacement(
            context,
            new MaterialPageRoute(
                builder: (BuildContext context) => ChatRoom()));
          });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
      body: isLoading
          ? Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            )
          : Container(
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
                    height: 0,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Valid Username';
                            }
                            return null;
                          },
                          controller: UserNameTextEditingController,
                          decoration: kInputDecoration("Username"),
                        ),
                        TextFormField(
                          validator: (value) {
                            // print(value.toString());
                            // print(value);
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
                  SizedBox(
                    height: 3,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  GestureDetector(
                    onTap: () {
                      signMeUP();
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
                          "Sign Up",
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
                        "Sign Up With Google",
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
                          "Already have account ?",
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
                            child: Text("Sign in",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    color: Colors.black54,
                                    decoration: TextDecoration.underline)),
                            onPressed: () {
                              widget.toggle();
                              // Navigator.push(
                              //     context,
                              //     new MaterialPageRoute(
                              //         builder: (BuildContext context) => Authentication()));
                            },
                          ),
                        ),

                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
