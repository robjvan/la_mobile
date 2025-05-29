class NewUserMetricsModel {
  final int newUsersThisWeek;
  final int newUsersLastWeek;
  final int newUsersThisMonth;
  final int newUsersLastMonth;
  final int newUsers7days;
  final int newUsers30days;
  final int newUsers90days;

  NewUserMetricsModel({
    required this.newUsersThisWeek,
    required this.newUsersLastWeek,
    required this.newUsersThisMonth,
    required this.newUsersLastMonth,
    required this.newUsers7days,
    required this.newUsers30days,
    required this.newUsers90days,
  });

  factory NewUserMetricsModel.initial() => NewUserMetricsModel(
    newUsersThisWeek: 0,
    newUsersLastWeek: 0,
    newUsersThisMonth: 0,
    newUsersLastMonth: 0,
    newUsers7days: 0,
    newUsers30days: 0,
    newUsers90days: 0,
  );

  factory NewUserMetricsModel.fromMap(final Map<String, dynamic> json) =>
      NewUserMetricsModel(
        newUsersThisWeek: json['newUsersThisWeek'],
        newUsersLastWeek: json['newUsersLastWeek'],
        newUsersThisMonth: json['newUsersThisMonth'],
        newUsersLastMonth: json['newUsersLastMonth'],
        newUsers7days: json['newUsers7days'],
        newUsers30days: json['newUsers30days'],
        newUsers90days: json['newUsers90days'],
      );
}
