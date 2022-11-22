import 'package:chat_app/helper/const.dart';
import 'package:flutter/material.dart';
import '../services/databus.dart';
import 'conversation.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool isLoading = false;
  final _controller = TextEditingController();
  DataBus dataBus = new DataBus();
  Map<String, dynamic> userInfo = {
    "name": "dhiraj",
    "email": "dhirajdarakhe@gmail.com",
  };

  initiateSearch() {
    dataBus.getUserDAtaOnSearch(_controller.text).then((val) {
      setState(() {
        userInfo = val.docs[0].data();
        isLoading = true;
      });
      print(userInfo);
    });
  }
createChatRooomStartConversation(String userName)
{
  String chatRoomid = getRoomId(userName, Constant.MyName);
   List<String> users = [userName, Constant.MyName];
   Map<String, dynamic> chatRoomMap = {
     "users" : users,
     "chatRoomId" : chatRoomid
   };
   dataBus.creatChatRoom(chatRoomid , chatRoomMap);
   Navigator.push(
    context,
    new MaterialPageRoute(
        builder: (BuildContext context) => Conversation(
            ChatRoomId : chatRoomid
        )));
}
  Widget searchList() {
    return userInfo != null
        ? ListView.builder(
            // itemCount: searchShots.docs.length,
            itemCount: 1,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return SearchTile(
                Username: userInfo['name'],
                EmailId: userInfo['email'],
              );
            })
        : Container(
            child: Text("NULL"),
          );
  }

  @override
  Widget build(BuildContext context) {
    return
        Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Image.asset(
          "assets/image/logo.png",
          height: 60.0,
          width: 1350.0,
        ),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 3.0, color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(
                          25.0) //                 <--- border radius here
                      ),
                ),
                // )

                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 2.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        style: TextStyle(
                            // fontSize: 12.0
                            ),
                        // cursorColor: Colors.red,
                        cursorWidth: 3.0,
                        mouseCursor: MouseCursor.defer,
                        decoration: InputDecoration(
                          hintText: 'Search Username',
                          helperStyle: TextStyle(fontSize: 29),
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    // ),
                    SizedBox(
                      width: 21.0,
                    ),

                    GestureDetector(
                      onTap: () {
                        initiateSearch();
                        print("Dhiraj");
                        // userInfo['name'],
                      },
                      child: Container(
                        padding: EdgeInsets.all(0.0),
                        child: Image.asset(
                          "assets/image/search_white.png",
                          color: Colors.black,
                          // width: 56.0,

                          height: 23.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // searchList(),
              SizedBox(
                height: 9.0
                ,
              )
,              userInfo != null
                  ? Container(
                      child: ListTile(
                        title: Text(userInfo['name']),
                        // String name = userInfo['name'],
                        subtitle: Text(userInfo['email']),
                        leading: Icon(Icons.message),
                        onTap: (){
                          createChatRooomStartConversation(
                          "${userInfo['name']}")
                          ;
                        },
                      ),
                    )
                  : Container(
                      child: Text("dhiraj"),
                    )
            ],
          ),
        ),
      ),
    );
  }
}

//
class SearchTile extends StatelessWidget {
  final String Username;
  final String EmailId;
  SearchTile({required this.Username, required this.EmailId});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(Username),
              Text(EmailId),
            ],
          ),
          Spacer(),
          Container(
            decoration: BoxDecoration(
                color: Colors.lightBlue,
                borderRadius: BorderRadius.circular(23.0)),
            padding: EdgeInsets.all(9.0),
            child: Text("Message"
            ,),
          )
        ],
      ),
    );
  }
}


getRoomId(String a, String b)
{
  if(  a.substring(0,1).codeUnitAt(0) >  b.substring(0,1).codeUnitAt(0)){
    return "$b\_$a";
  }
   else {
       return "$a\_$b";
  }
}
