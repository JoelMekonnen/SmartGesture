import 'package:flutter/material.dart';
import 'secondPage.dart';
class TextWidget extends StatefulWidget {
  @override
  _TextWidgetState createState() => _TextWidgetState();
}

class _TextWidgetState extends State<TextWidget> {
  final TextControl = TextEditingController();
  String url = "";
  @override
  Widget build(BuildContext context) {
    return Column(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
               Padding(
                 padding: EdgeInsets.symmetric(horizontal: 10.0),
                 child: TextField(
                 controller: this.TextControl,
                 decoration: InputDecoration(labelText: 'URL:', labelStyle: TextStyle(fontSize:10)),
                 style: TextStyle(fontSize:10),
               ),
               ),
               Padding(
                 padding: EdgeInsets.symmetric(vertical: 5.0),
                 child: ElevatedButton(
                   onPressed: ()  {
                         this.url = TextControl.value.text;
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>Accelerometer(this.url)));

                   },
                   child: Text("Submit", style:TextStyle(fontSize:10),),),
               )
               

          ]
    );
  }
}