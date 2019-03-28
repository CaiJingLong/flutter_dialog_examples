import 'package:flutter/material.dart';

class GeneralDialogPage extends StatefulWidget {
  @override
  _GeneralDialogPageState createState() => _GeneralDialogPageState();
}

class _GeneralDialogPageState extends State<GeneralDialogPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("showGeneralDialog的使用"),
      ),
      body: ListView(
        children: <Widget>[
          buildButton("透明背景", showTransBackgroundDialog),
          buildButton(
            "带颜色背景",
            () => showOtherBackgroundDialog(Colors.black.withOpacity(0.8)),
          ),
        ],
      ),
    );
  }

  showTransBackgroundDialog() {
    showGeneralDialog(
      context: context,
      barrierLabel: "你好",
      barrierDismissible: true,
      transitionDuration: Duration(milliseconds: 300),
      barrierColor: Colors.black.withOpacity(0.5),
      pageBuilder: (BuildContext context, Animation animation,
          Animation secondaryAnimation) {
        return Center(
          child: Material(
            child: Container(
              color: Colors.black.withOpacity(animation.value),
              child: Text("我是一个可变的"),
            ),
          ),
        );
      },
    );
  }

  showOtherBackgroundDialog(Color color) {
    showGeneralDialog(
      context: context,
      barrierLabel: "你好",
      barrierDismissible: true,
      transitionDuration: Duration(milliseconds: 1000),
      barrierColor: color,
      pageBuilder: (BuildContext context, Animation animation,
          Animation secondaryAnimation) {
        return Center(
          child: Material(
            child: Container(
              color: Colors.black.withOpacity(animation.value),
              child: Text("我是一个可变的"),
            ),
          ),
        );
      },
    );
  }
}

Widget buildButton(
  String text,
  Function onPressed, {
  Color color = Colors.white,
}) {
  return FlatButton(
    color: color,
    child: Text(text),
    onPressed: onPressed,
  );
}
