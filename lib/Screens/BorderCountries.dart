import 'package:flutter/material.dart';
import 'package:countries/CountriesModel.dart';
import 'package:countries/DataBase.dart';
import 'package:countries/Widgets/HomeDrawer.dart';

class BorderCountries extends StatefulWidget {
  final String country;
  BorderCountries(this.country);
  @override
  _BorderCountriesState createState() => _BorderCountriesState();
}

class _BorderCountriesState extends State<BorderCountries> {
  List<Country> countries;
  Future<dynamic> cnts;

  Future doStuff() async {
    countries = await Countries.instance.readByCountry(widget.country);
    return countries;
  }

  @override
  void initState() {
    cnts = doStuff();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.red,
        ),
        title: Text(
          "Bordering Countries",
          style: TextStyle(
              fontFamily: 'ProximaNova',
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: Colors.red),
        ),
      ),
      backgroundColor: Colors.white,
      drawer: homeDrawer(context),
      body: FutureBuilder(
          future: cnts,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return showRegions(countries);
            } else {
              return Container(
                child: Center(
                  child: Text("Fetching countries..."),
                ),
              );
            }
          }),
    );
  }
}

Widget showRegions(List<Country> countries) {
  if (countries.length == 0) {
    return Container(
      child: Text(
        "Oops! looks like this country does not have any neighbours!",
        style: TextStyle(
          fontFamily: 'ProximaNova',
          fontSize: 25,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
  return Column(
    children: [
      SizedBox(height: 24),
      Expanded(
        child: ListView.builder(
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.all(8),
          itemCount: countries.length,
          itemBuilder: (BuildContext context, int index) {
            final country = countries[index];

            return showCard(context, country);
          },
        ),
      ),
    ],
  );
}

Widget showCard(BuildContext context, Country country) {
  var langs = country.languages.split(",");
  String dispLangs = "";
  int prev;
  for (int i = 3; i <= langs.length; i++) {
    if (i == 3 || i == prev + 4) {
      dispLangs = dispLangs + langs[i - 1].substring(7) + " ";
      prev = i;
    }
  }
  return Card(
    color: Colors.white,
    child: ListTile(
      title: Text(
        country.name,
        maxLines: 2,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          fontFamily: 'ProximaNova',
        ),
      ),
      subtitle: Text(
        dispLangs,
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
