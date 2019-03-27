import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'input_dialog.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("dialog"),
      ),
      body: ListView(
        children: <Widget>[
          buildButton("显示一个固定的dialog", _showDialog),
          buildButton("显示一个包含状态的dialog", _showDialogWithStatefulWidget),
          buildButton("显示一个简易状态dialog", _showDialogWithStatefulBuilder),
          buildButton("显示一个iOS风格的dialog", showCupertinoDialog),
          buildButton("显示一个有输入框的dialog", showHasInputDialog),
        ],
      ),
    );
  }

  _showDialog() async {
    var result = await showDialog(
      context: context,
      builder: (ctx) {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              buildButton("返回1", () => Navigator.of(context).pop(1)),
              buildButton("返回2", () => Navigator.pop(context, 2)),
            ],
          ),
        );
      },
    );

    print("result = $result");
  }

  _showDialogWithStatefulWidget() {
    showDialog(context: context, builder: (ctx) => CounterWidget());
  }

  _showDialogWithStatefulBuilder() {
    var progress = 0.0;
    StateSetter ss;
    Timer.periodic(Duration(milliseconds: 300), (timer) {
      progress += 0.1;
      if (ss != null) {
        ss(() {});
      }
      if (progress >= 1) {
        timer.cancel();
        ss = null;
      }
    });
    var sb = StatefulBuilder(
      builder: (ctx, state) {
        ss = state;
        return Center(
          child: Container(
            height: 40,
            child: LinearProgressIndicator(
              backgroundColor: Colors.white,
              value: progress,
            ),
          ),
        );
      },
    );
    showDialog(context: context, builder: (ctx) => sb);
  }

  void showCupertinoDialog() {
    var dialog = CupertinoAlertDialog(
      content: Text(
        "你好,我是你苹果爸爸的界面",
        style: TextStyle(fontSize: 20),
      ),
      actions: <Widget>[
        CupertinoButton(
          child: Text("取消"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        CupertinoButton(
          child: Text("确定"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );

    showDialog(context: context, builder: (_) => dialog);
  }

  showHasInputDialog() {
    showDialog(context: context, builder: (_) => InputDialog());
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

class CounterWidget extends StatefulWidget {
  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  var _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Material(
            child: Container(
              width: 100,
              height: 100,
              child: Text(
                _counter.toString(),
                style: TextStyle(fontSize: 40),
              ),
              alignment: Alignment.center,
            ),
            color: Colors.white,
          ),
          buildButton("+1", () => setState(() => _counter++)),
          buildButton("-1", () => setState(() => _counter--)),
        ],
      ),
    );
  }
}
