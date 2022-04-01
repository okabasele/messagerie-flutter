import 'package:flutter/material.dart';

import 'model/Utilisateur.dart';

class discover extends StatefulWidget {
  Utilisateur user;
  discover({required Utilisateur this.user});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return discoverState();
  }
}

class discoverState extends State<discover> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: bodyPage(),
    );
  }

  Widget bodyPage(){
    return Text("explorer");
  }

}