import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:pathfinder/main.dart';

class Arrival extends StatefulWidget {
  const Arrival({Key key}) : super(key: key);
  @override
  _ArrivalState createState() => _ArrivalState();
}

class _ArrivalState extends State<Arrival> {
  ConfettiController _controllerCenterRight;
  ConfettiController _controllerCenterLeft;
  @override
  void initState() {
    //  implement initState

    _controllerCenterRight =
        ConfettiController(duration: const Duration(milliseconds: 1000));
    _controllerCenterLeft =
        ConfettiController(duration: const Duration(milliseconds: 1000));
    _controllerCenterLeft.play();
    _controllerCenterRight.play();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Builder(builder: (context) {
        return _buildArrival();
      }),
    );
  }

  Widget _buildArrival() {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Container(
        child: Stack(children: <Widget>[
          Align(
              child: Text(
            "Sie haben ihr Ziel Erreicht!",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 44),
            
          )),
          Padding(
              padding: EdgeInsets.all(16.0),
              child: Align(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                      backgroundColor: Colors.blueAccent,
                      child: const Icon(Icons.house),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MyHome()),
                      );
                      }))),
          Align(
            alignment: Alignment.centerRight,
            child: ConfettiWidget(
              confettiController: _controllerCenterRight,
              blastDirection: 5 * math.pi / 4,
              emissionFrequency: 0.1,
              numberOfParticles: 10,
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: ConfettiWidget(
              confettiController: _controllerCenterLeft,
              blastDirection: 7 * math.pi / 4,
              emissionFrequency: 0.1,
              numberOfParticles: 10,
            ))])));}}
