class UserGrowthMetricsModel {
  final int userGrowthRate7days;
  final int userGrowthRate30days;
  final int userGrowthRate90days;
  final int userGrowthRateAnnual;

  UserGrowthMetricsModel({
    required this.userGrowthRate7days,
    required this.userGrowthRate30days,
    required this.userGrowthRate90days,
    required this.userGrowthRateAnnual,
  });

  factory UserGrowthMetricsModel.initial() => UserGrowthMetricsModel(
    userGrowthRate7days: 0,
    userGrowthRate30days: 0,
    userGrowthRate90days: 0,
    userGrowthRateAnnual: 0,
  );

  factory UserGrowthMetricsModel.fromMap(final Map<String, dynamic> json) =>
      UserGrowthMetricsModel(
        userGrowthRate7days: json['userGrowthRate7days'],
        userGrowthRate30days: json['userGrowthRate30days'],
        userGrowthRate90days: json['userGrowthRate90days'],
        userGrowthRateAnnual: json['userGrowthRateAnnual'],
      );

  // Map<String, dynamic> toMap() => {};
}
