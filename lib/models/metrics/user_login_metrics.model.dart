class UserLoginMetricsModel {
  final int totalLogins;
  final int totalLoginsToday;
  final int totalLoginsThisWeek;
  final int totalLoginsThisMonth;
  final int totalLogins7days;
  final int totalLogins30days;
  final int totalLogins90days;
  final int totalLoginsThisYear;

  UserLoginMetricsModel({
    required this.totalLogins,
    required this.totalLoginsToday,
    required this.totalLoginsThisWeek,
    required this.totalLoginsThisMonth,
    required this.totalLogins7days,
    required this.totalLogins30days,
    required this.totalLogins90days,
    required this.totalLoginsThisYear,
  });

  factory UserLoginMetricsModel.initial() => UserLoginMetricsModel(
    totalLogins: 0,
    totalLoginsToday: 0,
    totalLoginsThisWeek: 0,
    totalLoginsThisMonth: 0,
    totalLogins7days: 0,
    totalLogins30days: 0,
    totalLogins90days: 0,
    totalLoginsThisYear: 0,
  );

  factory UserLoginMetricsModel.fromMap(final Map<String, dynamic> json) =>
      UserLoginMetricsModel(
        totalLogins: json['totalLogins'],
        totalLoginsToday: json['totalLoginsToday'],
        totalLoginsThisWeek: json['totalLoginsThisWeek'],
        totalLoginsThisMonth: json['totalLoginsThisMonth'],
        totalLogins7days: json['totalLogins7days'],
        totalLogins30days: json['totalLogins30days'],
        totalLogins90days: json['totalLogins90days'],
        totalLoginsThisYear: json['totalLoginsThisYear'],
      );

  // Map<String, dynamic> toMap() => {};
}
