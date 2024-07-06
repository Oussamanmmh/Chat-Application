import 'package:chatapp/pages/Message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Profile.dart';
import 'package:chatapp/chat/chatServices.dart';

class Chatsection extends StatefulWidget {
  const Chatsection({super.key});

  @override
  State<Chatsection> createState() => _ChatsectionState();
}

class _ChatsectionState extends State<Chatsection> {
  final _auth = FirebaseAuth.instance;
  final ChatServices _chatServices = ChatServices();

  void signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    if (user == null) return CircularProgressIndicator(); // Add a loading state
    return Scaffold(
      drawer: Drawer(
        surfaceTintColor: Colors.black,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(user.uid.toString()),
              accountEmail: Text(user.email.toString()),
              currentAccountPicture: CircleAvatar(
                child: Text(user.email![0].toUpperCase()),
              ),
              decoration: BoxDecoration(color: Colors.white),
            ),
            ListTile(
              title: Text('Profile'),
              leading: Icon(Icons.person),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Profile()));
              },
            ),
            ListTile(
              title: Text('Settings'),
              leading: Icon(Icons.settings),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(height: 500,),
            ListTile(
              title: Text('Logout'),
              leading: Icon(Icons.logout),
              onTap: () {
                signOut();
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
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        }),
      ),
      body: Column(
        children: [
         SizedBox(
          height: 100,
          child: ListView.builder(
            
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            itemBuilder: (context , index ){
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  child: Text('U'),
                  backgroundColor: Colors.black,
                ),
              );
            },
           
          ),
          ),
         
          Expanded(
            child: _buildUsersList(),
          ),
        ],
      ),
    );
  }
}

Widget _buildUsersList()
{
  return StreamBuilder(
    stream: ChatServices().getUsers(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return CircularProgressIndicator();
      }
      final users = snapshot.data;
      return ListView.builder(
        itemCount: users?.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(users?[index]['email']),
            leading: CircleAvatar(
              child: Text(users?[index]==null ? 'U' : users?[index]['email'][0]),
              
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Message(
                   receiverID: users?[index]['id'],
                  ),
                ),
              );
            }
          );
          
        },
        

      );
    },
  );
}