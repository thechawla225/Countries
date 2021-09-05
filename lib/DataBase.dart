import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'CountriesModel.dart';
import 'package:countries/CountriesModel.dart';

class Countries {
  static final Countries instance = Countries._init();
  static Database _database;

  Countries._init();

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await _initDB('countries.db');
    return _database;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idtype = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final varcharType = 'VARCHAR(200) NOT NULL';
    await db.execute('''CREATE TABLE $table(
      ${CountryFields.id} $idtype,
      ${CountryFields.name} $varcharType,
      ${CountryFields.region} $varcharType,
      ${CountryFields.languages} $varcharType,
      ${CountryFields.borders} $varcharType,
      ${CountryFields.alpha3Code} $varcharType,
      ${CountryFields.flag} $varcharType
    ) ''');
  }

  Future<Country> createCountry(Country country) async {
    final db = await instance.database;

    final id = await db.insert(table, country.toJson());
    return country.copy(id: id);
  }

  Future<List<Country>> readByRegion(String region) async {
    final db = await instance.database;

    final maps = await db.query(table,
        columns: CountryFields.values,
        where: '${CountryFields.region} = ?',
        whereArgs: [region]);
    return maps.map((json) => Country.fromJson(json)).toList();
  }

  Future<List<Country>> readByCountry(String name) async {
    List<Country> borders = [];
    int i;
    final db = await instance.database;

    var maps = await db.query(table,
        columns: CountryFields.values,
        where: '${CountryFields.name} = ?',
        whereArgs: [name]);
    List<Country> countryDetails =
        maps.map((json) => Country.fromJson(json)).toList();
    var len = countryDetails[0].borders.length;
    var borderCountries =
        countryDetails[0].borders.substring(1, len - 1).split(',');
    for (i = 0; i < borderCountries.length; i++) {
      print(borderCountries[i]);
      var mapsTemp = await db.query(table,
          columns: CountryFields.values,
          where: '${CountryFields.alpha3Code} = ?',
          whereArgs: [borderCountries[i].substring(1)]);

      print(mapsTemp);
      List<Country> tempDetails =
          mapsTemp.map((json) => Country.fromJson(json)).toList();
      try {
        borders.add(tempDetails[0]);
      } catch (e) {
        print(e);
      }
    }
    print("Inside readbycountry");
    print(borders);
    return borders;
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
