import 'package:flutter/material.dart';
import 'package:messagerie_flutter/chat_screen.dart';
import 'package:messagerie_flutter/model/chat_params.dart';
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
    print(widget.user.friendsUid);
    // TODO: implement build
    return Scaffold(
      body: bodyPage(),
    );
  }

  Widget bodyPage() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
            child: Container(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                "Chats",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
          ),
          const Divider(
            height: 20,
            thickness: 1,
            color: Colors.grey,
          ),
          (widget.user.friendsUid == null)
              ? Container(
                  child: Text("sans ami"),
                )
              : Container(
                  padding: EdgeInsets.all(20.0),
                  height: MediaQuery.of(context).size.height - 175,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                      itemCount: widget.user.friendsUid!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return FutureBuilder(future: FirestoreHelper()
                            .getUtilisateur(widget.user.friendsUid![index]),
                            builder: (BuildContext context, AsyncSnapshot<Utilisateur> user) {
                              if (!user.hasData) return Container(); // still loading
                              // alternatively use snapshot.connectionState != ConnectionState.done
                              final Utilisateur peer= user.data!;
                              // return a widget here (you have to return a widget to the builder)
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                                    return ChatScreen(
                                      chatParams: ChatParams(widget.user, peer),
                                    );
                                  }));

                                },
                                child: Card(
                                    child: ListTile(
                                      title: Text(peer.prenom + " " + peer.nom!),
                                    ),
                                ),
                              );
                            });



                      }),
                ),
        ],
      ),
    );
  }
}
