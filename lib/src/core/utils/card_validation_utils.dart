class CardValidationUtils {
  static const String bullet = '\u2022';
  static const String emptyCardNumberPlaceholder =
      '$bullet$bullet$bullet$bullet '
      '$bullet$bullet$bullet$bullet '
      '$bullet$bullet$bullet$bullet '
      '$bullet$bullet$bullet$bullet';
  static const String emptyCvvPlaceholder = '$bullet$bullet$bullet';

  static String formatCardNumber(String input) {
    final digits = input.replaceAll(' ', '');

    if (digits.isEmpty) {
      return emptyCardNumberPlaceholder;
    }

    if (digits.length >= 8) {
      final first4 = digits.substring(0, 4);
      final last4 = digits.substring(digits.length - 4);
      return '$first4 '
          '$bullet$bullet$bullet$bullet '
          '$bullet$bullet$bullet$bullet '
          '$last4';
    }

    final buffer = StringBuffer();
    for (var index = 0; index < digits.length; index++) {
      if (index > 0 && index % 4 == 0) {
        buffer.write(' ');
      }
      buffer.write(digits[index]);
    }

    while (buffer.length < 19) {
      if (buffer.length == 4 || buffer.length == 9 || buffer.length == 14) {
        buffer.write(' ');
      } else {
        buffer.write(bullet);
      }
    }

    return buffer.toString();
  }

  static String maskCvv(String cvv) {
    if (cvv.isEmpty) {
      return emptyCvvPlaceholder;
    }

    return cvv.replaceAll(RegExp(r'.'), bullet);
  }

  static String formatCardHolder(String name) {
    return name.trim().toUpperCase();
  }
}
