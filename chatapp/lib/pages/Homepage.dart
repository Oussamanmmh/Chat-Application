import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:chatapp/pages/auth_page.dart';
import 'package:flutter/material.dart';
import  'LoginPage.dart';
import 'Signup.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        shadowColor: Colors.transparent,
        padding: EdgeInsets.only(bottom:10),
        color: Colors.transparent,
        child: Text(' 2024 © All Rights Reserved | Developed by Oussama',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 15),)),
        appBar: AppBar(
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          title: Center(
            child: Text(
              'Chat App',
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
              ),
             AnimatedTextKit(
              repeatForever: true,
              
              animatedTexts: [
                TypewriterAnimatedText('Welcome to Chat App', textStyle: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                speed: Duration(milliseconds: 100),
                
                
                ),
                

             ],),
              SizedBox(
                height: 50,
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                children: [
                 
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Signup()));
                      },
                      child: AvatarGlow(
                        startDelay: Duration(milliseconds: 5000),
                        duration: Duration(milliseconds: 1000),
                        child:  Text('Sign Up', style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        
                      ),),),
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 81, 225, 209)),
                        padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(horizontal: 90, vertical: 20)),
                        textStyle: MaterialStateProperty.all(
                            TextStyle(fontSize: 20, color: Colors.white)),
                      )),
                ],
              ),
              SizedBox(
                height: 40,
              ),
            OutlinedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Authpage()));
            },
            style: ButtonStyle(
              side: MaterialStateProperty.all(BorderSide(color: Colors.transparent , width: 0)),
              backgroundColor: MaterialStateProperty.all(Colors.transparent) ,
              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20) ,)),
            ),
             child: Text(
              "Do you have already account ? ", style: TextStyle(
                fontSize: 20,
                color: Colors.deepPurple ,
                
          
              ),
             
              ))

            ],
          ),
        )
        
        );
  }
}
