class UserModel {
  final String email;
  final String password;
  final String? displayName;

  UserModel({required this.email, required this.password, this.displayName});
}
