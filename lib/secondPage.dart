import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:sensors/sensors.dart';



String url;

class Accelerometer extends StatefulWidget {
   String URL;
  Accelerometer(this.URL) {
        url = this.URL;
  }
  @override
  _AccelerometerState createState() => _AccelerometerState();
  
}

class _AccelerometerState extends State<Accelerometer> {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(
      body: Container(child:
     Column(
       crossAxisAlignment: CrossAxisAlignment.center,
       mainAxisAlignment: MainAxisAlignment.spaceAround,
       children: <Widget>[
            ToggleButton(),
            
       ]
    ),
    ),
    ),
    );
  }
}
class ToggleButton extends StatefulWidget {
   final List<bool> isSelected = [false];

  @override
  _ToggleButtonState createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  bool startToggle = false;
  String X = "";  // accelerometer X position
  String Y = ""; // accelerometer Y position
  String Z = ""; // accelerometer Z position
  final _channel = IOWebSocketChannel.connect('ws://'+url+'/accelerometer/');
  void initState() {
        accelerometerEvents.listen((AccelerometerEvent event){
        _onAccelerate(event);
        });
        super.initState();
  }
  void _onAccelerate(AccelerometerEvent event)
  {
        setState((){
            X = event.x.toString();
            Y = event.y.toString();
            Z = event.z.toString();
        });
  }
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
            StreamBuilder(
                stream: _channel.stream,
                builder: (context, snapshot) {
                     if (snapshot.data == "DEVICE-START") {
                          _channel.sink.add("X:" + X + "Y: " + Y + "Z:" + Z);
                          return Text('Message received....');
                        }
                     else if (snapshot.data == "DEVICE-STOP") {
                           return Text('Message-Recieved Stopping');
                     }
                     return Text('recieving');
                },
            ),
           ElevatedButton(child:Icon(Icons.close, 
            size:30,
            ),
            onPressed: () {
                  _channel.sink.close();
            },
            )
           ]
         );
  }
  
  void sendData()
  {
    if(this.startToggle == true) {
      accelerometerEvents.listen((AccelerometerEvent event) {
        _channel.sink.add("X:" +  event.x.toString() + " Y:" + event.y.toString() + " Z:" +  event.z.toString());
      });
    }
  }
  void stopData() {
    if(this.startToggle == false) {
      _channel.sink.add("Stopped");
    }
  }
}