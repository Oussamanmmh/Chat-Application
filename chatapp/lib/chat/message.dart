import 'package:cloud_firestore/cloud_firestore.dart';

class Message{
  final String senderID ;
  final String receiverID ;
  final String message ;
  final Timestamp timeStamp ;
  Message({required this.senderID, required this.receiverID, required this.message, required this.timeStamp});
  Map<String, dynamic> toMap(){
    return {
      'senderID': senderID,
      'receiverID': receiverID,
      'message': message,
      'timeStamp': timeStamp,
    };
  }

}
