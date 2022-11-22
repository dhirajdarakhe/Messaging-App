import 'package:cloud_firestore/cloud_firestore.dart';

final ass = FirebaseFirestore.instance;
class DataBus {
  getUserDAtaOnSearch(String username) async {
    return await ass
        .collection("user")
        .where("name", isEqualTo: username).get();
  }

  getUserDAtaOnSearchEmail(String useremail) async {
    return await FirebaseFirestore.instance
        .collection("user")
        .where("name", isEqualTo: useremail).get();
  }

  getChatroom(String username)  async {
    return await FirebaseFirestore.instance
        .collection("chatRoom")
        .where("user", isEqualTo: username)
        .snapshots();
        // .get();
  }
  uploaddatBus(data) {
    FirebaseFirestore.instance.collection("user")
        .add(data);
  }
  creatChatRoom(String chatRoomId, chatRoomMap){
    FirebaseFirestore.instance.collection("chatRoom")
        .doc(chatRoomId).set(chatRoomMap);
  }
  addconversationMessage(String chatRoomId, map){
    FirebaseFirestore.instance.collection("chatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .add(map);
  }
  getconversationMessage(String chatRoomId){
   return FirebaseFirestore.instance.collection("chatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy("time",descending: false)
        .snapshots();
  }
}

