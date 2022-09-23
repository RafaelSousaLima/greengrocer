class AuthErrors {
  static String authErrorsString(String? code) {
    switch(code) {
      case 'INVALID_CREDENTIALS': return 'E-mail e/ou senha inválidos';
      case 'Invalid session token': return 'Token inválido';
      default: return 'Ocorreu um erro indefinido';
    }
  }
}
