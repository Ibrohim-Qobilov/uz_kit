import 'package:flutter/services.dart';

/// Validation and formatting utilities for Uzbekistan Personal Identification Number (JShShIR / PINFL).
class UzPinflValidator {
  UzPinflValidator._();

  /// Official checksum weights for Uzbekistan PINFL.
  static const List<int> _weights = [7, 3, 1, 7, 3, 1, 7, 3, 1, 7, 3, 1, 7];

  /// Cleans the PINFL string by removing non-digits.
  static String clean(String? pinfl) {
    if (pinfl == null) return '';
    return pinfl.replaceAll(RegExp(r'\D'), '');
  }

  /// Validates a 14-digit PINFL (JShShIR) according to the official checksum algorithm.
  static bool isValid(String? pinfl) {
    final digits = clean(pinfl);
    if (digits.length != 14) return false;

    // 1st digit must be 1, 2, 3, 4, 5, or 6
    final first = int.tryParse(digits[0]);
    if (first == null || first < 1 || first > 6) {
      return false;
    }

    // Verify birth date validity in digits 2-7 (DDMMYY)
    final day = int.tryParse(digits.substring(1, 3));
    final month = int.tryParse(digits.substring(3, 5));
    if (day == null || month == null || day < 1 || day > 31 || month < 1 || month > 12) {
      return false;
    }

    // Checksum verification
    int sum = 0;
    for (int i = 0; i < 13; i++) {
      sum += int.parse(digits[i]) * _weights[i];
    }
    final expectedCheckDigit = sum % 10;
    final actualCheckDigit = int.parse(digits[13]);

    return expectedCheckDigit == actualCheckDigit;
  }
}

/// A [TextInputFormatter] that restricts input to 14 digits.
class UzPinflInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = UzPinflValidator.clean(newValue.text);
    final limited = digits.length > 14 ? digits.substring(0, 14) : digits;

    return TextEditingValue(
      text: limited,
      selection: TextSelection.collapsed(offset: limited.length),
    );
  }
}
