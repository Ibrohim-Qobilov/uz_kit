import 'package:flutter/services.dart';

/// Validation and formatting utilities for Uzbekistan Taxpayer Identification Number (STIR / INN).
class UzTinValidator {
  UzTinValidator._();

  /// Cleans the STIR string by removing non-digits.
  static String clean(String? tin) {
    if (tin == null) return '';
    return tin.replaceAll(RegExp(r'\D'), '');
  }

  /// Validates a 9-digit STIR / INN number.
  static bool isValid(String? tin) {
    final digits = clean(tin);
    if (digits.length != 9) return false;
    return RegExp(r'^\d{9}$').hasMatch(digits);
  }
}

/// A [TextInputFormatter] that restricts input to 9 digits for STIR / INN.
class UzTinInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = UzTinValidator.clean(newValue.text);
    final limited = digits.length > 9 ? digits.substring(0, 9) : digits;

    return TextEditingValue(
      text: limited,
      selection: TextSelection.collapsed(offset: limited.length),
    );
  }
}
