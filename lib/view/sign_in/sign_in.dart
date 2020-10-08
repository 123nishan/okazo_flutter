import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin {
  AnimationController patrickController, patrickPasswordController;
  Animation<double> patrickAnimation, patrickPasswordAnimation;
  double angle = 0.0;
  int emailTextLenght = 0;
  bool obscureText = false;
  bool passwordSelected = false;
  var passwordImage = 'images/patrick_partial.png';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    patrickController =
        new AnimationController(vsync: this, duration: (Duration(seconds: 2)));
    patrickPasswordController =
        new AnimationController(vsync: this, duration: (Duration(seconds: 3)));
    patrickAnimation =
        CurvedAnimation(parent: patrickController, curve: Curves.linear);
    patrickPasswordAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(patrickPasswordController);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      
      backgroundColor: Colors.pinkAccent,
      body: SingleChildScrollView(
        child: Container(
            height: size.height,
            width: size.width,
            decoration: BoxDecoration(),
            child: Column(
              children: [
                if (!passwordSelected) ...[
                  Expanded(
                    child: RotationTransition(
                        turns: AlwaysStoppedAnimation(angle / 360),
                        child: Image.asset('images/patrick_face.png')),
                  ),
                ],
                if (passwordSelected) ...[
                  Expanded(
                    child: FadeTransition(
                        opacity: patrickPasswordAnimation,
                        child: Image.asset(passwordImage)),
                  ),
                ],
                Expanded(
                  flex: 2,
                    child: Column(
                  children: [
                    Center(
                      child: Container(
                        width: size.width * 0.60,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(size.width * 0.02, size.width * 0.04, size.width * 0.02, size.width * 0.04),
                          child: TextFormField(
                            onTap: () {
                              setState(() {
                                passwordSelected = false;
                              });
                            },
                            cursorColor: Colors.white,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                labelStyle: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.yellow),
                                ),
                                labelText: "Email address"),
                            onChanged: (val) {
                              if (val.length > emailTextLenght) {
                                emailTextLenght += 1;
                                angle -= 0.8;
                              } else {
                                emailTextLenght -= 1;
                                angle += 0.8;
                              }
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        width: size.width * 0.60,
                        child: Padding(
                          padding: EdgeInsets.all(size.width * 0.01),
                          child: TextFormField(
                            cursorColor: Colors.white,
                            style: TextStyle(color: Colors.white),
                            obscureText: obscureText,
                            onTap: () {
                              setState(() {
                                passwordSelected = true;
                              });
                            },
                            decoration: InputDecoration(
                                suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        patrickPasswordController.forward();
                                        if (obscureText) {
                                          passwordImage =
                                              'images/patrick_partial.png';
                                        } else {
                                          passwordImage =
                                              'images/patrick_closed.png';
                                        }
                                        obscureText = !obscureText;
                                      });
                                    },
                                    child: (obscureText)
                                        ? Icon(
                                            FontAwesome5.eye,
                                            color: Colors.white,
                                          )
                                        : Icon(
                                            FontAwesome5.eye_slash,
                                            color: Colors.white,
                                          )),
                                labelStyle: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.yellow),
                                ),
                                labelText: "Password"),
                            onChanged: (val) {
                              if (val.length > emailTextLenght) {
                                emailTextLenght += 1;
                                angle -= 0.8;
                              } else {
                                emailTextLenght -= 1;
                                angle += 0.8;
                              }
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ))
              ],
            )),
      ),
    );
  }
}
