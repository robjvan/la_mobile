class UserMetricsModel {
  final int totalUsers;
  final int activeUsers;
  final int powerUsers;
  final int haveReviewed;
  final int emailNotConfirmed;

  UserMetricsModel({
    required this.totalUsers,
    required this.activeUsers,
    required this.powerUsers,
    required this.haveReviewed,
    required this.emailNotConfirmed,
  });

  factory UserMetricsModel.initial() => UserMetricsModel(
    totalUsers: 0,
    activeUsers: 0,
    powerUsers: 0,
    haveReviewed: 0,
    emailNotConfirmed: 0,
  );

  factory UserMetricsModel.fromMap(final Map<String, dynamic> json) =>
      UserMetricsModel(
        totalUsers: json['totalUsers'],
        activeUsers: json['activeUsers'],
        powerUsers: json['powerUsers'],
        haveReviewed: json['haveReviewed'],
        emailNotConfirmed: json['emailNotConfirmed'],
      );

  // Map<String, int> toMap() => <String, int>{
  //   'totalUsers': totalUsers,
  //   'activeUsers': activeUsers,
  //   'powerUsers': powerUsers,
  //   'haveReviewed': haveReviewed,
  //   'emailNotConfirmed': emailNotConfirmed,
  // };
}
