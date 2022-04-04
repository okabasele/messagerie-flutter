import 'package:cloud_firestore/cloud_firestore.dart';

class Utilisateur{
  //Attributs
  String id="";
  String prenom="";
  String? nom;
  String mail="";
  DateTime? birthday;
  String? avatar;
  List<String>? friendsUid;



  //Constructeur
  Utilisateur.vide();

  Utilisateur(DocumentSnapshot snapshot){
  id = snapshot.id;
  Map<String,dynamic> map = snapshot.data() as Map<String,dynamic>;
  prenom = map["PRENOM"];
  nom = map["NOM"];
  mail = map ["MAIL"];
  //birthday = map["BIRTHDAY"];
  avatar = map["AVATAR"];
  friendsUid = map["FRIENDS_UID"];
}


  //Methode
}