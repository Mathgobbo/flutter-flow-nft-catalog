class User {
  bool? loggedIn;
  String? addr;
  int? keyId;

  User({this.loggedIn, this.addr, this.keyId});

  User.fromJson(Map json) {
    loggedIn = json['loggedIn'];
    addr = json['addr'];
    keyId = json['keyId'];
  }
}
