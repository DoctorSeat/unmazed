import 'package:flutter/material.dart';
import 'package:unmazed/scrub.dart';

Map<String, int> startbiblio = <String, int>{
  'I': 0,
};
Map<String, int> endbiblio = <String, int>{
  'A': 1,
  'B': 2,
  'C': 3,
};
int start = 0;
int ende = 0;
int index;
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
const MaterialColor pastelOrange = const MaterialColor(
  0xFFFFD18C,
  const <int, Color>{
    50: const Color(0xFFFFD18C),
    100: const Color(0xFFFFD18C),
    200: const Color(0xFFFFD18C),
    300: const Color(0xFFFFD18C),
    400: const Color(0xFFFFD18C),
    500: const Color(0xFFFFD18C),
    600: const Color(0xFFFFD18C),
    700: const Color(0xFFFFD18C),
    800: const Color(0xFFFFD18C),
    900: const Color(0xFFFFD18C),
  },
);

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'unmazed',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: pastelOrange,
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
        height: 30,
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
  // route(start, ende);
  index = start + ende;
  chooseImages();
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
}

void searchend(var searchparam) {
  ende = 0;
  endbiblio.forEach((k, v) {
    if (searchparam == k) {
      print("endpunkt : $v");
      ende = v;
    }
  });
}

// void route(var a, var b) {
//   if (a != 0 && b != 0) {
//     for (var i = 0; i < list.length; i++) {
//       if (a == list[i].first && b == list[i].last) {
//         print(list[i]);
//         mapList = list[i];
//       }
//     }
//   } else {
//     print("kein start/endpunkt");
//   }
// }

void chooseImages() {
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
    content: Text("Start- und Endpunkt k??nnen nicht gleich sein."),
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
