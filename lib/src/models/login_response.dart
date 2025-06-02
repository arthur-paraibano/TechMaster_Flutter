class LoginResponse {
  final String token;
  final int id;
  final String name;
  final String email;
  final String profile;
  final bool firstLogin;

  LoginResponse({
    required this.token,
    required this.id,
    required this.name,
    required this.email,
    required this.profile,
    required this.firstLogin,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      token: json['token'],
      id: json['id'],
      name: json['name'],
      email: json['email'],
      profile: json['profile'],
      firstLogin: json['firstLogin'],
    );
  }
}
