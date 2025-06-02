class Validator {
  static String? validateCpf(String cpf) {
    cpf = cpf.replaceAll(RegExp(r'[^0-9]'), '');

    if (cpf.length != 11) {
      return 'O CPF deve ter 11 dígitos';
    }

    if (RegExp(r'^(\d)\1*$').hasMatch(cpf)) {
      return 'CPF inválido';
    }

    int sum = 0;
    for (int i = 0; i < 9; i++) {
      sum += int.parse(cpf[i]) * (10 - i);
    }
    int firstDigit = (sum * 10) % 11;
    if (firstDigit == 10) firstDigit = 0;

    if (firstDigit != int.parse(cpf[9])) {
      return 'CPF inválido';
    }

    sum = 0;
    for (int i = 0; i < 10; i++) {
      sum += int.parse(cpf[i]) * (11 - i);
    }
    int secondDigit = (sum * 10) % 11;
    if (secondDigit == 10) secondDigit = 0;

    if (secondDigit != int.parse(cpf[10])) {
      return 'CPF inválido';
    }

    return null;
  }

  static String? validateEmail(String email, {bool requireGmail = false}) {
    email = email.trim().toLowerCase();

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      return 'E-mail inválido';
    }

    if (requireGmail && !email.endsWith('@gmail.com')) {
      return 'O e-mail deve ser do domínio @gmail.com';
    }

    return null;
  }
}
