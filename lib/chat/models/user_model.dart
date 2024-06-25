// user_model.dart

class UserModel {
  final String userId;
  final String userName;
  final String email;
  final String pfpUrl;

  UserModel({
    required this.userId,
    required this.userName,
    required this.email,
    required this.pfpUrl,
  });

  // Factory method to create a UserModel from a JSON map
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'],
      email: json['email'],
      userName: json['userName'],
      pfpUrl: json['pfpUrl'],
    );
  }

  // Method to convert a UserModel to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'email': email,
      'userName': userName,
      'pfpUrl': pfpUrl,
    };
  }
}
