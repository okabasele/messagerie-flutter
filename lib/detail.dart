import 'package:flutter/material.dart';
import 'contact.dart';
import 'model/Utilisateur.dart';

class detail extends StatefulWidget {
  Utilisateur user;
  detail({required Utilisateur this.user});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return detailState();
  }
}

class detailState extends State<detail> {
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

        Stack(
          children: [
            //Photo
            Container(
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: (widget.user.avatar == null)
                          ? const NetworkImage(
                          "https://www.purdue.edu/veterans/about/images/generic_user.png")
                          : NetworkImage(widget.user.avatar!))),
            ),
            //Barre du haut -ajout ami + modifier le profil
            Container(
              padding: EdgeInsets.all(20.0),
              child: Container(
                alignment: AlignmentDirectional.centerEnd,
                child:ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(10.0),
                          primary: Color(0xFFFF0844),
                          shape: CircleBorder(),
                          elevation: 0
                      ),
                      child: Icon(Icons.settings_rounded,
                        size: 30,
                      ),
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return contact(user: widget.user,);
                        }));
                      }),
              ),
            ),
            
          ],
        ),


        //Information
        Container(
          padding: EdgeInsets.all(20.0),
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "${widget.user.prenom} ${widget.user.nom}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Color(0xFFFF0844),
                    ),
                  ),
                  (widget.user.birthday == null)
                      ? Text(
                          "",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Color(0xFFFF0844),
                          ),
                        )
                      : Text(
                          ", ${widget.user.birthday}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Color(0xFFFF0844),
                          ),
                        )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
