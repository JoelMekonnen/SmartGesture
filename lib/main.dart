import 'package:flutter/material.dart';
import 'package:wear/wear.dart';
import 'FormInput.dart';
void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override 
   Widget build(BuildContext context) {
         return MaterialApp(
           home: Scaffold(
             body: Center (
                child: WatchShape(
                  builder: (context, shape, child) {
                     return Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: <Widget>[
                           TextWidget(),
                       ]
                     );
                  },
                ), 
             ),
           ),
         );
    }
}
