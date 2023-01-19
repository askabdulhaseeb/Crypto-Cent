enum LoginMethod {
  email('email'),
  phone('phone'),
  google('google'),
  apple('apple');

  const LoginMethod(this.json);
  final String json;
}

class LoginMethodConvertor {
  LoginMethod toEnum(String method) {
    switch (method) {
      case 'email':
        return LoginMethod.email;
      case 'phone':
        return LoginMethod.phone;
      case 'google':
        return LoginMethod.google;
      case 'apple':
        return LoginMethod.apple;
      default:
        return LoginMethod.apple;
    }
  }
}
