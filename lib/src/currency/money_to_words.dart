/// Supported Uzbek writing scripts for text conversion.
enum UzScript {
  /// Uzbek Latin alphabet (e.g., "bir million so'm")
  latin,

  /// Uzbek Cyrillic alphabet (e.g., "бир миллион сўм")
  cyrillic,
}

/// Converts numerical amounts and currency values into words in Uzbek.
class UzMoneyToWords {
  UzMoneyToWords._();

  static const List<String> _onesLatin = [
    '',
    'bir',
    'ikki',
    'uch',
    "to'rt",
    'besh',
    'olti',
    'yetti',
    'sakkiz',
    "to'qqiz",
  ];

  static const List<String> _tensLatin = [
    '',
    "o'n",
    'yigirma',
    "o'ttiz",
    'qirq',
    'ellik',
    'oltmish',
    'yetmish',
    'sakson',
    "to'qson",
  ];

  static const List<String> _scalesLatin = [
    '',
    'ming',
    'million',
    'milliard',
    'trillion',
    'kvadrillion',
  ];

  static const List<String> _onesCyrillic = [
    '',
    'бир',
    'икки',
    'уч',
    'тўрт',
    'беш',
    'олти',
    'етти',
    'саккиз',
    'тўққиз',
  ];

  static const List<String> _tensCyrillic = [
    '',
    'ўн',
    'йигирма',
    'ўттиз',
    'қирқ',
    'эллик',
    'олтмиш',
    'етмиш',
    'саксон',
    'тўқсон',
  ];

  static const List<String> _scalesCyrillic = [
    '',
    'минг',
    'миллион',
    'миллиард',
    'триллион',
    'квадриллион',
  ];

  /// Converts a [num] amount to words.
  ///
  /// Example:
  /// ```dart
  /// UzMoneyToWords.convert(1450000);
  /// // Output: "bir million to'rt yuz ellik ming so'm"
  ///
  /// UzMoneyToWords.convert(1450000, script: UzScript.cyrillic);
  /// // Output: "бир миллион тўрт юз эллик минг сўм"
  /// ```
  static String convert(
    num amount, {
    UzScript script = UzScript.latin,
    bool withCurrency = true,
    String? currencyName,
    String? tiyinName,
  }) {
    final isNegative = amount < 0;
    final absAmount = amount.abs();

    final integerPart = absAmount.truncate();
    final decimalPart = ((absAmount - integerPart) * 100).round();

    final isLatin = script == UzScript.latin;
    final zeroWord = isLatin ? 'nol' : 'ноль';
    final minusWord = isLatin ? 'minus ' : 'минус ';
    final defaultCurrency = isLatin ? "so'm" : 'сўм';
    final defaultTiyin = isLatin ? 'tiyin' : 'тийин';

    final effectiveCurrency = currencyName ?? defaultCurrency;
    final effectiveTiyin = tiyinName ?? defaultTiyin;

    String words;
    if (integerPart == 0) {
      words = zeroWord;
    } else {
      words = _convertInteger(integerPart, isLatin);
    }

    if (isNegative) {
      words = '$minusWord$words';
    }

    final buffer = StringBuffer(words);

    if (withCurrency) {
      buffer.write(' $effectiveCurrency');
    }

    if (decimalPart > 0) {
      buffer.write(' $decimalPart $effectiveTiyin');
    }

    return buffer.toString().trim();
  }

  static String _convertInteger(int number, bool isLatin) {
    if (number == 0) return '';

    final ones = isLatin ? _onesLatin : _onesCyrillic;
    final tens = isLatin ? _tensLatin : _tensCyrillic;
    final scales = isLatin ? _scalesLatin : _scalesCyrillic;
    final hundredWord = isLatin ? 'yuz' : 'юз';

    final parts = <String>[];
    int scaleIdx = 0;
    int n = number;

    while (n > 0) {
      final chunk = n % 1000;
      if (chunk > 0) {
        final chunkWords = <String>[];

        final hundreds = chunk ~/ 100;
        final remainder = chunk % 100;
        final tensDigit = remainder ~/ 10;
        final onesDigit = remainder % 10;

        if (hundreds > 0) {
          chunkWords.add('${ones[hundreds]} $hundredWord');
        }
        if (tensDigit > 0) {
          chunkWords.add(tens[tensDigit]);
        }
        if (onesDigit > 0) {
          chunkWords.add(ones[onesDigit]);
        }

        if (scaleIdx > 0 && scales.length > scaleIdx) {
          chunkWords.add(scales[scaleIdx]);
        }

        parts.insert(0, chunkWords.join(' '));
      }

      n ~/= 1000;
      scaleIdx++;
    }

    return parts.join(' ');
  }
}
