class User {
  int? id;
  String? email;
  String? password;
  int? numOfLogins = 0;

  User({this.id, this.email, this.password, this.numOfLogins});

  // Convert user object into a Map object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};

    map['id'] = id;
    map['email'] = email;
    map['password'] = password;
    map['numOfLogins'] = numOfLogins;

    return map;
  }

  // Extract a user object from a Map object
  User.fromMapObject(Map<String, dynamic> map) {
    id = map['id'];
    email = map['email'];
    password = map['password'];
    numOfLogins = map['numOfLogins'];
  }
}
