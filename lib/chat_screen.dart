import 'package:flutter/material.dart';
import 'package:messagerie_flutter/dashboard.dart';
import 'chat.dart';
import 'model/chat_params.dart';

class ChatScreen extends StatelessWidget {
  final ChatParams chatParams;
  const ChatScreen({Key? key, required this.chatParams}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Color(0xFFFF0844)),
            onPressed: () =>  Navigator.push(context, MaterialPageRoute(builder: (context) {
              return dashBoard(user: chatParams.user);
            })),
          ),
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: Text(chatParams.peer.prenom +" "+chatParams.peer.nom!,
          style: TextStyle(
            color: Colors.black
          ),
          )
      ),
      body:  Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage("https://user-images.githubusercontent.com/15075759/28719144-86dc0f70-73b1-11e7-911d-60d70fcded21.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Chat(chatParams:chatParams),
      ),
    );
  }
}