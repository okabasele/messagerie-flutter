import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dashboard.dart';
import 'functions/FirestoreHelper.dart';
import 'register.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner:false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String mail="";
  String password ="";

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        resizeToAvoidBottomInset: false,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(20),

        child:Center(
          child: bodyPage(),
        ) ,
      )

    );
  }


  popUp(){
    showDialog(
      barrierDismissible: false,
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text("Votre adresse mail ou mot de passe est erroné. Veuillez reéssayez."),
            actions: [
              ElevatedButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: Text("OK")
              )
            ],
          );
        }
    );
  }

  Widget bodyPage(){
    return Column(
      children: [
        //Texte de bienvenue
        Container(
          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
            alignment: Alignment.centerLeft,
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Bienvenue",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                Text("Connectez-vous à votre compte Flutter."),
              ],
            ),
        ),

        //Afficher un logo
        Container(
          width: 150,
          height: 150,

          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage("https://firebasestorage.googleapis.com/v0/b/projet-devmob-816f5.appspot.com/o/flutter-messagerie%2Fimages%2Flogo_messaging_app.png?alt=media&token=4da53240-1a35-475a-aeb3-c1fc31fcc983"),
            ),

          ),

        ),
        SizedBox(height: 20,),

        //Utilisateur tape son adresse mail
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
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )
          ),
        ),
        SizedBox(height: 20,),

        //Utilisateur tape son mot de passe
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
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              )
          ),
        ),
        SizedBox(height: 20,),

        //Bouton de connexion
        Container(
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(10.0),
                primary: Color(0xFFFF0844),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                )

            ),
            onPressed: (){
              print("Je suis connecté");
              FirestoreHelper().Connect(mail: mail, password: password).then((value){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context){
                      return dashBoard();
                    }
                ));
              }).catchError((error){
                popUp();
              });
            },
            child: Text("Connexion")
        ),
        ),


        SizedBox(height: 20,),

        // Lien vers une page Inscription
        InkWell(
          onTap: (){
            print("J'ai appuyé sur l'inscription");
            Navigator.push(context, MaterialPageRoute(
                builder: (context){
                  return register();
                }
            ));
          },
          child:Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Text("Vous n'avez pas de compte? ",
            style: TextStyle(
              color: Colors.grey
            ),
            ),
              Text("Inscrivez-vous ici.",
                style: TextStyle(
                    color: Color(0xff838383),
                  fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
        ),

        /*
        Column(
          children: [
            SignInButton(
              Buttons.Google,
              text: "Continuer avec Google",
              onPressed: () {},
            ),
            SignInButton(
              Buttons.Facebook,
              text: "Continuer avec Facebook",
              onPressed: () {},
            ),
          ],
        ),
        */

      ],
    );
    
  }

}
