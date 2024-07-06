import 'package:chatapp/chat/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;


  //get all users 
  Stream <List<Map<String, dynamic>>> getUsers() {
    return _firestore.collection('users').snapshots().map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  Future<void> sendMessage(String receiverID , message)
  {
    final currentUserId = _auth.currentUser?.uid;
    final Timestamp timeStamp = Timestamp.now();
    Message newMessage = Message(senderID: currentUserId!, receiverID: receiverID, message: message, timeStamp: timeStamp);
    List<String> ids = [currentUserId, receiverID];
    ids.sort();
    final chatRoomID = ids.join('_');
    return _firestore.collection("chat_rooms").doc(chatRoomID).collection('messages').add(newMessage.toMap());

   
  }
  //get all messages
  Stream <List<Map<String, dynamic>>> getMessages(String receiverID) {
    final currentUserId = _auth.currentUser?.uid;
    List<String> ids = [currentUserId!, receiverID];
    ids.sort();
    final chatRoomID = ids.join('_');
    return _firestore.collection("chat_rooms").doc(chatRoomID).collection('messages').orderBy( 'timeStamp').snapshots().map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList() );
  }
 


}