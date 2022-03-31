import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import '../lib/supPage.dart';
import '../lib/main.dart';
import '../lib/arrival.dart';



class Carousel extends StatefulWidget {
  const Carousel({
    Key key,
  }) : super(key: key);
  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  //bool _hasPermissions = false;
  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();
    //_checkPermission();
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      body: Builder(builder: (context) {
        //if (_hasPermissions) {
        return _buildCarousel();
        //} else {
        //  return _buildPermissionSheet();
        //}
      }),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22.0),

        /// This is ignored if animatedIcon is non null
        icon: Icons.add,
        activeIcon: Icons.remove,
        iconTheme: IconThemeData(color: Colors.blue[500], size: 30),
        visible: true,

        /// If true user is forced to close dial manually
        /// by tapping main button and overlay is not rendered.
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
            backgroundColor: Colors.grey,
            label: 'Home',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyHome()),
              );
            },
            labelStyle: TextStyle(fontSize: 18.0),
          ),
          // SpeedDialChild(
          //   child: Icon(Icons.alt_route),
          //   backgroundColor: Colors.red,
          //   label: 'Alt. Route',
          //   onTap: () {
          //     start = 21;
          //     ende = 17;
          //     route(start, ende);
          //     print('$start $ende');
          //     chooseimages();
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => Carousel()),
          //     );
          //   },
          //   labelStyle: TextStyle(fontSize: 18.0),
          // ),
        ],
      ),
    );
  }

/*
  Widget _buildCompass() {
    return StreamBuilder<CompassEvent>(
      stream: FlutterCompass.events,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error reading heading: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        double direction = snapshot.data.heading;

        // if direction is null, then device does not support this sensor
        // show error message
        if (direction == null)
          return Center(
            child: Text("Device does not have sensors !"),
          );

        return Material(
          shape: CircleBorder(),
          clipBehavior: Clip.antiAlias,
          elevation: 4.0,
          child: Container(
            padding: EdgeInsets.all(16.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Transform.rotate(
              angle: (direction * (math.pi / 180) * -1),
              child: Image.asset('assets/compass.jpg'),
            ),
          ),
        );
      },
    );
  }

  Future<void> _checkPermission() async {
    final serviceStatus = await Permission.sensors;
    final isSensor = serviceStatus == ServiceStatus.enabled;
    if (!isSensor) {
      print('Turn on sensors before requesting permission.');
      _hasPermissions = false;
      return;
    }

    final status = await Permission.sensors.request();
    if (status == PermissionStatus.granted) {
      _hasPermissions = true;
      print('Permission granted');
    } else if (status == PermissionStatus.denied) {
      print(
          'Permission denied. Show a dialog and again ask for the permission');
      _hasPermissions = false;
    } else if (status == PermissionStatus.permanentlyDenied) {
      print('Take the user to the settings page.');
      await openAppSettings();
    }
  }

  Widget _buildPermissionSheet() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('Location Permission Required'),
          ElevatedButton(
            child: Text('Request Permissions'),
            onPressed: () {
              Permission.locationWhenInUse.request().then((ignored) {
                _checkPermission();
              });
            },
          ),
          SizedBox(height: 16),
          ElevatedButton(
            child: Text('Open App Settings'),
            onPressed: () {
              openAppSettings().then((opened) {
                //
              });
            },
          )
        ],
      ),
    );
  }
*/
  Widget _buildCarousel() {
    @override
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Stack(children: [
      Container(
        width: double.infinity,
        height: double.infinity,
        child: GestureDetector(
            onTap: () {
              setState(
                () {
                  if (_currentIndex + 1 == imgList.length) {
                    _currentIndex = 0;
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Arrival()),
                    );
                  } else {
                    _currentIndex += 1;
                  }
                },
              );
            },
            onDoubleTap: () {
              setState(() {
                if (_currentIndex - 1 >= 0) {
                  _currentIndex -= 1;
                  if ((_currentIndex - 1) % 7 == 0) {
                  }
                } else {
                  _currentIndex = 0;
                }
              });
            },
            child: AnimatedSwitcher(
                duration: Duration(milliseconds: 1000),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(child: child, opacity: animation);
                },
                child: Image.asset(
                  imgList[_currentIndex],
                  key: ValueKey<int>(_currentIndex),
                  fit: BoxFit.cover,
                  height: height,
                  width: MediaQuery.of(context).size.width,
                ))),
      ),
      // Align(
      //   alignment: Alignment.bottomLeft,
      //   child: Image.asset(
      //     'assets/images/compass.png',
      //     width: 100,
      //   ),
      // ),
      // Align(
      //     alignment: Alignment.centerLeft,
      //     child: Image.asset('assets/images/Anzeigetafel$_tafelIndex.png'))
    ]));
  }
}
