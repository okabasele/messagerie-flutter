import 'package:flutter/material.dart';

import 'contact.dart';
import 'model/Utilisateur.dart';

class chat extends StatefulWidget {
  Utilisateur user;
  chat({required Utilisateur this.user});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return chatState();
  }
}

class chatState extends State<chat> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: bodyPage(),
    );
  }

  Widget bodyPage(){
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top:20.0,left: 20.0,right: 20.0),
          child:Column(
          children: [
            Container(
              alignment: AlignmentDirectional.centerEnd,
              child:ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(10.0),
                        primary: Color(0xFFFF0844),
                        shape: CircleBorder(),
                        elevation: 0
                    ),
                    child: Icon(Icons.add_comment_rounded,
                      size: 30,
                    ),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return contact(user: widget.user);
                      }));
                    }),
            ),
            Container(
              alignment: AlignmentDirectional.centerStart,
              child:Text("Chats",
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


      ],
    );
  }

}