
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; 
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>(); 
   String _username = '';
   String _email = '';
   String _password = '';

    Future<User?> signUp() async {
      try {
       UserCredential resultat =  await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _email,
          password: _password,
          
        );
        return resultat.user;
      } catch (e) {
        print(e);
      }
    }
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        leading:    IconButton(
          color: Colors.black,
          icon: Icon(Icons.arrow_back),
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
            
              Text("SIGN UP",
              textAlign: TextAlign.center, 
              style: TextStyle(
                fontSize: 30,
              
                 fontWeight: FontWeight.bold),),
              SizedBox(height: 40,),
              Form(
                
                key: _formKey,
              child: 
              Column(
                
                children: [
                  TextFormField(
                    onSaved: (value){
                      _username = value.toString();
                    },
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      
                      suffixIcon: Icon(Icons.person),
                      labelText: 'Username',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    validator: (value)  {
                      if (value!.isEmpty )
                      {
                        return 'Please enter your username';
                      }
                      return null;
                    
                    },
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    onSaved: (value){
                      _email = value.toString();
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.email),
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)
                      ),
                    ),
                    validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }

                  return null;
                },
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    
                   obscureText: true,
                    decoration: InputDecoration(
                      
                      suffixIcon: Icon(Icons.lock), 
                      labelText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    validator: (value)  {
                      if (value!.isEmpty )
                      {
                        return 'Please enter your password';
                      }
                      return null;
                    
                    },
                    onSaved: (value){
                      _password = value.toString();

                    },

                  ),
                  SizedBox(height: 20,),
                
                
                  SizedBox(height: 20,),
                  OutlinedButton (onPressed: () async{
                   
                      if (_formKey.currentState?.validate() ?? false) {
                   
                      _formKey.currentState?.save();
                    try{
                    User? user =  await signUp();
                     if(user== null)
                     {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            showCloseIcon: true,
                            backgroundColor: Colors.red,
                            content: Text('Email or password is incorrect'),
                          )
                        );
                       
                      } else {
                        Navigator.pushNamed(context, '/chat');
                     }
                    } catch (e){

                      print(e);}

                  }
                    
                  }, 
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: Colors.deepPurple,
                  ),
                  child: Text('Sign Up', style: TextStyle(color: Colors.white),))
                ],
              ),
              )
            ],
          ),
        ),
      ),


    );;
  }
}