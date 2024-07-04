

import 'package:chatapp/pages/Chatsection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>(); 
   String _email = '';
   String _password = '';
   Future <User?> login()async{
      try{
   UserCredential resultat =    await _auth.signInWithEmailAndPassword(email: _email , password: _password);
    print("logged in");
       return resultat.user;
     
      } catch (e){
        print("there was an error");
        print(e);
        return null;
      }
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:    IconButton(
          color: Colors.black,
          icon:const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          }),
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        
        
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          
          child: ListView(
            children: [
              SizedBox(height: 50,),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("LOGIN",
                    textAlign: TextAlign.center, 
                    style: TextStyle(
                      fontSize: 30,
                    
                       fontWeight: FontWeight.bold),),
                    SizedBox(height: 40,),
                    TextFormField(
                      validator: (value){
                       if(value!.isEmpty){
                         return 'Please enter your email';
                       }
                        if(!value.contains('@')){
                          return 'Please enter a valid email';
                        }
                        return null;
                      
                      },
                      onSaved: (value){
                        _email = value!;
                      },
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        label: Text('Email'),
                        suffixIcon: const Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      
                    ),
                    SizedBox(height: 20,),
                    TextFormField(
                     
                      validator: (value) => value!.isEmpty ? 'Please enter your password' : null,
                      onSaved: (value){
                        _password = value!;
                      },
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      decoration: InputDecoration(
                        label: Text('Password'),
                        suffixIcon: const Icon(Icons.lock),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    OutlinedButton(
                      onPressed: ()async{
                       if( _formKey.currentState!.validate())
                       {
                         _formKey.currentState!.save();
                          User? user =  await login();
                          
                          if(user == null)
                          {
                            ScaffoldMessenger.of(context).showSnackBar(
                          
                           SnackBar(
                            backgroundColor: Colors.red,
                            showCloseIcon: true,
                            content: Text('Email or password is incorrect'),),
          
          
                         );
                         return ;

                          }
                         ;
                         
                          // Navigator.pushNamed(context, '/chat');
          
          
                       }
                     
                      },
                      child: Text('Login',style:TextStyle(color: Colors.white),), 
                      
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        backgroundColor:Colors.deepPurple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ],
                ),
          
              ),
              SizedBox(height: 30,),
              Text("Or continue with ?",textAlign: TextAlign.center,style: TextStyle(fontSize: 20, )
              ,),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: (){},
                    icon: Icon(Icons.facebook_outlined),
                    iconSize: 50,
                  ),
                  SizedBox(width: 20,),
                  IconButton(
                    onPressed: (){},
                    icon:Icon(Icons.email),
                    iconSize: 50,
                  ),
                ],
          
              )
            ],
          ),
        ),
      ),


    );
  }
}