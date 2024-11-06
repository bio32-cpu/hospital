class Account {
  final String username;
  final String password;
  final bool quit;
  final String role;

  Account({
    required this.username,
    required this.password,
    required this.quit,
    required this.role,
  });

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      username: json['username'],
      password: json['password'],
      quit: json['quit'] == 1,
      role: json['role'],
    );
  }
}
