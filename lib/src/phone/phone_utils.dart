import 'mobile_operator.dart';

/// Utilities for validating, normalizing, and formatting Uzbekistan phone numbers.
class UzPhoneUtils {
  UzPhoneUtils._();

  /// Removes all non-digit characters from the phone number string.
  static String clean(String? phone) {
    if (phone == null) return '';
    return phone.replaceAll(RegExp(r'\D'), '');
  }

  /// Normalizes any input into the 12-digit standard format: `998901234567`.
  static String normalize(String? phone) {
    final digits = clean(phone);
    if (digits.isEmpty) return '';

    // If starts with 998 and is 12 digits
    if (digits.startsWith('998') && digits.length == 12) {
      return digits;
    }

    // If starts without 998 and has 9 digits (e.g., 901234567)
    if (digits.length == 9) {
      return '998$digits';
    }

    return digits;
  }

  /// Extracts the 2-digit operator code from a phone number (e.g., `90` from `+998901234567`).
  static String extractOperatorCode(String? phone) {
    final norm = normalize(phone);
    if (norm.length >= 5 && norm.startsWith('998')) {
      return norm.substring(3, 5);
    }
    if (norm.length == 9) {
      return norm.substring(0, 2);
    }
    return '';
  }

  /// Detects the [UzMobileOperator] from the phone number prefix.
  static UzMobileOperator detectOperator(String? phone) {
    final code = extractOperatorCode(phone);
    if (code.isEmpty) return UzMobileOperator.unknown;

    for (final op in UzMobileOperator.values) {
      if (op.prefixes.contains(code)) {
        return op;
      }
    }
    return UzMobileOperator.unknown;
  }

  /// Formats a phone number into readable format: `+998 (90) 123-45-67` or `(90) 123-45-67`.
  static String format(String? phone, {bool withCountryCode = true}) {
    final norm = normalize(phone);
    if (norm.isEmpty) return '';

    // Needs at least 9 local digits
    String localDigits;
    if (norm.startsWith('998')) {
      localDigits = norm.substring(3);
    } else {
      localDigits = norm;
    }

    final buffer = StringBuffer();
    if (withCountryCode) {
      buffer.write('+998 ');
    }

    final len = localDigits.length;
    if (len > 0) {
      buffer.write('(');
      buffer.write(localDigits.substring(0, len.clamp(0, 2)));
      if (len >= 2) buffer.write(') ');
    }
    if (len > 2) {
      buffer.write(localDigits.substring(2, len.clamp(2, 5)));
    }
    if (len > 5) {
      buffer.write('-');
      buffer.write(localDigits.substring(5, len.clamp(5, 7)));
    }
    if (len > 7) {
      buffer.write('-');
      buffer.write(localDigits.substring(7, len.clamp(7, 9)));
    }

    return buffer.toString().trim();
  }

  /// Validates whether the phone number is a valid 9-digit Uzbekistan mobile number.
  static bool isValid(String? phone) {
    final norm = normalize(phone);
    if (norm.length != 12 || !norm.startsWith('998')) {
      return false;
    }
    final op = detectOperator(norm);
    return op != UzMobileOperator.unknown;
  }
}
