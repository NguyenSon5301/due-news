class TokenUser {
  String tokenUser;
  TokenUser({
    required this.tokenUser,
  });
  factory TokenUser.fromJson(Map<String, dynamic> json) {
    return TokenUser(
      tokenUser: json['token'],
    );
  }
}
