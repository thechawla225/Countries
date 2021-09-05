final String table = 'countries';

class CountryFields {
  static final List<String> values = [
    id,
    name,
    region,
    languages,
    borders,
    alpha3Code,
    flag
  ];
  static String id = '_id';
  static String name = 'name';
  static String region = 'region';
  static String languages = 'languages';
  static String borders = 'borders';
  static String alpha3Code = 'alpha3Code';
  static String flag = 'flag';
}

class Country {
  final int id;
  final String name;
  final String region;
  final String languages;
  final String borders;
  final String alpha3Code;
  final String flag;
  const Country(
      {this.id,
      this.name,
      this.region,
      this.borders,
      this.alpha3Code,
      this.flag,
      this.languages});

  Map<String, Object> toJson() => {
        CountryFields.id: id,
        CountryFields.name: name,
        CountryFields.region: region,
        CountryFields.languages: languages,
        CountryFields.borders: borders,
        CountryFields.alpha3Code: alpha3Code,
        CountryFields.flag: flag,
      };

  Country copy({
    int id,
    String name,
    String region,
    String languages,
    String borders,
    String alpha3Code,
    String flag,
  }) =>
      Country(
          id: id ?? this.id,
          name: name ?? this.name,
          region: region ?? this.region,
          languages: languages ?? this.languages,
          borders: borders ?? this.borders,
          alpha3Code: alpha3Code ?? this.alpha3Code,
          flag: flag ?? this.flag);

  static Country fromJson(Map<String, Object> json) => Country(
        id: json[CountryFields.id] as int,
        name: json[CountryFields.name] as String,
        region: json[CountryFields.region] as String,
        languages: json[CountryFields.languages] as String,
        borders: json[CountryFields.borders] as String,
        alpha3Code: json[CountryFields.alpha3Code] as String,
        flag: json[CountryFields.flag] as String,
      );
}
