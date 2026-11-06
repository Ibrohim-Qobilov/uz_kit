// Keeps README.md and README_UZ.md honest: every example output shown in the
// docs is asserted here, so a behavior change fails CI instead of silently
// making the documentation wrong.
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uz_kit/uz_kit.dart';

TextEditingValue _type(TextInputFormatter f, String text) => f.formatEditUpdate(
      TextEditingValue.empty,
      TextEditingValue(text: text),
    );

void main() {
  group('README: cards', () {
    test('detectType', () {
      final type = UzCardUtils.detectType('8600123456789012');
      expect(type, UzCardType.uzcard);
      expect(type.displayName, 'Uzcard');
      expect(type.isLocal, isTrue);
      expect(type.brandColor, 0xFF005696);
    });

    test('format, mask, Luhn, expiry', () {
      expect(UzCardUtils.format('9860123456789012'), '9860 1234 5678 9012');
      expect(UzCardUtils.mask('8600123456789012'), '8600 **** **** 9012');
      expect(UzCardUtils.isValidLength('8600 1234 5678 9012'), isTrue);
      expect(UzCardUtils.isValidLuhn('8600123456789012'), isTrue);
      expect(UzCardUtils.formatExpiry('1228'), '12/28');
      expect(UzCardUtils.isExpiryValid('12/28'), isTrue);
    });
  });

  group('README: phone', () {
    test('operator, format, normalize, isValid', () {
      final op = UzPhoneUtils.detectOperator('+998 90 123 45 67');
      expect(op, UzMobileOperator.beeline);
      expect(op.displayName, 'Beeline');
      expect(op.companyName, 'Unitel LLC');
      expect(UzPhoneUtils.format('901234567'), '+998 (90) 123-45-67');
      expect(UzPhoneUtils.format('998901234567', withCountryCode: false),
          '(90) 123-45-67');
      expect(UzPhoneUtils.normalize('+998 (90) 123-45-67'), '998901234567');
      expect(UzPhoneUtils.isValid('+998 93 123 45 67'), isTrue);
      expect(UzPhoneUtils.isValid('+998 92 123 45 67'), isFalse);
    });
  });

  group('README: money', () {
    test('convert and format', () {
      expect(UzMoneyToWords.convert(1450000),
          "bir million to'rt yuz ellik ming so'm");
      expect(UzMoneyToWords.convert(2500000.50),
          "ikki million besh yuz ming so'm 50 tiyin");
      expect(UzMoneyToWords.convert(1450000, script: UzScript.cyrillic),
          'бир миллион тўрт юз эллик минг сўм');
      expect(UzMoneyToWords.convert(125, withCurrency: false),
          'bir yuz yigirma besh');
      expect(UzMoneyFormatter.format(1250000), "1 250 000 so'm");
      expect(
        UzMoneyFormatter.format(99.9,
            symbol: r'$', symbolAtEnd: false, decimalDigits: 2),
        r'$ 99.90',
      );
    });
  });

  group('README: identity', () {
    test('PINFL, passport, TIN', () {
      expect(UzPinflValidator.isValid('30101901234569'), isTrue);
      expect(UzPinflValidator.isValid('30101901234567'), isFalse);
      expect(UzPassportUtils.format('aa1234567'), 'AA 1234567');
      expect(UzPassportUtils.isValid('AA 1234567'), isTrue);
      expect(UzTinValidator.isValid('123456789'), isTrue);
    });
  });

  group('README: input formatters', () {
    test('format while typing', () {
      expect(_type(UzCardNumberFormatter(), '8600123456789012').text,
          '8600 1234 5678 9012');
      expect(_type(UzCardExpiryFormatter(), '1228').text, '12/28');
      expect(_type(UzPhoneInputFormatter(), '901234567').text,
          '+998 (90) 123-45-67');
      expect(_type(UzMoneyInputFormatter(), '1500000').text, '1 500 000');
      expect(_type(UzPassportInputFormatter(), 'aa1234567').text,
          'AA 1234567');
      expect(_type(UzPinflInputFormatter(), '301019012345691').text,
          '30101901234569');
      expect(_type(UzTinInputFormatter(), '1234567890').text, '123456789');
    });
  });
}
