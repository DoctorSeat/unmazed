import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SupPage extends StatefulWidget {
  @override
  _SupPageState createState() => _SupPageState();
}

List itemData = [
  [
    "What if I get stuck?",
    "Press the 'Alt Route button on the bottom right of your screen.",
    false,
  ],
  [
    "How do I know where to go?",
    "Use the Arrows on your screen to orient yourself in the train station",
    false,
  ],
  ["Frage 3", "Antwort 3", false],
  ["Frage 4", "Antwort 4", false],
  ["Frage 5", "Antwort 5", false],
];

class _SupPageState extends State<SupPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text("FAQ"),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(100),
        child: ListView.builder(
          itemCount: itemData.length,
          itemBuilder: (BuildContext context, int index) {
            return ExpansionPanelList(
              animationDuration: Duration(milliseconds: 500),
              dividerColor: Colors.blue,
              elevation: 1,
              children: [
                ExpansionPanel(
                  canTapOnHeader: true,
                  body: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          itemData[index][1],
                          style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 15,
                              letterSpacing: 0.3,
                              height: 1.3),
                        ),
                      ],
                    ),
                  ),
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        itemData[index][0],
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    );
                  },
                  isExpanded: itemData[index][2],
                )
              ],
              expansionCallback: (int item, bool status) {
                setState(() {
                  itemData[index][2] = !itemData[index][2];
                });
              },
            );
          },
        ),
      ),
    );
  }
}
