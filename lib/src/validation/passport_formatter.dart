import 'package:flutter/services.dart';

/// Formatting and validation utilities for Uzbekistan Passports and ID-Cards.
class UzPassportUtils {
  UzPassportUtils._();

  /// Validates whether the string matches a valid Uzbekistan Passport/ID format (`AA1234567` or `AA 1234567`).
  static bool isValid(String? passport) {
    if (passport == null) return false;
    final clean = passport.replaceAll(RegExp(r'\s'), '').toUpperCase();
    final regex = RegExp(r'^[A-Z]{2}\d{7}$');
    return regex.hasMatch(clean);
  }

  /// Formats passport series and number as `AA 1234567`.
  static String format(String? passport) {
    if (passport == null) return '';
    final clean = passport.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '').toUpperCase();
    if (clean.length <= 2) return clean;
    return '${clean.substring(0, 2)} ${clean.substring(2, clean.length.clamp(2, 9))}';
  }
}

/// A [TextInputFormatter] that formats passport input as `AA 1234567` and forces uppercase.
class UzPassportInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final clean = newValue.text.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '').toUpperCase();
    final limited = clean.length > 9 ? clean.substring(0, 9) : clean;
    final formatted = UzPassportUtils.format(limited);

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
