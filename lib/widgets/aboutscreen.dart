import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  AboutScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("About")),
        body: ListView(children: <Widget>[
          Container(
              color: Colors.lightBlue,
              child: ListTile(
                  leading: Icon(Icons.home),
                  title: Text('Stay Home'),
                  subtitle: Text(
                      'Remember to stay home to stop the spread and #FlattenTheCurve'))),
          ListTile(
              leading: Icon(Icons.person),
              title: Text('Created by'),
              subtitle: Text('William Barkoff'),
              onTap: () => _launchURL("https://willbarkoff.dev")),
          ListTile(
              leading: Icon(Icons.timeline),
              title: Text('Data from'),
              subtitle: Text('Johns Hopkins CSSE'),
              onTap: () => _launchURL("https://coronavirus.jhu.edu")),
          ListTile(
              leading: Icon(Icons.timeline),
              title: Text('Data from'),
              subtitle: Text('COVID-19 API'),
              onTap: () => _launchURL("https://covid19api.com/")),
          ListTile(
              leading: Icon(Icons.list),
              title: Text(
                  'Centers For Disease Control and Prevention (CDC) Resources'),
              subtitle: Text('cdc.gov'),
              onTap: () => _launchURL("https://cdc.gov/covid19")),
          ListTile(
              leading: Icon(Icons.gavel),
              title: Text('Federal Government COVID-19 Resources'),
              subtitle: Text('coronavirus.gov'),
              onTap: () => _launchURL("https://cornavirus.gov")),
          ListTile(
              leading: Icon(Icons.help_outline),
              title: Text('Symptom Checker'),
              subtitle: Text('From Apple'),
              onTap: () => _launchURL("https://www.apple.com/covid19")),
          ListTile(
              leading: Icon(Icons.developer_mode),
              title: Text('This app is open source.'),
              subtitle: Text('MIT Licensed'),
              onTap: () =>
                  _launchURL("https://github.com/willbarkoff/track_covid19")),
        ]));
  }
}

_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
