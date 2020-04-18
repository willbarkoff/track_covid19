import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:track_covid19/util/countrycodetoemoji.dart';
import 'package:track_covid19/util/loadhandler.dart';

class CountryPicker extends StatelessWidget {
  CountryPicker({Key key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: http.get("https://api.covid19api.com/countries"),
        builder: (BuildContext context, AsyncSnapshot<http.Response> snapshot) {
          if (snapshot.hasData) {
            List<dynamic> data = jsonDecode(snapshot.data.body);
            data.sort((a, b) => a["Country"].compareTo(b["Country"]));
            List<Widget> listItems = data.map((country) {
              return ListTile(
                leading: Text(
                  countryCodeToEmoji(
                    country["ISO2"],
                  ),
                  style: Theme.of(context)
                      .textTheme
                      .display1
                      .copyWith(color: Colors.black),
                ),
                title: Text(
                  country["Country"],
                ),
                onTap: () => Navigator.of(context)
                    .pushNamed("/country", arguments: country),
              );
            }).toList();

            return Expanded(
                child: ListView(
              children: listItems,
              shrinkWrap: true,
            ));
          }

          return loadHandler(snapshot);
        });
  }
}
