import 'package:flutter/material.dart';

Widget loadHandler(AsyncSnapshot snapshot) {
  List<Widget> children;
  if (snapshot.hasError) {
    children = <Widget>[
      Icon(
        Icons.error_outline,
        color: Colors.red,
        size: 60,
      ),
      Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Text('Error: ${snapshot.error}'),
      )
    ];
  } else {
    children = <Widget>[
      SizedBox(
        child: CircularProgressIndicator(),
        width: 60,
        height: 60,
      ),
      const Padding(
        padding: EdgeInsets.only(top: 16),
        child: Text('Loading...'),
      )
    ];
  }
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    ),
  );
}
