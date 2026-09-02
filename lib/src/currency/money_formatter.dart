import 'package:flutter/services.dart';

/// Formats currency amounts and provides a money [TextInputFormatter].
class UzMoneyFormatter {
  UzMoneyFormatter._();

  /// Formats a number with thousand separators (e.g. `1 250 000 so'm` or `1 250 000.50`).
  static String format(
    num? amount, {
    String symbol = "so'm",
    int decimalDigits = 0,
    String thousandSeparator = ' ',
    String decimalSeparator = '.',
    bool symbolAtEnd = true,
  }) {
    if (amount == null) return '';

    final isNegative = amount < 0;
    final absAmount = amount.abs();

    final integerPart = absAmount.truncate();
    final decimalValue = absAmount - integerPart;

    // Format integer part with spaces
    final intStr = integerPart.toString();
    final buffer = StringBuffer();
    final len = intStr.length;

    for (int i = 0; i < len; i++) {
      if (i > 0 && (len - i) % 3 == 0) {
        buffer.write(thousandSeparator);
      }
      buffer.write(intStr[i]);
    }

    String result = buffer.toString();

    // Format decimal part if required
    if (decimalDigits > 0) {
      final decStr = decimalValue
          .toStringAsFixed(decimalDigits)
          .split('.')
          .last;
      result = '$result$decimalSeparator$decStr';
    }

    if (isNegative) {
      result = '-$result';
    }

    if (symbol.isNotEmpty) {
      result = symbolAtEnd ? '$result $symbol' : '$symbol $result';
    }

    return result.trim();
  }
}

/// A [TextInputFormatter] that formats currency amount input with spaces (e.g., `1 500 000`).
class UzMoneyInputFormatter extends TextInputFormatter {
  /// Creates a money input formatter.
  UzMoneyInputFormatter({this.thousandSeparator = ' '});

  /// Separator for thousands (default is a space).
  final String thousandSeparator;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final rawDigits = newValue.text.replaceAll(RegExp(r'\D'), '');
    if (rawDigits.isEmpty) {
      return const TextEditingValue();
    }

    final number = int.tryParse(rawDigits) ?? 0;
    final formatted = UzMoneyFormatter.format(
      number,
      symbol: '',
      thousandSeparator: thousandSeparator,
    );

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
