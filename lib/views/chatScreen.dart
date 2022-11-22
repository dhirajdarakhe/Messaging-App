import 'package:chat_app/services/databus.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/services/auth.dart';
import 'package:chat_app/helper/authentication.dart';
import 'package:chat_app/helper/seach.dart';
import 'package:chat_app/helper/const.dart';
import 'package:chat_app/services/shared.dart';

class ChatRoom extends StatefulWidget {
  const ChatRoom({Key? key}) : super(key: key);

  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  Authmethods authmethods = new Authmethods();
  DataBus dataBus = new DataBus();
  late Stream chatroomStrem;

  // DataBus dataBus = new DataBus();
  // late Stream chatroomStrem;
  // Widget chatRoomList()
  // { return StreamBuilder(
  //     stream:chatroomStrem ,
  //     builder: (_, snapshot) =>
  //        snapshot.hasData ? ListView.builder(
  //           itemCount:  snapshot.data!.docs.length,
  //           itemBuilder: (BuildContext context, int index)
  //           {
  //
  //           },
  //         ) : Container();
  // );
  //
  // }
  @override
  void initState() {
    // TODO: implement initState
    getUserInfo();
    dataBus.getChatroom(Constant.MyName).then((value)
    {
      setState(() {
        chatroomStrem = value;
      });

    });
    super.initState() ;
  }
  getUserInfo() async{
    Constant.MyName =  await HelperFunction.sgetUserNameSharedPreference();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Image.asset(
          "assets/image/logo.png",
          height: 60.0,
          width: 1350.0,
        ),
        actions: [
          GestureDetector(
              onTap: () {
                authmethods.SignOut();
                Navigator.pushReplacement(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => Authentication()));
              },
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Icon(Icons.exit_to_app)))
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.search),
          onPressed: () {
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (BuildContext context) => SearchScreen()));
          }),
      // body: chatRoomList(),
    );
  }
}
