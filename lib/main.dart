import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:projetb2c/dashboard.dart';
import 'package:projetb2c/functions/FirestoreHelper.dart';
import 'package:projetb2c/register.dart';


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
      theme: ThemeData(
        primarySwatch: Colors.blue,
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
      appBar: AppBar(

        title: const Text("B2_C"),
        backgroundColor: Colors.red,
      ),
      body: Container(
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
            title: Text("Erreur !!!"),
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
        //Afficher un logo
        Container(
          width: 150,
          height: 150,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage("https://voitures.com/wp-content/uploads/2017/06/Kodiaq_079.jpg.jpg"),
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
              borderRadius: BorderRadius.circular(20),
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
                borderRadius: BorderRadius.circular(20),
              )
          ),
        ),
        SizedBox(height: 20,),
        //Bouton de connexion
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.amber,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)
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
          child: Text("Inscription",style: TextStyle(color: Colors.blue),),
        )

      ],
    );
    
  }

}
