import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Message extends StatefulWidget {
  const Message({super.key}) ;

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  final TextEditingController _textEditingController = TextEditingController();
  String _message = '';

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

              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                     Text('12:00' , style: TextStyle(color: Colors.black),),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Column(
                        children:[ Container(
                          
                          decoration: BoxDecoration(
                             
                            borderRadius: BorderRadius.circular(20),
                            color: _message != ''
                                ? const Color.fromARGB(255, 86, 255, 91)
                                : Colors.transparent,
                          ),
                          padding: EdgeInsets.all(10),
                          child: Text(
                            
                      
                            _message,
                            style: TextStyle(
                          
                              backgroundColor:
                                  const Color.fromARGB(255, 86, 255, 91),
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                        ),
                       
                        ],
                      ),

                    ),
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        
                        decoration: BoxDecoration(
                           
                          borderRadius: BorderRadius.circular(20),
                          color: _message != ''
                              ? Color.fromARGB(255, 189, 189, 189)
                              : Colors.transparent,
                        ),
                        padding: EdgeInsets.all(10),
                        child: Text(
                          

                          _message,
                          style: TextStyle(
                        
                            backgroundColor:
                                Color.fromARGB(255, 189, 189, 189),
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    
                  ],
                ),
              ),
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
                  onPressed: () {
                    setState(() {
                      _message = _textEditingController.text;
                    });
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
