
import 'package:chatapp/pages/Chatsection.dart';
import 'package:chatapp/pages/LoginPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/pages/Homepage.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
 runApp(
    MultiProvider(
      providers: [
        StreamProvider<User?>(
          create: (context) => FirebaseAuth.instance.authStateChanges(),
          initialData: null,
        ),
      ],
      child: MyApp(),
    ),
  );}

class MyApp extends StatelessWidget {
   MyApp({super.key});
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future <void> addData() async {
    await firestore.collection('users').add({'user_name': 'oussama', 'password': '234'});
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      
      title: 'Chat App',
      theme:  ThemeData(
        primaryColor: Color.fromARGB(255, 74, 206, 191),
        
        ),
        routes:
        {
          '/login' :(context) => LoginPage(),
          '/chat' : (context) => Chatsection(),
        
        }
         ,
      home: Homepage() ,
     
    );
  }
}
