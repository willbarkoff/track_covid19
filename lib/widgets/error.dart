import 'package:flutter/material.dart';

class ErrorDisplay extends StatelessWidget {
  final String error;

  ErrorDisplay(this.error, {Key key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.error_outline,
          color: Colors.red,
          size: 60,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Text(this.error),
        )
      ],
    ));
  }
}
