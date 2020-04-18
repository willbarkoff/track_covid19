import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:track_covid19/util/loadhandler.dart';

import 'error.dart';
import 'header.dart';

class CountryScreen extends StatelessWidget {
  CountryScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> country =
        ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: AppBar(title: Text(country["Country"])),
        body: FutureBuilder(
            future: http.get(
                "https://api.covid19api.com/total/country/" + country["Slug"]),
            builder:
                (BuildContext context, AsyncSnapshot<http.Response> snapshot) {
              if (snapshot.hasData) {
                List<dynamic> data = jsonDecode(snapshot.data.body);
                if (data.length == 0) {
                  return ErrorDisplay("No data");
                }
                Map<String, dynamic> latestData = data[data.length - 1];
                return Center(
                    child: Column(
                  children: <Widget>[
                    TopBanner(
                      count: latestData["Confirmed"],
                      accent: Colors.red,
                      description: "Confirmed Cases",
                    ),
                    Row(children: <Widget>[
                      Expanded(
                          child: TopBanner(
                        count: latestData["Recovered"],
                        accent: Colors.green,
                        description: "Recovered",
                      )),
                      Expanded(
                          child: TopBanner(
                        count: latestData["Deaths"],
                        accent: Colors.black45,
                        description: "Deceased",
                      ))
                    ]),
                  ],
                ));
              }
              return loadHandler(snapshot);
            }));
  }
}
