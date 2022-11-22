import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../services/databus.dart';
import 'const.dart';

class Conversation extends StatefulWidget {
  // const Conversation({Key? key}) : super(key: key);
  final String ChatRoomId;
  Conversation({required this.ChatRoomId});

  @override
  _ConversationState createState() => _ConversationState();
}

class _ConversationState extends State<Conversation> {
  DataBus dataBus = new DataBus();
  final _controller = TextEditingController();

  sendMessage() {
    if (_controller.text.isNotEmpty) {
      Map<String, String> meassageMap = {
        "message": _controller.text,
        "sender": Constant.MyName,
        "time": DateTime.now().millisecondsSinceEpoch.toString()
      };
      dataBus.addconversationMessage(widget.ChatRoomId, meassageMap);
      _controller.text = "";
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Image.asset(
        "assets/image/logo.png",
        height: 60.0,
        width: 1350.0,
      )),
      body: Stack(
        children: <Widget>[
          StreamBuilder<QuerySnapshot>(
              stream: dataBus.getconversationMessage(widget.ChatRoomId),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  // ListView.builder( itemCount: snapshot.data!.docs.length,
                  //     itemBuilder: (context, index) =>
                  // MessageTile(
                  //   message: snapshot.data!.docs[index].data["message"];
                  //   isSendByMe: true,
                  // ))
                  final messages12 = snapshot.data!.docs;
                  List<Widget> messageWidget = [];
                  for (var messages in messages12) {
                    final k_message = messages["message"];
                    final who_is_user = messages["sender"];
                    final lastMessage =  MessageTile(
                      message: k_message,
                      isSendByMe: who_is_user == Constant.MyName,
                    );
                    messageWidget.add(lastMessage);
                    // return MessageTile(
                    //   message: k_message,
                    //   isSendByMe: who_is_user == Constant.MyName,
                    // );
                    // final lastMessage = Text(
                    //   k_message,
                    //   style: TextStyle(color: Colors.black),
                    // );
                    // messageWidget.add(lastMessage);
                    // print(messageWidget);
                  }
                  return
               //      Column(
               // children:<Widget> [
                  ListView.builder( itemCount: messageWidget.length,
                    itemBuilder: (context, index) => messageWidget[index],);
               // ]
                    // children: messageWidget,
                  // );
                }
                return Column(
                  children: <Widget>[Text("HI Dhiraj")],
                );
              }),
          Container(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.white12,
              height: 60.0,
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 2.0),
              child: Row(
                children: <Widget>[
                  Container(

                    child: Expanded(

                      child: TextField(
                        controller: _controller,
                        style: TextStyle(),
                        cursorWidth: 3.0,
                        mouseCursor: MouseCursor.defer,
                        decoration: InputDecoration(
                          hintText: 'Type message',
                          helperStyle: TextStyle(fontSize: 29),
                          hintStyle: TextStyle(color: Colors.white24),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  // ),
                  SizedBox(
                    width: 21.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      sendMessage();
                      _controller.clear();
                    },
                    child: Container(
                      padding: EdgeInsets.all(0.0),
                      child: Image.asset(
                        "assets/image/send.png",
                        color: Colors.black,
                        height: 23.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  MessageTile({required this.message, required this.isSendByMe});
  final message;
  final bool isSendByMe;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: isSendByMe ? 0 : 24, right: isSendByMe ? 24 : 0),
      margin: EdgeInsets.symmetric(vertical: 8),
      alignment: isSendByMe ? Alignment.centerRight : Alignment.centerLeft,
      width: MediaQuery.of(context).size.height,
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 17),
          decoration: BoxDecoration(
              borderRadius: isSendByMe
                  ? BorderRadius.only(
                      topLeft: Radius.circular(23),
                      topRight: Radius.circular(23),
                      bottomLeft: Radius.circular(23),
                    )
                  : BorderRadius.only(
                      topLeft: Radius.circular(23),
                      topRight: Radius.circular(23),
                      bottomRight: Radius.circular(23),
                    ),
              gradient:
              isSendByMe ?  LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Colors.purple, Colors.purple]) :
              LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Colors.lightGreen, Colors.lightGreen])
              // LinearGradient(
              //     colors: isSendByMe ? [Colors.red] [Colors.red] : [Colors.blue][Colors.blue])
          ),
          child: Text(
            message,
            style: TextStyle(
              color: Colors.black,
              fontSize: 17,
            ),
          )),
    );
  }
}
