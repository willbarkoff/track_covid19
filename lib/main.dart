import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:track_covid19/util/loadhandler.dart';
import 'package:track_covid19/widgets/countrypicker.dart';
import 'package:track_covid19/widgets/countryscreen.dart';
import 'package:track_covid19/widgets/timelinescreen.dart';

import 'widgets/header.dart';
import 'widgets/aboutscreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.red),
      darkTheme: ThemeData.dark(),
      home: HomePage(title: 'Track COVID-19'),
      routes: <String, WidgetBuilder>{
        "/about": (BuildContext context) => AboutScreen(),
        "/country": (BuildContext context) => CountryScreen(),
        "/timeline": (BuildContext context) => TimelineScreen()
      },
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.info_outline),
              onPressed: () {
                Navigator.of(context).pushNamed("/about");
              },
            ),
          ],
        ),
        body: FutureBuilder(
            future: http.get("https://api.covid19api.com/world/total"),
            builder:
                (BuildContext context, AsyncSnapshot<http.Response> snapshot) {
              List<Widget> children;

              if (snapshot.hasData) {
                Map<String, dynamic> data = jsonDecode(snapshot.data.body);
                children = <Widget>[
                  TopBanner(
                    count: data["TotalConfirmed"],
                    accent: Colors.red,
                    description: "Confirmed Cases",
                  ),
                  Row(children: <Widget>[
                    Expanded(
                        child: TopBanner(
                      count: data["TotalRecovered"],
                      accent: Colors.green,
                      description: "Recovered",
                    )),
                    Expanded(
                        child: TopBanner(
                      count: data["TotalDeaths"],
                      accent: Colors.black45,
                      description: "Deceased",
                    ))
                  ]),
                  CountryPicker()
                ];

                return Center(
                  child: Column(
                    children: children,
                  ),
                );
              }
              return loadHandler(snapshot);
            }));
  }
}
