import 'package:video_player/video_player.dart';
import 'video_player_widget.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'supPage.dart';
import 'main.dart';
import 'arrival.dart';
import 'package:flutter/material.dart';

class Scrub extends StatefulWidget {
  const Scrub({
    Key key,
  }) : super(key: key);
  @override
  _ScrubState createState() => _ScrubState();
}

class _ScrubState extends State<Scrub> {
  double value = 1;
  VideoPlayerController _controller;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/videos/route$index.mp4')
      ..addListener(() {
        setState(() {});
      })
      ..setLooping(false)
      ..initialize().then((_) => _controller.pause());
  }

  @override
  Widget build(BuildContext context) {
    final double min = 0.5;
    final double max = 5;
    double value = 1;
    bool token = false;
    return new Scaffold(
        body: Stack(
          children: [
            VideoPlayerWidget(controller: _controller),
            Container(
                width: double.infinity,
                height: double.infinity,
                child: GestureDetector(onTapDown: (_) async {
                  token = true;
                  if (this.value > 0) {
                    if (_controller.value.position ==
                        _controller.value.duration) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Arrival()),
                      );
                      _controller.pause();
                    } else {
                      _controller.play();
                    }
                  } else {}
                }, onTapUp: (_) {
                  token = false;
                  _controller.pause();
                })),
            SliderTheme(
              data: SliderThemeData(
                trackHeight: 20,
                thumbColor: Colors.pink,
                thumbShape: SliderComponentShape.noOverlay,
                overlayShape: SliderComponentShape.noOverlay,
                valueIndicatorShape: SliderComponentShape.noOverlay,
                activeTrackColor: Colors.purple,
                inactiveTrackColor: Colors.purple.shade100,
              ),
              child: Positioned(
                  top: MediaQuery.of(context).size.height / 2.5,
                  right: 20.0,
                  child: Stack(children: [
                    RotatedBox(
                        quarterTurns: 3,
                        child: Row(
                          children: [
                            buildSideLabel(min),
                            SizedBox(
                              width: 250,
                              child: Slider(
                                min: min,
                                max: max,
                                value: this.value,
                                onChanged: (value) => setState(() => {
                                      this.value = value,
                                      print(this.value),
                                      _controller
                                          .setPlaybackSpeed(this.value / 2),
                                    }),
                              ),
                            ),
                            buildSideLabel(max),
                          ],
                        )),
                  ])),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
            padding: EdgeInsets.all(16),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                    backgroundColor: Colors.purple,
                    child: const Icon(Icons.replay),
                    onPressed: rewind1Seconds,
                  ),
                ),
                // Align(
                //   alignment: Alignment.bottomLeft,
                //   child: buildSpeedDial(),
                // ),
              ],
            )));
  }

  Widget buildSideLabel(double value) => RotatedBox(
        quarterTurns: 1,
        child: Container(
            width: 50,
            child: Text(value.toString() + "x",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white))),
      );
  Future goToPosition(
    Duration Function(Duration currentPosition) builder,
  ) async {
    final currentPosition = await _controller.position;
    final newPosition = builder(currentPosition);
    await _controller.seekTo(newPosition);
  }

  Future<void> rewind1Seconds() async => goToPosition(
      (currentPosition) => currentPosition - Duration(milliseconds: 1000));

  Widget buildSpeedDial() => SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22.0),

        /// This is ignored if animatedIcon is non null
        icon: Icons.add,
        activeIcon: Icons.remove,
        iconTheme: IconThemeData(color: Colors.blue[500], size: 30),
        visible: true,
        closeManually: false,
        renderOverlay: true,
        curve: Curves.bounceIn,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        tooltip: 'Menu',
        backgroundColor: Colors.blue[500],
        foregroundColor: Colors.black,
        elevation: 8.0,
        shape: CircleBorder(),
        children: [
          SpeedDialChild(
            child: Icon(Icons.flag),
            backgroundColor: Colors.greenAccent,
            label: 'Hilfe',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SupPage()),
              );
            },
            labelStyle: TextStyle(fontSize: 18.0),
          ),
          SpeedDialChild(
            child: Icon(Icons.home),
            backgroundColor: gray,
            label: 'Home',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyHome()),
              );
            },
            labelStyle: TextStyle(fontSize: 18.0),
          ),
        ],
      );
}
