import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File ? _selectedImage ;
  Future _selectImage () async {
    // ignore: deprecated_member_use
    try{
  final returnedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage != null) {
      print('Image selected');
    }
    }
    catch (e){
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        leading:   IconButton(
          color: Colors.black,
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          }),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
      ),
      body:Center(
        child: Column(
          children: [
            SizedBox(height: 50),
           Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Center(
                child: _selectedImage == null ? Text('Please select an image',textAlign: TextAlign.center,style: TextStyle(color: Colors.red),) : Image.file(_selectedImage!),
              ),
              


           ),
           SizedBox(height: 10,),
           OutlinedButton(onPressed:(){
              _selectImage();
           } ,
            child: Text('Edit Profile', style: TextStyle(color: Colors.white),)),
            SizedBox(height: 20),
            Text(user!.uid.toString(), style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            Text(user!.email.toString(), style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            
            ListTile(
              title: Text("Fiends" , style: TextStyle( color: Colors.deepPurple)),
              leading: Icon(Icons.people ,color: Colors.deepPurple,),
              onTap: (){},
            ),
            SizedBox(height: 20),
            ListTile(
              title: Text("Close Friends" , style: TextStyle( color: Colors.deepPurple)),
              leading: Icon(Icons.favorite ,color: Colors.deepPurple,),
            ),
            SizedBox(height: 20),
            ListTile(
              title: Text("Groups" , style: TextStyle( color: Colors.deepPurple)),
              leading: Icon(Icons.face,color: Colors.deepPurple,),
            ),
            SizedBox(height: 20),
            ListTile(
              title: Text("Notes" , style: TextStyle( color: Colors.deepPurple)),
              leading: Icon(Icons.note,color: Colors.deepPurple,),
            ),

         
          ],
        ),
      )
    );
  }
}