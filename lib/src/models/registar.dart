class Registar {
  final String name;
  final String email;
  final String password;
  final String cpf;
  final String profile;

  Registar({
    required this.name,
    required this.email,
    required this.password,
    required this.cpf,
    required this.profile,
  });

  factory Registar.fromJson(Map<String, dynamic> json) {
    return Registar(
      name: json['name'],
      email: json['email'],
      password: json['password'],
      cpf: json['cpf'],
      profile: json['profile'],
    );
  }
}
