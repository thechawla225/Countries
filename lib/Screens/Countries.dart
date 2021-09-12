import 'package:countries/Screens/BorderCountries.dart';
import 'package:flutter/material.dart';
import 'package:countries/DataBase.dart';
import 'package:countries/CountriesModel.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:countries/Widgets/HomeDrawer.dart';

class CountriesView extends StatefulWidget {
  final String region;
  CountriesView(this.region);
  @override
  _CountriesViewState createState() => _CountriesViewState();
}

class _CountriesViewState extends State<CountriesView> {
  List<Country> countries;
  Future<List<Country>> doStuff() async {
    countries = await Countries.instance.readByRegion(widget.region);
    return countries;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget val;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.red,
        ),
        title: Text(
          "Countries",
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
          future: doStuff(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                if (snapshot.hasError)
                  return new Text('Error: ${snapshot.error}');
                else if (snapshot.hasData) return showRegions(countries);
                break;
              case ConnectionState.waiting:
                val = Text(
                  "Loading...",
                );
                break;
              default:
                val = Container();
            }
            return val;
          }),
    );
  }
}

Widget showRegions(List<Country> countries) {
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
  return Card(
    shadowColor: Colors.red,
    semanticContainer: true,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    color: Colors.white,
    child: ListTile(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => BorderCountries(country.name)));
      },
      trailing: Container(
        width: 50,
        child: SvgPicture.network(
          country.flag,
          fit: BoxFit.contain,
          height: 100,
        ),
      ),
      title: Text(
        country.name,
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
