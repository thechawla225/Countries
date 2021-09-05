import 'package:flutter/material.dart';
import 'Countries.dart';
import 'package:countries/DataBase.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:countries/CountriesModel.dart';
import 'package:countries/Widgets/ExitDialog.dart';
import 'package:countries/Widgets/HomeDrawer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var data;
  var decodedData;
  var regions = [
    "Asia",
    "Europe",
    "Africa",
    "Oceania",
    "Americas",
    "Polar",
  ];
  Future callApi() async {
    http.Response response =
        await http.get(Uri.parse('https://restcountries.eu/rest/v2/all'));
    data = response.body;
    decodedData = jsonDecode(data);

    for (int i = 0; i < 250; i++) {
      var temp = decodedData[i];
      Country country = Country(
          name: temp['name'],
          region: temp['region'],
          languages: temp['languages'].toString(),
          borders: temp['borders'].toString(),
          alpha3Code: temp['alpha3Code'],
          flag: temp['flag']);
      await Countries.instance.createCountry(country);
    }
    return;
  }

  @override
  void initState() {
    callApi();
    super.initState();
  }

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return exitDialog(context);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: false,
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.red,
          ),
          title: Text(
            "Regions",
            style: TextStyle(
                fontFamily: 'ProximaNova',
                fontSize: 17,
                fontWeight: FontWeight.w800,
                color: Colors.red),
          ),
        ),
        backgroundColor: Colors.white,
        drawer: homeDrawer(context),
        body: showRegions(regions),
      ),
    );
  }
}

Widget showRegions(regions) {
  if (regions.isEmpty) {
    return Center(
      child: Text(
        'Fetching Regions...',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w800,
          fontFamily: 'ProximaNova',
        ),
      ),
    );
  } else {
    return Column(
      children: [
        SizedBox(height: 24),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.all(8),
            itemCount: regions.length,
            itemBuilder: (BuildContext context, int index) {
              final transaction = regions[index];

              return showCard(context, transaction);
            },
          ),
        ),
      ],
    );
  }
}

Widget showCard(BuildContext context, String region) {
  return Card(
    color: Colors.white,
    child: ListTile(
      onTap: () {
        print("Region pressed");
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => CountriesView(region)));
      },
      title: Text(
        region,
        maxLines: 2,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          fontFamily: 'ProximaNova',
        ),
      ),
    ),
  );
}
