import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TopBanner extends StatelessWidget {
  final num count;
  final Color accent;
  final String description;

  TopBanner({Key key, this.count, this.accent, this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8.0),
        color: accent,
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Text(
              NumberFormat.compact().format(count),
              style: Theme.of(context).textTheme.display3,
            ),
            Text(description, style: Theme.of(context).textTheme.body1)
          ],
        ));
  }
}
