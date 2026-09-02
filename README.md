# 🇺🇿 UzKit — Flutter & Dart Toolkit for Uzbekistan

[![Pub Version](https://img.shields.io/pub/v/uz_kit.svg?style=for-the-badge&logo=dart&color=0284C7)](https://pub.dev/packages/uz_kit)
[![Pub Points](https://img.shields.io/pub/points/uz_kit?style=for-the-badge&color=10B981)](https://pub.dev/packages/uz_kit/score)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](https://opensource.org/licenses/MIT)
[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)

A modern, production-grade Flutter & Dart utility toolkit specifically crafted for **fintech, banking, e-commerce, and mobile applications in Uzbekistan**.

---

## 🚀 Key Features

* 💳 **Card Toolkit:**
  * Auto-detect card brands: **Uzcard** (`8600`, `5614`), **Humo** (`9860`), **Visa**, **Mastercard**, **UnionPay**, **Mir**.
  * Input formatter for card numbers (`8600 1234 5678 9012`).
  * Expiry date formatter & validation (`MM/YY`).
  * Privacy masking (`8600 **** **** 1234`).
  * Luhn algorithm (Mod 10) checksum verification.
* 📞 **Phone & Operator Toolkit:**
  * Auto-detect mobile operators (**Beeline**, **Ucell**, **Mobiuz**, **Uztelecom**, **Humans**, **Perfectum**).
  * Auto-formatting input: `+998 (90) 123-45-67`.
  * Normalization to standard 12-digit format `998901234567`.
* 💰 **Money & Currency:**
  * **Number to Words in Uzbek:** Convert `1 450 000` $\rightarrow$ *"bir million to'rt yuz ellik ming so'm"* (both **Latin** & **Cyrillic** supported).
  * Currency text formatters with space separators (`1 500 000 so'm`).
* 🆔 **Identity & Validation:**
  * **JShShIR (PINFL - 14 digits):** Official State Tax Committee checksum algorithm validation.
  * **Passport / ID-Card:** Formatters and validators (`AA 1234567`).
  * **STIR (INN - 9 digits):** Validation for business and taxpayer IDs.

---

## 📦 Installation

Add `uz_kit` to your `pubspec.yaml`:

```yaml
dependencies:
  uz_kit: ^0.1.0
```

Or run:

```bash
flutter pub add uz_kit
```

---

## 🛠 Usage Examples

### 1. Bank Card Detection & Formatting

```dart
import 'package:uz_kit/uz_kit.dart';

// 1. Detect Card Brand
final type = UzCardUtils.detectType('8600123456789012');
print(type.displayName); // Uzcard
print(type.isLocal);     // true

// 2. Format & Mask
final formatted = UzCardUtils.format('8600123456789012');
print(formatted); // "8600 1234 5678 9012"

final masked = UzCardUtils.mask('8600123456789012');
print(masked); // "8600 **** **** 9012"

// 3. Use in TextField Formatter
TextField(
  inputFormatters: [UzCardNumberFormatter()],
  decoration: InputDecoration(
    hintText: '8600 0000 0000 0000',
  ),
);
```

---

### 2. Phone Number & Mobile Operator

```dart
// 1. Detect Operator
final op = UzPhoneUtils.detectOperator('+998 90 123 45 67');
print(op.displayName); // Beeline
print(op.companyName); // Unitel LLC

// 2. Format & Normalize
final formatted = UzPhoneUtils.format('901234567');
print(formatted); // "+998 (90) 123-45-67"

final norm = UzPhoneUtils.normalize('+998 (90) 123-45-67');
print(norm); // "998901234567"

// 3. In TextField
TextField(
  keyboardType: TextInputType.phone,
  inputFormatters: [UzPhoneInputFormatter()],
  decoration: InputDecoration(
    hintText: '+998 (90) 123-45-67',
  ),
);
```

---

### 3. Convert Amount to Words in Uzbek (Kvitansiyalar uchun)

```dart
// Latin alphabet
final wordsLatin = UzMoneyToWords.convert(1450000);
print(wordsLatin); 
// Output: "bir million to'rt yuz ellik ming so'm"

// With tiyin
final withTiyin = UzMoneyToWords.convert(2500000.50);
print(withTiyin); 
// Output: "ikki million besh yuz ming so'm 50 tiyin"

// Cyrillic alphabet
final wordsCyrillic = UzMoneyToWords.convert(1450000, script: UzScript.cyrillic);
print(wordsCyrillic); 
// Output: "бир миллион тўрт юз эллик минг сўм"
```

---

### 4. JShShIR (PINFL) & Passport Validation

```dart
// JShShIR Checksum Validation (14 digits)
final isValidPinfl = UzPinflValidator.isValid('30101901234567');

// Passport Series & Number Format
final formattedPassport = UzPassportUtils.format('aa1234567');
print(formattedPassport); // "AA 1234567"

final isValidPassport = UzPassportUtils.isValid('AA 1234567');
print(isValidPassport); // true
```

---

## 🧪 Testing

Run all unit tests with 100% coverage:

```bash
flutter test
```

---

## 👨‍💻 Author & Contribution

Developed with ❤️ by **[Ibrohim Qobilov](https://github.com/Ibrohim-Qobilov)**.

Contributions, issues, and feature requests are welcome! Feel free to check the [issues page](https://github.com/Ibrohim-Qobilov/uz_kit/issues).

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
