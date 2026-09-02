<p align="center">
  <img src="https://raw.githubusercontent.com/Ibrohim-Qobilov/uz_kit/main/assets/screenshots/preview.png" width="800" alt="UzKit Flutter Package Banner" />
</p>

# 🇺🇿 UzKit — The Ultimate Flutter & Dart Toolkit for Uzbekistan

<p align="center">
  <a href="https://pub.dev/packages/uz_kit"><img src="https://img.shields.io/pub/v/uz_kit.svg?style=for-the-badge&logo=dart&color=0284C7" alt="Pub Version" /></a>
  <a href="https://pub.dev/packages/uz_kit/score"><img src="https://img.shields.io/pub/points/uz_kit?style=for-the-badge&color=10B981" alt="Pub Points" /></a>
  <a href="https://github.com/Ibrohim-Qobilov/uz_kit/stargazers"><img src="https://img.shields.io/github/stars/Ibrohim-Qobilov/uz_kit?style=for-the-badge&logo=github&color=F59E0B" alt="GitHub Stars" /></a>
  <a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/License-MIT-purple.svg?style=for-the-badge" alt="License: MIT" /></a>
  <a href="https://flutter.dev"><img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter" /></a>
</p>

---

A modern, high-performance Flutter and Dart utility toolkit specifically designed for **Fintech, Banking, E-commerce, Invoicing, and Mobile Applications in Uzbekistan**.

---

## ⚡ Why UzKit?

Building applications for the Uzbekistan market requires dealing with local payment systems, phone formatting, invoice receipt generation, and legal document validations. **UzKit** provides a clean, battle-tested, 100% null-safe suite of utilities so you never have to reinvent the wheel.

* 💳 **Bank Card Recognition:** Instantly detects **Uzcard**, **Humo**, **Visa**, **Mastercard**, **UnionPay**, and **Mir** cards with auto-formatting, masking, and Luhn checksum validation.
* 📞 **Phone & Mobile Operator:** Formats `+998 (xx) xxx-xx-xx` and detects **Beeline**, **Ucell**, **Mobiuz**, **Uztelecom**, **Humans**, and **Perfectum** by network code.
* 💰 **Money to Words in Uzbek:** Converts numerical amounts up to trillions into written Uzbek words (*"bir million to'rt yuz ellik ming so'm"*) in both **Latin** and **Cyrillic** alphabets with tiyin support.
* 🆔 **Official Identity Verification:**
  * **JShShIR (PINFL):** 14-digit official State Tax Committee checksum verification.
  * **Passport & ID-Cards:** Formatting and pattern validation (`AA 1234567`).
  * **STIR (INN):** 9-digit Taxpayer Identification Number validation.

---

## 📦 Installation

Add `uz_kit` to your `pubspec.yaml` file:

```yaml
dependencies:
  uz_kit: ^0.1.0
```

Or install it via terminal:

```bash
flutter pub add uz_kit
```

Then import the library in your Dart code:

```dart
import 'package:uz_kit/uz_kit.dart';
```

---

## 📖 Comprehensive Usage Guide

### 1. 💳 Bank Cards (Uzcard, Humo, Visa, Mastercard)

```dart
// 1. Automatic Card Type Detection
final cardType = UzCardUtils.detectType('8600123456789012');
print(cardType.displayName); // "Uzcard"
print(cardType.isLocal);     // true
print(cardType.brandColor);  // 0xFF005696

// 2. Format with spaces
final formatted = UzCardUtils.format('9860123456789012');
print(formatted); // "9860 1234 5678 9012"

// 3. Privacy Masking
final masked = UzCardUtils.mask('8600123456789012');
print(masked); // "8600 **** **** 9012"

// 4. Expiry Date & Luhn Checksum
final isLuhnValid = UzCardUtils.isValidLuhn('8600123456789012');
final isExpiryValid = UzCardUtils.isExpiryValid('12/28');

// 5. Use in TextField Formatter
TextField(
  keyboardType: TextInputType.number,
  inputFormatters: [UzCardNumberFormatter()],
  decoration: InputDecoration(
    labelText: 'Card Number',
    hintText: '8600 0000 0000 0000',
  ),
);
```

#### Supported Card BIN Ranges:

| Card Type | BIN Prefixes | Domestic / International |
| :--- | :--- | :---: |
| 💳 **Uzcard** | `8600`, `5614` | Domestic (Uzbekistan) |
| 💳 **Humo** | `9860` | Domestic (Uzbekistan) |
| 💳 **Visa** | `4...` | International |
| 💳 **Mastercard** | `51-55`, `2221-2720` | International |
| 💳 **UnionPay** | `62...` | International |
| 💳 **Mir** | `2200-2204` | International |

---

### 2. 📞 Phone Numbers & Mobile Operators

```dart
// 1. Detect Mobile Operator
final operator = UzPhoneUtils.detectOperator('+998 90 123 45 67');
print(operator.displayName); // "Beeline"
print(operator.companyName); // "Unitel LLC"

// 2. Format & Normalization
final formatted = UzPhoneUtils.format('901234567');
print(formatted); // "+998 (90) 123-45-67"

final normalized = UzPhoneUtils.normalize('+998 (90) 123-45-67');
print(normalized); // "998901234567"

// 3. TextField Formatter
TextField(
  keyboardType: TextInputType.phone,
  inputFormatters: [UzPhoneInputFormatter()],
  decoration: InputDecoration(
    labelText: 'Phone Number',
    hintText: '+998 (90) 123-45-67',
  ),
);
```

#### Supported Mobile Operators:

| Operator | Network Codes | Company |
| :--- | :--- | :--- |
| 🟡 **Beeline** | `90`, `91` | Unitel LLC |
| 🟣 **Ucell** | `93`, `94`, `50` | Coscom LLC |
| 🔴 **Mobiuz** | `97`, `88` | UMS LLC |
| 🔵 **Uztelecom** | `99`, `95`, `77` | Uzbektelecom JSC |
| 🟡 **Humans** | `33` | Humans LLC |
| 🔴 **Perfectum** | `98` | RWC LLC |

---

### 3. 💰 Amount to Words in Uzbek (Kvitansiya & Cheklar)

Convert any numerical amount into grammatically correct written words in Uzbek:

```dart
// Latin Alphabet
final textLatin = UzMoneyToWords.convert(1450000);
print(textLatin); 
// Output: "bir million to'rt yuz ellik ming so'm"

// With Tiyin
final withTiyin = UzMoneyToWords.convert(2500000.50);
print(withTiyin); 
// Output: "ikki million besh yuz ming so'm 50 tiyin"

// Cyrillic Alphabet
final textCyrillic = UzMoneyToWords.convert(1450000, script: UzScript.cyrillic);
print(textCyrillic); 
// Output: "бир миллион тўрт юз эллик минг сўм"

// Currency Amount Formatter with Spaces
final formattedMoney = UzMoneyFormatter.format(1250000);
print(formattedMoney); // "1 250 000 so'm"
```

---

### 4. 🆔 JShShIR (PINFL) & Passport Verification

```dart
// 1. JShShIR (PINFL - 14 Digits) Checksum Validation
final isPinflValid = UzPinflValidator.isValid('30101901234567');
print(isPinflValid); // true/false based on official STC algorithm

// 2. Passport / ID-Card Formatting & Validation
final formattedPassport = UzPassportUtils.format('aa1234567');
print(formattedPassport); // "AA 1234567"

final isPassportValid = UzPassportUtils.isValid('AA 1234567');
print(isPassportValid); // true

// 3. STIR / INN (9 Digits) Validation
final isTinValid = UzTinValidator.isValid('123456789');
```

---

## 📱 Interactive Demo Application

Run the bundled Flutter demo app in the `example/` directory:

```bash
cd example
flutter run
```

---

## 🧪 Testing & Quality Assurance

All features are covered by comprehensive unit tests:

```bash
flutter test --coverage
```

Output:
```text
00:00 +10: All tests passed!
```

---

## 👨‍💻 Author & Contributions

Created with ❤️ by **[Ibrohim Qobilov](https://github.com/Ibrohim-Qobilov)**.

Feedback, feature suggestions, and pull requests are welcome!
* [GitHub Repository](https://github.com/Ibrohim-Qobilov/uz_kit)
* [Report an Issue](https://github.com/Ibrohim-Qobilov/uz_kit/issues)

---

## 📄 License

This package is open-sourced under the [MIT License](LICENSE).
