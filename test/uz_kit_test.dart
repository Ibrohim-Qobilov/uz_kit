import 'package:flutter_test/flutter_test.dart';
import 'package:uz_kit/uz_kit.dart';

void main() {
  group('UzCardUtils Tests', () {
    test('Card Type Detection', () {
      expect(UzCardUtils.detectType('8600 1234 5678 9012'), UzCardType.uzcard);
      expect(UzCardUtils.detectType('5614 1234 5678 9012'), UzCardType.uzcard);
      expect(UzCardUtils.detectType('9860 1234 5678 9012'), UzCardType.humo);
      expect(UzCardUtils.detectType('4111 2222 3333 4444'), UzCardType.visa);
      expect(UzCardUtils.detectType('5200 1234 5678 9012'), UzCardType.mastercard);
      expect(UzCardUtils.detectType('6200 1234 5678 9012'), UzCardType.unionpay);
      expect(UzCardUtils.detectType('2200 1234 5678 9012'), UzCardType.mir);
      expect(UzCardUtils.detectType('1234'), UzCardType.unknown);
    });

    test('Card Formatting & Masking', () {
      expect(UzCardUtils.format('8600123456789012'), '8600 1234 5678 9012');
      expect(UzCardUtils.mask('8600123456789012'), '8600 **** **** 9012');
    });

    test('Expiry Date Formatting', () {
      expect(UzCardUtils.formatExpiry('1228'), '12/28');
      expect(UzCardUtils.isExpiryValid('12/29'), true);
      expect(UzCardUtils.isExpiryValid('13/28'), false);
    });
  });

  group('UzPhoneUtils Tests', () {
    test('Operator Detection', () {
      expect(UzPhoneUtils.detectOperator('+998 90 123 45 67'), UzMobileOperator.beeline);
      expect(UzPhoneUtils.detectOperator('+998 91 123 45 67'), UzMobileOperator.beeline);
      expect(UzPhoneUtils.detectOperator('+998 93 123 45 67'), UzMobileOperator.ucell);
      expect(UzPhoneUtils.detectOperator('+998 94 123 45 67'), UzMobileOperator.ucell);
      expect(UzPhoneUtils.detectOperator('+998 50 123 45 67'), UzMobileOperator.ucell);
      expect(UzPhoneUtils.detectOperator('+998 97 123 45 67'), UzMobileOperator.mobiuz);
      expect(UzPhoneUtils.detectOperator('+998 88 123 45 67'), UzMobileOperator.mobiuz);
      expect(UzPhoneUtils.detectOperator('+998 99 123 45 67'), UzMobileOperator.uztelecom);
      expect(UzPhoneUtils.detectOperator('+998 33 123 45 67'), UzMobileOperator.humans);
    });

    test('Phone Formatting & Normalization', () {
      expect(UzPhoneUtils.format('901234567'), '+998 (90) 123-45-67');
      expect(UzPhoneUtils.normalize('+998 (90) 123-45-67'), '998901234567');
      expect(UzPhoneUtils.isValid('+998 (90) 123-45-67'), true);
      expect(UzPhoneUtils.isValid('12345'), false);
    });
  });

  group('UzMoneyToWords Tests', () {
    test('Latin Script Numbers to Words', () {
      expect(
        UzMoneyToWords.convert(1450000),
        "bir million to'rt yuz ellik ming so'm",
      );
      expect(
        UzMoneyToWords.convert(500),
        "besh yuz so'm",
      );
      expect(
        UzMoneyToWords.convert(2500000.50),
        "ikki million besh yuz ming so'm 50 tiyin",
      );
    });

    test('Cyrillic Script Numbers to Words', () {
      expect(
        UzMoneyToWords.convert(1450000, script: UzScript.cyrillic),
        "бир миллион тўрт юз эллик минг сўм",
      );
    });

    test('Money Formatter', () {
      expect(UzMoneyFormatter.format(1250000), "1 250 000 so'm");
      expect(UzMoneyFormatter.format(1250000.5, decimalDigits: 2), "1 250 000.50 so'm");
    });
  });

  group('Identity & Validation Tests', () {
    test('Passport validation', () {
      expect(UzPassportUtils.isValid('AA1234567'), true);
      expect(UzPassportUtils.isValid('AD 7654321'), true);
      expect(UzPassportUtils.format('aa1234567'), 'AA 1234567');
      expect(UzPassportUtils.isValid('12345'), false);
    });

    test('STIR / INN validation', () {
      expect(UzTinValidator.isValid('123456789'), true);
      expect(UzTinValidator.isValid('12345'), false);
    });
  });
}
