class UserModel {
  final String? id;
  final String? displayName;
  final String? email;
  final String? photoUrl;

  UserModel({
    required this.id,
    required this.displayName,
    required this.email,
    required this.photoUrl,
  });

  // From JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      displayName: json['displayName'] as String,
      email: json['email'] as String,
      photoUrl: json['photoUrl'] as String,
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'displayName': displayName,
      'email': email,
      'photoUrl': photoUrl,
    };
  }
}
