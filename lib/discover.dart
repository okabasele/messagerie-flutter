import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:messagerie_flutter/dashboard.dart';
import 'package:messagerie_flutter/model/chat_params.dart';
import 'chat_screen.dart';
import 'functions/FirestoreHelper.dart';
import 'model/Utilisateur.dart';

class discover extends StatefulWidget {
  Utilisateur currentUser;
  discover({required Utilisateur this.currentUser});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return discoverState();
  }
}

class discoverState extends State<discover> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: bodyPage(),
        ),
      ),
    );
  }

  Widget bodyPage() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirestoreHelper().fire_user.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          } else {
            List docs=snapshot.data!.docs;
            List<Utilisateur> users = [];
            for (var i = 0; i < docs.length; i++) {
              Utilisateur user = Utilisateur(docs[i]);
              if (user.id != widget.currentUser.id) {
                print("coucou");
                if (widget.currentUser.friendsUid == null||
                    !(widget.currentUser.friendsUid != null &&
                    widget.currentUser.friendsUid!.contains(user.id))) {
                  print("ça va");
                    users.add(user);
                }
              }
            }
            print(users.length);
            return contentPage(users);
          }
        });
  }

  Widget contentPage(List<Utilisateur> users) {
    CardController controller;
    if(users.isEmpty){
      return AlertDialog(
        title: Text("Revenez plus tard!"),

        actions: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(5.0),
                  primary: Color(0xFFFF0844),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                      return dashBoard(user: widget.currentUser,);
                    }));
              },
              child: Text("OK"))
        ],
      );
    } else {
      return Column(
        children: [
          //Cartes
          Container(
            height: MediaQuery.of(context).size.height * 0.6,
            child: new TinderSwapCard(
              orientation: AmassOrientation.BOTTOM,
              totalNum: users.length,
              stackNum: 3,
              swipeEdge: 4.0,
              maxWidth: MediaQuery.of(context).size.width * 0.9,
              maxHeight: MediaQuery.of(context).size.width * 0.9,
              minWidth: MediaQuery.of(context).size.width * 0.8,
              minHeight: MediaQuery.of(context).size.width * 0.8,
              cardBuilder: (context, index) {
                return Card(
                    child: Stack(
                      children: [
                        (users[index].avatar == null)
                            ? Image.network(
                            "https://www.purdue.edu/veterans/about/images/generic_user.png")
                            : Image.network('${users[index].avatar}'),
                        Positioned(
                            bottom: 0,
                            child: Stack(
                              children: <Widget>[
                                // Stroked text as border.
                                Text(
                                  "${users[index].prenom} ${users[index].nom}",
                                  style: TextStyle(
                                    fontSize: 30,
                                    foreground: Paint()
                                      ..style = PaintingStyle.stroke
                                      ..strokeWidth = 3
                                      ..color = Colors.black,
                                  ),
                                ),
                                // Solid text as fill.
                                Text(
                                  "${users[index].prenom} ${users[index].nom}",
                                  style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            )),
                      ],
                    ));
              },
              cardController: controller = CardController(),
              swipeUpdateCallback: (DragUpdateDetails details, Alignment align) {
                /// Get swiping card's alignment
                if (align.x < 0) {
                  //Card is LEFT swiping
                  //print("left swipe");
                } else if (align.x > 0) {
                  //Card is RIGHT swiping
                  //print("RIGHT swipe");

                }
              },
              swipeCompleteCallback:
                  (CardSwipeOrientation orientation, int index) {
                /// Get orientation & index of swiped card!
                currentIndex = index;
                print("$currentIndex ${orientation.toString()}");
              },
            ),
          ),

          //Icones
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //bouton gauche
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.redAccent,
                      offset: const Offset(
                        0.0,
                        0.0,
                      ),
                      blurRadius: 5.0,
                      spreadRadius: 2.0,
                    ), //BoxShadow
                    BoxShadow(
                      color: Colors.white,
                      offset: const Offset(0.0, 0.0),
                      blurRadius: 0.0,
                      spreadRadius: 0.0,
                    ), //BoxShadow
                  ],
                ),
                child: Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(0.0),
                      elevation: 0.0,
                      primary: Colors.transparent,
                    ),
                    child: Icon(
                      Icons.close,
                      color: Colors.redAccent,
                    ),
                    onPressed: () {
                      controller.triggerLeft();
                    },
                  ),
                ),
              ),

              //bouton droit
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green,
                      offset: const Offset(
                        0.0,
                        0.0,
                      ),
                      blurRadius: 5.0,
                      spreadRadius: 2.0,
                    ), //BoxShadow
                    BoxShadow(
                      color: Colors.white,
                      offset: const Offset(0.0, 0.0),
                      blurRadius: 0.0,
                      spreadRadius: 0.0,
                    ), //BoxShadow
                  ],
                ),
                child: Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(0.0),
                      elevation: 0.0,
                      primary: Colors.transparent,
                    ),
                    child: Icon(
                      Icons.favorite,
                      color: Colors.green,
                    ),
                    onPressed: () {
                      controller.triggerRight();
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("C'est un match!"),
                              content: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        width: 3,
                                        color: Color(0x66FFB099),
                                        style: BorderStyle.solid,
                                      ),
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: (users[currentIndex].avatar ==
                                            null)
                                            ? NetworkImage(
                                            "https://www.purdue.edu/veterans/about/images/generic_user.png")
                                            : NetworkImage(
                                            '${users[currentIndex].avatar}'),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        width: 3,
                                        color: Color(0x66FFB099),
                                        style: BorderStyle.solid,
                                      ),
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: (widget.currentUser.avatar == null)
                                            ? NetworkImage(
                                            "https://www.purdue.edu/veterans/about/images/generic_user.png")
                                            : NetworkImage(
                                            '${widget.currentUser.avatar}'),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              actions: [
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.all(5.0),
                                        primary: Color(0xFFFF0844),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        )),
                                    onPressed: () {
                                      //Ajouter un ami a l'utilisateur courant
                                      List? friendsUid = [];
                                      if (widget.currentUser.friendsUid == null) {
                                        friendsUid.add(users[currentIndex].id);
                                      } else {
                                        friendsUid =
                                        users[currentIndex].friendsUid!;
                                        friendsUid.add(users[currentIndex].id);
                                      }

                                      print(friendsUid);
                                      Map<String, dynamic> map = {
                                        "FRIENDS_UID": friendsUid,
                                      };
                                      FirestoreHelper()
                                          .updateUser(widget.currentUser.id, map);

                                      //Ajouter un ami a l'autre utilisateur
                                      List? peerFriendsUid = [];
                                      if (users[currentIndex].friendsUid ==
                                          null) {
                                        peerFriendsUid.add(widget.currentUser.id);
                                      } else {
                                        peerFriendsUid =
                                        users[currentIndex].friendsUid!;
                                        peerFriendsUid.add(widget.currentUser.id);
                                      }

                                      print(peerFriendsUid);

                                      Map<String, dynamic> peerMap = {
                                        "FRIENDS_UID": peerFriendsUid,
                                      };
                                      FirestoreHelper().updateUser(
                                          users[currentIndex].id, peerMap);

                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                            return ChatScreen(
                                                chatParams: new ChatParams(
                                                    widget.currentUser,
                                                    users[currentIndex]));
                                          }));
                                    },
                                    child: Text('Dites "Bonjour!"'))
                              ],
                            );
                          });
                      /*
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return detail(
                        user: Utilisateur(docs[currentIndex]),
                      );
                    }));
                    */
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    }

  }

}