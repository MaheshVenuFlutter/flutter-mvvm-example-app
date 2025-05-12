class UserModel {
  // Variables
  final String? token;

  // Constructor
  UserModel({this.token});

  // Factory constructor: from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(token: json['token']);
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'token': token,
    };
  }
}
