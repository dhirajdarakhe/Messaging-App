import 'package:flutter/material.dart';


AppBar buildAppBar( ) {
  return AppBar(
      title: Image.asset(
        "assets/image/logo.png",
        height: 60.0,
        width: 1350.0,
      ));
}

InputDecoration kInputDecoration(String hint)
{ return InputDecoration(
    hintText: "$hint",
    hintStyle: TextStyle(color: Colors.grey),
  focusedErrorBorder: UnderlineInputBorder(
  borderSide: BorderSide(color: Colors.grey),
),
enabledBorder: UnderlineInputBorder(
borderSide: BorderSide(color: Colors.lightBlue),
  )
  );

}