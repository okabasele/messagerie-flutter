import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'MyWidgets/menuDrawer.dart';
import 'detail.dart';
import 'functions/FirestoreHelper.dart';
import 'model/Utilisateur.dart';

class dashBoard extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return dashBoardState();
  }

}

class dashBoardState extends State<dashBoard>{
  late Utilisateur myProfil;
  late String uid;
  late List pages;
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    FirestoreHelper().getIdentifiant().then((String identifiant){
      setState(() {
        uid = identifiant;
        FirestoreHelper().getUtilisateur(uid).then((Utilisateur user){
          setState(() {
            myProfil = user;
          });
        });
      });
    });
    pages = [
      detail(user: myProfil),
      /*
      home(),
      contacts(),
      discover(),
       */
    ];

    return Scaffold(
      body: bodyPage(),
    );
  }

  Widget bodyPage(){
    return StreamBuilder<QuerySnapshot>(
      stream: FirestoreHelper().fire_user.snapshots(),
        builder: (context, snapshot){
        if(!snapshot.hasData){
          return CircularProgressIndicator();
        }
        else
          {
            return Scaffold(
              body: pages[pageIndex],
              bottomNavigationBar: buildMyNavBar(context),
            );
            /*
            List documents = snapshot.data!.docs;
            return ListView.builder(
              itemCount: documents.length,
                itemBuilder: (context,index){
                Utilisateur user = Utilisateur(documents[index]);
                  return ListTile(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context){
                            return detail(user: user);
                          }
                      ));
                    },
                    title:Text("${user.prenom}"),
                    trailing: IconButton(onPressed: (){}, icon: Icon(Icons.edit)),
                  );
                }
            );
            */
          }
        }
    );
  }

//Navigation bar
  Container buildMyNavBar(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Color(0x66FFB099),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 0;
              });
            },
            icon: pageIndex == 0
                ? const Icon(
              Icons.chat_bubble_rounded ,
              color: Color(0xFFFF0844),
              size: 35,
            )
                : const Icon(
              Icons.chat_bubble_rounded ,
              color: Colors.white,
              size: 35,
            ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 1;
              });
            },
            icon: pageIndex == 1
                ? const Icon(
              Icons.explore_rounded,
              color: Color(0xFFFF0844),
              size: 35,
            )
                : const Icon(
              Icons.explore_rounded,
              color: Colors.white,
              size: 35,
            ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 2;
              });
            },
            icon: pageIndex == 2
                ? const Icon(
              Icons.person_rounded,
              color: Color(0xFFFF0844),
              size: 35,
            )
                : const Icon(
              Icons.person_rounded,
              color: Colors.white,
              size: 35,
            ),
          ),
        ],
      ),
    );
  }
}