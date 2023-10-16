class User {
  final int? id;

  String? username, email, password, notelp, borndate;

  User(
      {this.id,
      this.username,
      this.email,
      this.password,
      this.notelp,
      this.borndate});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'password': password,
      'notelp': notelp,
      'borndate': borndate
    };
  }

  User.fromMap(Map<String, dynamic> temp)
      : id = temp['id'],
        username = temp['username'],
        email = temp['email'],
        password = temp['password'],
        notelp = temp['notelp'],
        borndate = temp['borndate'];
}
