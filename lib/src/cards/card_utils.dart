import 'card_type.dart';

/// Utilities for validating, formatting, and detecting card types in Uzbekistan.
class UzCardUtils {
  UzCardUtils._();

  /// Removes all non-digit characters from the card number string.
  static String clean(String? cardNumber) {
    if (cardNumber == null) return '';
    return cardNumber.replaceAll(RegExp(r'\D'), '');
  }

  /// Detects the [UzCardType] from the given card number or BIN prefix.
  static UzCardType detectType(String? cardNumber) {
    final digits = clean(cardNumber);
    if (digits.isEmpty) return UzCardType.unknown;

    // Uzcard: 8600, 5614
    if (digits.startsWith('8600') || digits.startsWith('5614')) {
      return UzCardType.uzcard;
    }

    // Humo: 9860
    if (digits.startsWith('9860')) {
      return UzCardType.humo;
    }

    // Visa: 4...
    if (digits.startsWith('4')) {
      return UzCardType.visa;
    }

    // Mastercard: 51-55, 2221-2720
    if (digits.length >= 2) {
      final twoDigits = int.tryParse(digits.substring(0, 2)) ?? 0;
      if (twoDigits >= 51 && twoDigits <= 55) {
        return UzCardType.mastercard;
      }
    }
    if (digits.length >= 4) {
      final fourDigits = int.tryParse(digits.substring(0, 4)) ?? 0;
      if (fourDigits >= 2221 && fourDigits <= 2720) {
        return UzCardType.mastercard;
      }
    }

    // UnionPay: 62...
    if (digits.startsWith('62')) {
      return UzCardType.unionpay;
    }

    // Mir: 2200-2204
    if (digits.length >= 4) {
      final fourDigits = int.tryParse(digits.substring(0, 4)) ?? 0;
      if (fourDigits >= 2200 && fourDigits <= 2204) {
        return UzCardType.mir;
      }
    }

    return UzCardType.unknown;
  }

  /// Formats a card number with spaces every 4 digits (e.g., `8600 0000 0000 0000`).
  static String format(String? cardNumber, {String separator = ' '}) {
    final digits = clean(cardNumber);
    if (digits.isEmpty) return '';

    final buffer = StringBuffer();
    for (int i = 0; i < digits.length; i++) {
      if (i > 0 && i % 4 == 0) {
        buffer.write(separator);
      }
      buffer.write(digits[i]);
    }
    return buffer.toString();
  }

  /// Masks a 16-digit card number for privacy (e.g., `8600 **** **** 1234`).
  static String mask(
    String? cardNumber, {
    String maskChar = '*',
    int startVisible = 4,
    int endVisible = 4,
    String separator = ' ',
  }) {
    final digits = clean(cardNumber);
    if (digits.length < (startVisible + endVisible)) {
      return format(digits, separator: separator);
    }

    final start = digits.substring(0, startVisible);
    final end = digits.substring(digits.length - endVisible);
    final maskedLength = digits.length - startVisible - endVisible;
    final masked = maskChar * maskedLength;

    final full = start + masked + end;
    final buffer = StringBuffer();
    for (int i = 0; i < full.length; i++) {
      if (i > 0 && i % 4 == 0) {
        buffer.write(separator);
      }
      buffer.write(full[i]);
    }
    return buffer.toString();
  }

  /// Validates the card number length (must be 16 digits for Uzbekistan cards).
  static bool isValidLength(String? cardNumber) {
    final digits = clean(cardNumber);
    return digits.length == 16;
  }

  /// Validates card number using the Luhn checksum algorithm (Mod 10).
  static bool isValidLuhn(String? cardNumber) {
    final digits = clean(cardNumber);
    if (digits.length < 13 || digits.length > 19) return false;

    int sum = 0;
    bool alternate = false;

    for (int i = digits.length - 1; i >= 0; i--) {
      int n = int.parse(digits[i]);
      if (alternate) {
        n *= 2;
        if (n > 9) {
          n = (n % 10) + 1;
        }
      }
      sum += n;
      alternate = !alternate;
    }

    return sum % 10 == 0;
  }

  /// Formats an expiry date string as `MM/YY` (e.g., `12/28`).
  static String formatExpiry(String? expiry, {String separator = '/'}) {
    final digits = clean(expiry);
    if (digits.isEmpty) return '';
    if (digits.length <= 2) return digits;
    return '${digits.substring(0, 2)}$separator${digits.substring(2, digits.length.clamp(2, 4))}';
  }

  /// Checks if an expiry date `MM/YY` is valid and not in the past.
  static bool isExpiryValid(String? expiry) {
    final digits = clean(expiry);
    if (digits.length != 4) return false;

    final month = int.tryParse(digits.substring(0, 2));
    final year = int.tryParse('20${digits.substring(2, 4)}');

    if (month == null || year == null || month < 1 || month > 12) {
      return false;
    }

    final now = DateTime.now();
    final cardDate = DateTime(year, month + 1, 0, 23, 59, 59);
    return cardDate.isAfter(now);
  }
}
