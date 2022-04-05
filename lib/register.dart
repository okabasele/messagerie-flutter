import 'package:flutter/material.dart';
import 'package:messagerie_flutter/main.dart';
import 'functions/FirestoreHelper.dart';
import 'model/Utilisateur.dart';
import 'myWidgets/popUp.dart';

class register extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return registerState();
  }

}

class registerState extends State<register>{
  //Variable
  String nom="";
  String prenom ="";
  String mail="";
  String password="";
  Utilisateur? registered;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color(0xFFFF0844),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body:Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
            child:bodyPage()
        ),
      )

    );
  }


  Widget bodyPage(){
    return Column(
      children: [
        //Texte de bienvenue
        Container(
          alignment: Alignment.centerLeft,
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Inscription",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              Text("Créez un compte gratuitement."),
            ],
          ),
        ),
        SizedBox(height: 20,),

        //Nom de famille
        TextField(
          cursorColor: Color(0xFFFF0844),

          onChanged: (value){
            setState(() {
              nom = value;
            });
          },
          decoration: InputDecoration(
              hintText: "Entrer votre nom",
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFFFF0844),
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFFFF0844),
                ),
                borderRadius: BorderRadius.circular(10),
              )
          ),
        ),
        SizedBox(height: 20,),

        //Prénom
        TextField(
          onChanged: (value){
            setState(() {
              prenom = value;
            });
          },
          decoration: InputDecoration(
              hintText: "Entrer votre prenom",
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFFFF0844),
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFFFF0844),
                ),
                borderRadius: BorderRadius.circular(10),
              )
          ),
        ),
        SizedBox(height: 20,),

        //Adresse mail
        TextField(
          onChanged: (value){
            setState(() {
              mail = value;
            });
          },
          decoration: InputDecoration(
              hintText: "Entrer votre adresse mail",
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFFFF0844),
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFFFF0844),
                ),
                borderRadius: BorderRadius.circular(10),
              )
          ),
        ),
        SizedBox(height: 20,),

        //Mot de passe
        TextField(
          onChanged: (value){
            setState(() {
              password = value;
            });
          },
          obscureText: true,
          decoration: InputDecoration(
              hintText: "Entrer votre mot de passe",
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFFFF0844),
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFFFF0844),
                ),
                borderRadius: BorderRadius.circular(10),
              )
          ),
        ),
        SizedBox(height: 20,),

        //Bouton d'inscription

        Container(
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(10.0),
              primary: Color(0xFFFF0844),
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              )),
              onPressed: (){

                FirestoreHelper().inscription(mail: mail, password: password, prenom: prenom,nom: nom).then((value) {
                  FirestoreHelper().getIdentifiant().then((String identifiant){
                      FirestoreHelper().getUtilisateur(identifiant).then((Utilisateur user){
                        setState(() {
                          registered = user;
                        });
                      });
                  });
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return MyHomePage(title: '');
                  }));
                }).catchError((error) {
                  myPopUp(
                    text:
                        "Votre adresse mail ou mot de passe est érroné. Veuillez réessayer.",
                  );
                });
              },
              child: Text("Inscription")
          ),
        ),

      ],
    );
  }

}