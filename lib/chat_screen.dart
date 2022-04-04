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
          backgroundColor: Color(0x66FFB099),
          elevation: 0.0,
          title: Text(chatParams.peer.prenom +" "+chatParams.peer.nom!,
          style: TextStyle(
            color: Colors.black
          ),
          )
      ),
      body: Chat(chatParams:chatParams),
    );
  }
}