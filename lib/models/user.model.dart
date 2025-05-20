class UserModel {
  final String? username;
  final int? userId;
  // TODO: Add missing fields

  UserModel({this.username, this.userId});

  factory UserModel.initial() => UserModel();

  factory UserModel.fromMap(final Map<String, dynamic> json) =>
      UserModel(username: json['username'], userId: json['userId']);

  Map<String, dynamic> toMap() => <String, dynamic>{
    'username': username,
    'userId': userId,
  };
}
