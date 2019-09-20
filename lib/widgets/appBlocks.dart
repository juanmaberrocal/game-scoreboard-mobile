// flutter
import 'package:flutter/material.dart';
// dependencies
// app

class AppScaffold extends StatelessWidget {
  AppScaffold({
    Key key,
    this.top,
    this.center,
    this.bottom,
  }) : super(key: key);

  final Widget top;
  final Widget center;
  final Widget bottom;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: top,
      bottomNavigationBar: bottom,
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: center,
      ),
    );
  }
}

class AppEditBar extends StatelessWidget {
  AppEditBar({
    Key key,
    @required this.record,
    this.avatarCallback,
    this.editCallback,
    this.deleteCallback,
  }) : super(key: key);

  final Object record;
  final Function avatarCallback;
  final Function editCallback;
  final Function deleteCallback;

  void callbackButton(int index) {
    List<Function> callbacks = [];

    if (avatarCallback != null) callbacks.add(avatarCallback);
    if (editCallback != null) callbacks.add(editCallback);
    if (deleteCallback != null) callbacks.add(deleteCallback);

    callbacks[index](record);
  }

  List<BottomNavigationBarItem> buildButtons() {
    List<BottomNavigationBarItem> buttons = [];

    if (avatarCallback != null) {
      buttons.add(BottomNavigationBarItem(
        icon: Icon(Icons.camera_alt),
        title: Text('Avatar'),
      ));
    }

    if (editCallback != null) {
      buttons.add(BottomNavigationBarItem(
        icon: Icon(Icons.edit),
        title: Text('Edit'),
      ));
    }

    if (deleteCallback != null) {
      buttons.add(BottomNavigationBarItem(
        icon: Icon(Icons.delete),
        title: Text('Delete'),
      ));
    }

    return buttons;
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (int index) {
        callbackButton(index);
      },
      items: buildButtons(),
      fixedColor: Theme.of(context).textTheme.caption.color,
    );
  }
}