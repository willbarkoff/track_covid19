import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:track_covid19/util/loadhandler.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class TimelineScreen extends StatelessWidget {
  TimelineScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> country =
        ModalRoute.of(context).settings.arguments;

    return Scaffold(
        appBar: AppBar(title: Text("${country["Country"]}: Timeline")),
        body: FutureBuilder(
          future: http.get(
              "https://api.covid19api.com/dayone/country/" + country["Slug"]),
          builder:
              (BuildContext context, AsyncSnapshot<http.Response> snapshot) {
            if (snapshot.hasData) {
              List<Map> data = List<Map<String, dynamic>>.from(
                  jsonDecode(snapshot.data.body));

              final chartData = <charts.Series<Map<String, dynamic>, DateTime>>[
                charts.Series<Map<String, dynamic>, DateTime>(
                  id: 'deaths',
                  colorFn: (_, __) => charts.MaterialPalette.black,
                  measureFn: (Map<String, dynamic> datapoint, _) =>
                      datapoint["Deaths"],
                  domainFn: (Map<String, dynamic> datapoint, _) =>
                      DateTime.parse(datapoint["Date"]),
                  data: data,
                ),
                charts.Series<Map<String, dynamic>, DateTime>(
                  id: 'confirmed',
                  colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
                  measureFn: (Map<String, dynamic> datapoint, _) =>
                      datapoint["Confirmed"],
                  domainFn: (Map<String, dynamic> datapoint, _) =>
                      DateTime.parse(datapoint["Date"]),
                  data: data,
                ),
                charts.Series<Map<String, dynamic>, DateTime>(
                  id: 'recovered',
                  colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
                  measureFn: (Map<String, dynamic> datapoint, _) =>
                      datapoint["Recovered"],
                  domainFn: (Map<String, dynamic> datapoint, _) =>
                      DateTime.parse(datapoint["Date"]),
                  data: data,
                )
              ];
              return Padding(
                  padding: EdgeInsets.only(left: 10, right: 10, bottom: 32),
                  child: charts.TimeSeriesChart(chartData, animate: true));
            }

            return loadHandler(snapshot);
          },
        ));
  }
}
