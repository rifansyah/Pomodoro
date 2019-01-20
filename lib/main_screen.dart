import 'package:flutter/material.dart';
import 'flare/flare_actor.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_duration_picker/flutter_duration_picker.dart';


class MainScreen extends StatelessWidget {
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
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        centerTitle: true,
        backgroundColor: Color(0xffFDF6EE),
        elevation: 0.0,
      ),
      backgroundColor: Color(0xffFDF6EE),
      body: MainScreenBody(),
    );
  }
}

class MainScreenBody extends StatefulWidget {
  @override
  _MainScreenBodyState createState() => _MainScreenBodyState();
}

class _MainScreenBodyState extends State<MainScreenBody> with TickerProviderStateMixin {
  AnimationController controller;

  AnimationController setAnimationController(Duration duration) {
    return controller = AnimationController(
          vsync: this,
          duration: duration,
          value: 1,
        )
        ..addListener((){
          this.setState((){
          });
        })
        ..addStatusListener((status){
          if (status == AnimationStatus.dismissed) {
            
          }
        });
  }

  String get timerString {
    Duration duration = controller.duration * controller.value;
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  String get buttonText {
    if (controller.isAnimating) {
      return "Pause";
    }
    return "Start";
  }

  IconData get buttonIcon {
    if (controller.isAnimating) {
      return FontAwesomeIcons.pause;
    }
    return FontAwesomeIcons.play;
  }  

  FlareActor get flareAnimation {
    if (controller.isAnimating) {
      return new FlareActor("assets/image_2.flr", alignment:Alignment.center, fit:BoxFit.contain, animation:"animation", isPaused: false,);
    }
    return new FlareActor("assets/image_2.flr", alignment:Alignment.center, fit:BoxFit.contain, animation: "animation",isPaused: true,);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = setAnimationController(Duration(minutes: 25));
  }

  void showDurationPickerDialog() async {
    Duration resultDuration = await showDurationPicker(
      context: context,
      initialTime: controller.duration,
    );
    if (resultDuration == null) {
      return;
    }
    setState(() {
          // _duration = resultDuration;
          controller = setAnimationController(resultDuration);
        });
  }
  
  void startCountingDown() {
    if(controller.isAnimating) {
      controller.stop();
    } else {
      controller.reverse(
      from: controller.value == 0.0
      ? 1.0
      : controller.value);
    }
    setState(() {
          
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          Container(
            child: Text(
              "Current Task :",
              style: TextStyle(
                fontSize: 14.0,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 8.0),
            child: Text(
              "Work",
              style: TextStyle(
                fontSize: 24.0,
                color: Color(0xff9AD14B),
              ),
            ),
          ),
          GestureDetector(
            onTap: showDurationPickerDialog,
            child: Container(
              child: AnimatedBuilder(
                animation: controller,
                builder: (BuildContext context, Widget child){
                  return new Text(
                    timerString,
                    style: TextStyle(
                      fontSize: 64.0,
                      color: Color(0xff9AD14B),
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: flareAnimation
            )
          ),
          Container(
            alignment: Alignment.center,
            child: RaisedButton(
              padding: EdgeInsets.fromLTRB(64.0, 16.0, 64.0, 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(buttonIcon),
                  Container(
                    margin: EdgeInsets.only(left: 8.0),
                    child: Text(buttonText),
                  )
                ],
              ),
              color: Color(0xff9AD14B),
              textColor: Colors.white,
              onPressed: startCountingDown,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            ),
          )
        ],
      ),
    );
  }
}
