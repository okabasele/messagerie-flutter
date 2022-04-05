import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:messagerie_flutter/functions/FirestoreHelper.dart';
import 'package:messagerie_flutter/main.dart';
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
  late Uint8List? byteData;
  late String fileName;
  late String urlImage;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print(widget.user.avatar);
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
            InkWell(
              onTap: () {
                //Changer la photo
                importerImage();
              },
              child: Container(
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
            ),
            //Bouton deconnexion
            Container(
              padding: EdgeInsets.all(20.0),
              child: Container(
                alignment: AlignmentDirectional.centerEnd,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(10.0),
                        primary: Color(0xFFFF0844),
                        shape: CircleBorder(),
                        elevation: 0),
                    child: Icon(
                      Icons.logout_rounded,
                      size: 30,
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        FirestoreHelper().deconnect();
                        return MyHomePage(title: "");
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

  PopImage() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          if (Platform.isIOS) {
            return CupertinoAlertDialog(
              title: Text("Souhaitez-vous utiliser cette photo comme profil?"),
              content: Image.memory(byteData!),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Annuler")),
                ElevatedButton(
                  onPressed: () {
                    FirestoreHelper()
                        .stockageImage(fileName, byteData!)
                        .then((String lienImage) {
                      setState(() {
                        urlImage = lienImage;
                      });
                    });
                    Map<String, dynamic> map = {
                      "AVATAR": urlImage,
                    };
                    FirestoreHelper().updateUser(widget.user.id, map);
                    Navigator.pop(context);
                    //enregitrer notre image dans la base de donnée
                  },
                  child: Text("Enregistrement"),
                )
              ],
            );
          } else {
            return AlertDialog(
              title: Text("Souhaitez-vous utiliser cette photo comme profil?"),
              content: Image.memory(byteData!),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Annuler")),
                ElevatedButton(
                  onPressed: () {
                    FirestoreHelper()
                        .stockageImage(fileName, byteData!)
                        .then((String lienImage) {
                      setState(() {
                        urlImage = lienImage;
                      });
                    });
                    Map<String, dynamic> map = {
                      "AVATAR": urlImage,
                    };
                    FirestoreHelper().updateUser(widget.user.id, map);
                    Navigator.pop(context);
                    //enregitrer notre image dans la base de donnée
                  },
                  child: Text("Enregistrement"),
                )
              ],
            );
          }
        });
  }

  importerImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      withData: true,
      type: FileType.image,
    );
    if (result != null) {
      setState(() {
        byteData = result.files.first.bytes;
        fileName = result.files.first.name;
      });
      PopImage();
    }
  }
}
