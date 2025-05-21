class UserModel {
  final String? username;
  final int? userId;
  final int? roleId;
  final String? lastLogin;
  final String? accessToken;

  UserModel({
    required this.username,
    required this.userId,
    required this.roleId,
    required this.lastLogin,
    required this.accessToken,
  });

  factory UserModel.initial() => UserModel(
    username: null,
    userId: null,
    roleId: null,
    lastLogin: null,
    accessToken: null,
  );

  factory UserModel.fromMap(final Map<String, dynamic> json) => UserModel(
    username: json['username'],
    userId: json['userId'],
    roleId: json['roleId'],
    lastLogin: json['lastLogin'],
    accessToken: json['accessToken'],
  );

  Map<String, dynamic> toMap() => <String, dynamic>{
    'username': username,
    'userId': userId,
    'roleId': roleId,
    'lastLogin': lastLogin,
    'accessToken': accessToken,
  };
}
