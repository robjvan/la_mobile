class GeographicalMetricsModel {
  final int usersInCanada;
  final int usersInUSA;
  final int usersInOther;
  final String? topCountryByUsers;
  final int topCountryNumUsers;
  final String? topCountryByLogins;
  final int topCountryNumLogins;

  GeographicalMetricsModel({
    required this.usersInCanada,
    required this.usersInUSA,
    required this.usersInOther,
    required this.topCountryByUsers,
    required this.topCountryNumUsers,
    required this.topCountryByLogins,
    required this.topCountryNumLogins,
  });

  factory GeographicalMetricsModel.initial() => GeographicalMetricsModel(
    usersInCanada: 0,
    usersInUSA: 0,
    usersInOther: 0,
    topCountryByUsers: null,
    topCountryNumUsers: 0,
    topCountryByLogins: null,
    topCountryNumLogins: 0,
  );

  factory GeographicalMetricsModel.fromMap(final Map<String, dynamic> json) =>
      GeographicalMetricsModel(
        usersInCanada: json['usersInCanada'],
        usersInUSA: json['usersInUSA'],
        usersInOther: json['usersInOther'],
        topCountryByUsers: json['topCountryByUsers'],
        topCountryNumUsers: json['topCountryNumUsers'],
        topCountryByLogins: json['topCountryByLogins'],
        topCountryNumLogins: json['topCountryNumLogins'],
      );

  // Map<String, int> toMap() => <String, int>{
  //   'usersInCanada': usersInCanada,
  //   'usersInUSA': usersInUSA,
  //   'usersInOther': usersInOther,
  //   'topCountryByUsers': topCountryByUsers,
  //   'topCountryNumUsers': topCountryNumUsers,
  //   'topCountryByLogins': topCountryByLogins,
  //   'topCountryNumLogins': topCountryNumLogins,
  // };
}
