import 'package:chatapp/pages/Chatsection.dart';
import 'package:chatapp/pages/LoginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Authpage extends StatelessWidget {
  const Authpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.waiting) {
           
            return const Center(
              
              child: CircularProgressIndicator(
               
              
              ),
            );
          }
          if (userSnapshot.hasData) {
            return const Chatsection();
          }
          return const LoginPage();
        },
      )
    );
  }
}