import 'package:flutter/services.dart';
import 'card_utils.dart';

/// A [TextInputFormatter] that automatically formats card number input as `xxxx xxxx xxxx xxxx`.
class UzCardNumberFormatter extends TextInputFormatter {
  /// Creates a card number formatter with customizable separator (default is a space).
  UzCardNumberFormatter({this.separator = ' ', this.maxLength = 16});

  /// Separator character placed every 4 digits.
  final String separator;

  /// Maximum number of raw digits (default is 16).
  final int maxLength;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final rawDigits = UzCardUtils.clean(newValue.text);
    final limitedDigits = rawDigits.length > maxLength
        ? rawDigits.substring(0, maxLength)
        : rawDigits;

    final formatted = UzCardUtils.format(limitedDigits, separator: separator);

    // Calculate new cursor selection index
    int selectionIndex = formatted.length;

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}

/// A [TextInputFormatter] that automatically formats card expiry input as `MM/YY`.
class UzCardExpiryFormatter extends TextInputFormatter {
  /// Creates an expiry date formatter (default separator is `/`).
  UzCardExpiryFormatter({this.separator = '/'});

  /// Separator character between month and year.
  final String separator;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final rawDigits = UzCardUtils.clean(newValue.text);
    final limitedDigits =
        rawDigits.length > 4 ? rawDigits.substring(0, 4) : rawDigits;

    final formatted =
        UzCardUtils.formatExpiry(limitedDigits, separator: separator);

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
