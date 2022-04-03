import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class myPopUp extends StatefulWidget{
  String text;
  myPopUp({required String this.text});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return myPopUpState();
  }

}

class myPopUpState extends State<myPopUp>{

  @override
  Widget build(BuildContext context) {
    return myPopUp();
  }
  myPopUp(){
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text(widget.text),
            actions: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(5.0),
                      primary: Color(0xFFFF0844),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )

                  ),
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
}