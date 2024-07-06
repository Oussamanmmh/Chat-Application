import 'package:chatapp/chat/chatServices.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Message extends StatefulWidget {
  const Message({super.key , required this.receiverID }) ;
  final String receiverID ;

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  final TextEditingController _textEditingController = TextEditingController();
  String _message = '';
  final ChatServices _chatServices = ChatServices();



  @override
  Widget build(BuildContext context) {
    
    
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.blue[100],
        leading:  IconButton(
              color: Colors.black,
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title:  Row(
              
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Container(
                    height: 40,
                     child: CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 30,
                      child: Text('U'),
                                     ),
                   ),
                   SizedBox(width: 40,),
                   Icon(Icons.call , color: Colors.black, size: 30,),
                   Icon(Icons.videocam , color: Colors.black, size: 30,),
                  Icon(
                    Icons.circle,
                    color: const Color.fromARGB(255, 89, 250, 97),
                    size: 20,
                  ),
                ],
              ),
            
        
        
     
        shadowColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(

              child: _messagesList(widget.receiverID),
            ),
            TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(color: Colors.black, width: 2),
                ),
                hintText: 'Type a message',
                suffixIcon: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: ()async {
                    setState(() {
                      _message = _textEditingController.text;
                    });
                    await _chatServices.sendMessage(widget.receiverID, _message);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _messagesList(String receiverID) {
  final ChatServices _chatServices = ChatServices();
  return StreamBuilder(
    stream: _chatServices.getMessages(receiverID),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return CircularProgressIndicator();
      }
      final messages = snapshot.data;
      return ListView.builder(
        itemCount: messages?.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Align(
              
             alignment: messages?[index]['senderID'] == receiverID ? Alignment.centerLeft : Alignment.centerRight,
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: messages?[index]['senderID'] == receiverID ? Colors.grey[300] : Colors.blue,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(messages?[index]['message'] , 
                textAlign: TextAlign.start,
                style: TextStyle(color: Colors.black , fontSize: 20) , )),
            ),
          );
        },
      );
    },
  );
}