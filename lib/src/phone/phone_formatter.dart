import 'package:flutter/services.dart';
import 'phone_utils.dart';

/// A [TextInputFormatter] that automatically formats Uzbekistan phone numbers as `+998 (xx) xxx-xx-xx`.
class UzPhoneInputFormatter extends TextInputFormatter {
  /// Creates a phone input formatter.
  UzPhoneInputFormatter({this.withCountryCode = true});

  /// Whether to include `+998 ` at the start.
  final bool withCountryCode;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String rawDigits = UzPhoneUtils.clean(newValue.text);

    // If user starts typing without 998, we keep local 9 digits
    if (rawDigits.startsWith('998')) {
      rawDigits = rawDigits.substring(3);
    }

    if (rawDigits.length > 9) {
      rawDigits = rawDigits.substring(0, 9);
    }

    final formatted = UzPhoneUtils.format(
      rawDigits,
      withCountryCode: withCountryCode,
    );

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
