import 'package:flutter/material.dart';
import 'package:messagerie_flutter/chat_screen.dart';
import 'package:messagerie_flutter/model/chat_params.dart';

import 'contact.dart';
import 'functions/FirestoreHelper.dart';
import 'model/Utilisateur.dart';

class chatList extends StatefulWidget {
  Utilisateur user;
  chatList({required Utilisateur this.user});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return chatListState();
  }
}

class chatListState extends State<chatList> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: bodyPage(),
    );
  }

  Widget bodyPage() {
    return Column(
      children: [
        Container(
            padding: EdgeInsets.only(
                top: 20.0, left: 20.0, right: 20.0),
            child: Column(
              children: [
                Container(
                  alignment: AlignmentDirectional.centerEnd,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(10.0),
                          primary: Color(0xFFFF0844),
                          shape: CircleBorder(),
                          elevation: 0
                      ),
                      child: Icon(Icons.add_comment_rounded,
                        size: 30,
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                              return contact(user: widget.user);
                            }));
                      }),
                ),
                Container(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text("Chats",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ),
              ],
            )
        ),
        const Divider(
          height: 20,
          thickness: 1,
          color: Colors.grey,
        ),
        (widget.user.friendsUid==null)?
        Container()
    :ListView.builder(
    itemCount:widget.user.friendsUid!.length ,
    itemBuilder: (BuildContext context,int index){
      Utilisateur peer = FirestoreHelper().getUtilisateur(widget.user.friendsUid![index]) as Utilisateur;
      return GestureDetector(
        onTap: (){
          ChatScreen(chatParams: ChatParams(widget.user,peer),);
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Card(
            margin: EdgeInsets.only(top: 12.0, bottom: 6.0, left: 20.0, right: 20.0),
            child: ListTile(
              title: Text(peer.prenom+" "+peer.nom!),
            ),
          ),
        ),
      );
    }
    ),

      ],
    );
  }
}