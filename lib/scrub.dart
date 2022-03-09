import 'package:video_player/video_player.dart';
import 'video_player_widget.dart';

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
    _controller = VideoPlayerController.asset('assets/videos/snippet1.mp4')
      ..addListener(() {
        setState(() {});
      })
      ..setLooping(true)
      ..initialize().then((_) => _controller.pause());
  }

  @override
  Widget build(BuildContext context) {
    final double min = 0.5;
    final double max = 2;
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
                  _controller.play();
                } else {
                  }
              }, 
              onTapUp: (_) {
                token = false;
                _controller.pause();
              })),
          SliderTheme(
            data: SliderThemeData(
              thumbColor: Colors.pink,
              activeTrackColor: Colors.purple,
              inactiveTrackColor: Colors.purple.shade100,
            ),
            child: Positioned(
                top: MediaQuery.of(context).size.height / 2.5,
                right: 20.0,
                child: RotatedBox(
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
                                  _controller.setPlaybackSpeed(this.value),
                                }),
                          ),
                        ),
                        buildSideLabel(max),
                      ],
                    ))),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        child: const Icon(Icons.replay),
        onPressed: rewind1Seconds,
      ),
      // body: Builder(builder: (context) {
      //   return VideoPlayerWidget(controller: _controller);
      // }),
    );
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
}
