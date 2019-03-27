import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class InputDialog extends StatefulWidget {
  @override
  _InputDialogState createState() => _InputDialogState();
}

class _InputDialogState extends State<InputDialog> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    if (this.mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQueryData.fromWindow(ui.window);
    return AnimatedContainer(
      color: Colors.transparent,
      duration: const Duration(milliseconds: 300),
      padding: EdgeInsets.only(bottom: mediaQueryData.viewInsets.bottom),
      child: Material(child: TextField()),
      alignment: Alignment.center,
    );
  }
}
