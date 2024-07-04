import 'package:chatapp/pages/Message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Profile.dart';

class Chatsection extends StatefulWidget {
  const Chatsection({super.key});

  @override
  State<Chatsection> createState() => _ChatsectionState();
}

class _ChatsectionState extends State<Chatsection> {
  final _auth = FirebaseAuth.instance;
  void singOut() async{
    try{
      await _auth.signOut();
    } catch (e){
      print(e);
    }

  }
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    return Scaffold(
      drawer: Drawer(
       surfaceTintColor: Colors.black,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(user!.uid.toString()),
              accountEmail: Text(user!.email.toString()),
              currentAccountPicture: CircleAvatar(
                child: Text('U'),
              ),
            decoration: BoxDecoration(color: Colors.white),
            
      ),
      
      ListTile(
        title: Text('Profile'),
        leading: Icon(Icons.person),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()));
        },
      ),
      ListTile(
        title: Text('Settings'),
        leading: Icon(Icons.settings),
        onTap: () {
          Navigator.pop(context);
        },
      ),

     SizedBox(height: 500),
      ListTile(
        
        title: Text('Logout'),
        leading: Icon(Icons.logout),
        onTap: () {
          singOut();
        },
        
      ),
    ],
  ),
),
appBar: AppBar(
 backgroundColor: Colors.transparent,
 shadowColor: Colors.transparent,
  leading: Builder(builder: (BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.menu , color:Colors.black),
      onPressed: () {
        Scaffold.of(context).openDrawer();
      },
    );
  }),
        
      
),
body: ListView.builder(
  itemCount: 90 ,
   // Remplacer par le nombre réel d'éléments dans votre chat
    itemBuilder: (context, index) {
      return ListTile(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Message())),
        leading: Icon(Icons.message),
        title: Text('Message $index'),
        subtitle: Text('Sous-titre du message $index'),
      );
    },
)
    );
  }
}