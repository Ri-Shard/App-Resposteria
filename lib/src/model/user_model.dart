  

class MyUser {
   String? name;
   String? email;
   String? password;

  MyUser();

  Map<String, Object?> toFirebaseMap() {
    return <String, Object?>{
      'name': name,
      'email': email,
      'password': password,
    };
  }

  MyUser.fromFirebaseMap(Map<String, Object?> data,)
      : name = data['name'] as String,
        email = data['email'] as String,
        password = data['password'] as String;
}