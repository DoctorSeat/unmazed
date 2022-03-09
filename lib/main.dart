import 'package:flutter/material.dart';
import 'package:unmazed/scrub.dart';
import 'carousel.dart';

Map<String, int> startbiblio = <String, int>{
  'McDonalds': 1, 'Gleis 16': 111, 'U5': 211
};
Map<String, int> endbiblio = <String, int>{
  'Exit A': 13, 'McDonalds': 134, 'Gleis 6': 228
};
int start = 0;
int ende = 0;
List list = [
  [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13],
  [111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134],
  [211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228]
];
List mapList = [];
List imgList = [];
void main() {
  runApp(MyApp());
}

const MaterialColor kPrimaryColor = const MaterialColor(
  0xFF0E7AC7,
  const <int, Color>{
    50: const Color(0xFF0E7AC7),
    100: const Color(0xFF0E7AC7),
    200: const Color(0xFF0E7AC7),
    300: const Color(0xFF0E7AC7),
    400: const Color(0xFF0E7AC7),
    500: const Color(0xFF0E7AC7),
    600: const Color(0xFF0E7AC7),
    700: const Color(0xFF0E7AC7),
    800: const Color(0xFF0E7AC7),
    900: const Color(0xFF0E7AC7),
  },
);

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'unMAZED',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.grey,
        ),
        home: MyHome());
  }
}

class MyHome extends StatelessWidget {
  final myController = TextEditingController();
  final endController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Image.asset(
        'assets/images/logo.png',
        fit: BoxFit.contain,
        height: 50,
      )),
      body: ListView(
        children: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 50),
              child: TextField(
                  controller: myController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Startpunkt eingeben',
                    suffixIcon: IconButton(
                      onPressed: () => myController.clear(),
                      icon: Icon(Icons.clear),
                    ),
                  ))),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 50),
              child: TextField(
                  controller: endController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Endpunkt eingeben',
                    suffixIcon: IconButton(
                      onPressed: () => endController.clear(),
                      icon: Icon(Icons.clear),
                    ),
                  ))),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 50),
              child: FloatingActionButton(
                onPressed: () {
                  if (myController.text != endController.text) {
                    print("1");
                    if (makeRoute(myController.text, endController.text)) {
                      print("2");
                      print(mapList);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Scrub()),
                      );
                    } else {
                      showAlertDialog(context);
                    }
                    myController.clear();
                    endController.clear();
                    print(mapList);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Scrub()),
                    );
                  } else {
                    showAlertDialog(context);
                  }
                },
                child: const Icon(Icons.navigation),
                backgroundColor: Colors.green,
              )),
        ],
      ),
    );
  }
}

bool makeRoute(var startText, var endText) {
  searchstart(startText);
  searchend(endText);
  route(start, ende);
  chooseimages();
  print(imgList);
  return imgList.length > 0;
}

void searchstart(var searchparam) {
  start = 0;
  startbiblio.forEach((k, v) {
    if (searchparam == k) {
      print("startpunkt : $v");
      start = v;
    }
  });
  if (start == 0) {
    print("startpunkt nicht gefunden");
  }
}

void searchend(var searchparam) {
  ende = 0;
  endbiblio.forEach((k, v) {
    if (searchparam == k) {
      print("endpunkt : $v");
      ende = v;
    }
  });

  if (ende == 0) {
    print("endpunkt nicht gefunden");
  }
}

void route(var a, var b) {
  if (a != 0 && b != 0) {
    for (var i = 0; i < list.length; i++) {
      if (a == list[i].first && b == list[i].last) {
        print(list[i]);
        mapList = list[i];
      }
    }
  } else {
    print("kein start/endpunkt");
  }
}

void chooseimages() {
  imgList.clear();
  for (var i = 0; i < mapList.length; i++) {
    var j = mapList[i];
    imgList.add('assets/images/$j.png');
  }
}

showAlertDialog(BuildContext context) {
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyHome()),
      );
    },
  );
  AlertDialog alert = AlertDialog(
    title: Text("Fehler"),
    content: Text("Start- und Endpunkt können nicht gleich sein."),
    actions: [
      okButton,
    ],
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

List giveList() {
  return imgList;
}
