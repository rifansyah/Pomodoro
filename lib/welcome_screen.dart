import 'package:flutter/material.dart';
import 'flare/flare_actor.dart';

import 'package:pomodoro/main_screen.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text(
          "Pomodoro",
          style: TextStyle(
            color: Colors.black
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xffFDF6EE),
        elevation: 0.0,
      ),
      backgroundColor: Color(0xffFDF6EE),
      body: WelcomeScreenBody(),
    );
  }
}

class WelcomeScreenBody extends StatefulWidget {
  @override
  _WelcomeScreenBodyState createState() => _WelcomeScreenBodyState();
}

class _WelcomeScreenBodyState extends State<WelcomeScreenBody> {
  void nextScreen() {
    Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => MainScreen())
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(
              "Ready to learn something new?",
              style: TextStyle(
                fontSize: 24.0,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 8.0),
            child: Text(
              "Once you stop learning, you start dying",
              style: TextStyle(
                fontSize: 14.0,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 4.0),
            child: Text(
              "- Einstein",
              style: TextStyle(
                fontSize: 14.0
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: new FlareActor("assets/image.flr", alignment:Alignment.center, fit:BoxFit.contain, animation:"Sun"),
            )
          ),
          Container(
            alignment: Alignment.center,
            child: RaisedButton(
              padding: EdgeInsets.fromLTRB(64.0, 16.0, 64.0, 16.0),
              child: Text("Start"),
              color: Color(0xff9AD14B),
              textColor: Colors.white,
              onPressed: nextScreen,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            ),
          )
        ],
      )
    );
  }
}
