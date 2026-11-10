<p align="center">
  <img src="https://raw.githubusercontent.com/Ibrohim-Qobilov/uz_kit/main/assets/screenshots/preview.png" width="800" alt="UzKit Flutter Package Banner" />
</p>

<p align="center">
  <a href="https://github.com/Ibrohim-Qobilov/uz_kit/blob/main/README_UZ.md">
    <img src="https://img.shields.io/badge/🇺🇿_O'zbekcha-Hujjatlar_va_Qo'llanma-0284C7?style=for-the-badge&logo=readme&logoColor=white" alt="O'zbekcha Hujjatlar" />
  </a>
  <a href="https://github.com/Ibrohim-Qobilov/uz_kit/blob/main/README.md">
    <img src="https://img.shields.io/badge/🇬🇧_English-Documentation-02569B?style=for-the-badge" alt="English Documentation" />
  </a>
</p>

<details>
<summary>🇺🇿 <b>O'zbekcha tezkor qo'llanma (bosing / click to expand)</b></summary>
<br />

### 🇺🇿 UzKit — O'zbekcha tezkor qo'llanma

O'zbekistondagi **fintech, bank ilovalari, e-commerce, hisob-fakturalar va mobil ilovalar** uchun Flutter & Dart kutubxonasi.

```dart
import 'package:uz_kit/uz_kit.dart';

// 1. Karta turini aniqlash (Uzcard, Humo, Visa...)
final card = UzCardUtils.detectType('8600123456789012');
print(card.displayName); // "Uzcard"

// 2. Telefon raqamni formatlash va operatorni aniqlash
print(UzPhoneUtils.format('998901234567')); // "+998 (90) 123-45-67"
print(UzPhoneUtils.detectOperator('998901234567').displayName); // "Beeline"

// 3. So'm summasini so'z bilan yozish (lotin / kirill)
print(UzMoneyToWords.convert(1450000));
// "bir million to'rt yuz ellik ming so'm"

// 4. JShShIR (PINFL) va pasportni tekshirish
print(UzPinflValidator.isValid('30101901234569')); // true
print(UzPassportUtils.isValid('AA 1234567'));      // true
```

To'liq o'zbekcha hujjat: 👉 [README_UZ.md](https://github.com/Ibrohim-Qobilov/uz_kit/blob/main/README_UZ.md)

---
</details>

# 🇺🇿 UzKit — The Flutter & Dart Toolkit for Uzbekistan

<p align="center">
  <a href="https://pub.dev/packages/uz_kit"><img src="https://img.shields.io/pub/v/uz_kit.svg?style=for-the-badge&logo=dart&color=0284C7" alt="Pub Version" /></a>
  <a href="https://pub.dev/packages/uz_kit/score"><img src="https://img.shields.io/pub/points/uz_kit?style=for-the-badge&color=10B981" alt="Pub Points" /></a>
  <a href="https://github.com/Ibrohim-Qobilov/uz_kit/stargazers"><img src="https://img.shields.io/github/stars/Ibrohim-Qobilov/uz_kit?style=for-the-badge&logo=github&color=F59E0B" alt="GitHub Stars" /></a>
  <a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/License-MIT-purple.svg?style=for-the-badge" alt="License: MIT" /></a>
  <a href="https://flutter.dev"><img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter" /></a>
</p>

A lightweight, null-safe Flutter and Dart toolkit for **fintech, banking, e-commerce, invoicing and mobile apps in Uzbekistan**. No third-party dependencies, only Flutter itself.

> ⭐ **If UzKit saves you time, please [star the repo on GitHub](https://github.com/Ibrohim-Qobilov/uz_kit).** It helps other Uzbek developers find it.

---

## ⚡ Why UzKit?

Apps for the Uzbekistan market keep re-implementing the same things: local card systems, `+998` phone formatting, amounts written out in words on receipts, and PINFL / passport checks. UzKit puts them in one small, tested package.

* 💳 **Bank cards:** detects **Uzcard**, **Humo**, **Visa**, **Mastercard**, **UnionPay** and **Mir**, formats and masks card numbers, and validates them with the Luhn checksum.
* 📞 **Phones and operators:** formats `+998 (xx) xxx-xx-xx` and detects **Beeline**, **Ucell**, **Mobiuz**, **Uztelecom**, **Humans** and **Perfectum** by network code.
* 💰 **Amounts in words:** writes amounts up to trillions in Uzbek (*"bir million to'rt yuz ellik ming so'm"*), in **Latin** or **Cyrillic**, with tiyin.
* 🆔 **Identity documents:**
  * **JShShIR (PINFL):** 14-digit checksum validation.
  * **Passport / ID card:** formatting and pattern validation (`AA 1234567`).
  * **STIR (INN):** 9-digit taxpayer number validation.
* ⌨️ **Seven ready-made `TextInputFormatter`s** that format input while the user types.

---

## 📦 Installation

```bash
flutter pub add uz_kit
```

Or add it to your `pubspec.yaml` manually:

```yaml
dependencies:
  uz_kit: ^0.1.2
```

Then import it:

```dart
import 'package:uz_kit/uz_kit.dart';
```

---

## 📖 Usage

### 1. 💳 Bank cards (Uzcard, Humo, Visa, Mastercard)

```dart
// Card type detection
final cardType = UzCardUtils.detectType('8600123456789012');
print(cardType.displayName); // "Uzcard"
print(cardType.isLocal);     // true
final color = Color(cardType.brandColor); // brand color, 0xFF005696

// Formatting and masking
print(UzCardUtils.format('9860123456789012')); // "9860 1234 5678 9012"
print(UzCardUtils.mask('8600123456789012'));   // "8600 **** **** 9012"

// Validation
print(UzCardUtils.isValidLength('8600 1234 5678 9012')); // true
print(UzCardUtils.isValidLuhn('8600123456789012'));      // true

// Expiry date
print(UzCardUtils.formatExpiry('1228'));  // "12/28"
print(UzCardUtils.isExpiryValid('12/28')); // true until the card expires

// In a TextField
TextField(
  keyboardType: TextInputType.number,
  inputFormatters: [UzCardNumberFormatter()],
  decoration: const InputDecoration(
    labelText: 'Card number',
    hintText: '8600 0000 0000 0000',
  ),
);
```

#### Supported card BIN ranges

| Card type | BIN prefixes | Domestic / International |
| :--- | :--- | :---: |
| 💳 **Uzcard** | `8600`, `5614` | Domestic (Uzbekistan) |
| 💳 **Humo** | `9860` | Domestic (Uzbekistan) |
| 💳 **Visa** | `4...` | International |
| 💳 **Mastercard** | `51-55`, `2221-2720` | International |
| 💳 **UnionPay** | `62...` | International |
| 💳 **Mir** | `2200-2204` | International |

---

### 2. 📞 Phone numbers and mobile operators

```dart
// Operator detection
final operator = UzPhoneUtils.detectOperator('+998 90 123 45 67');
print(operator.displayName); // "Beeline"
print(operator.companyName); // "Unitel LLC"

// Formatting and normalization
print(UzPhoneUtils.format('901234567')); // "+998 (90) 123-45-67"
print(UzPhoneUtils.format('998901234567', withCountryCode: false)); // "(90) 123-45-67"
print(UzPhoneUtils.normalize('+998 (90) 123-45-67')); // "998901234567"

// Validation (12 digits with 998 and a known operator code)
print(UzPhoneUtils.isValid('+998 93 123 45 67')); // true (Ucell)
print(UzPhoneUtils.isValid('+998 92 123 45 67')); // false (unknown code)

// In a TextField
TextField(
  keyboardType: TextInputType.phone,
  inputFormatters: [UzPhoneInputFormatter()],
  decoration: const InputDecoration(
    labelText: 'Phone number',
    hintText: '+998 (90) 123-45-67',
  ),
);
```

#### Supported mobile operators

| Operator | Network codes | Company |
| :--- | :--- | :--- |
| 🟡 **Beeline** | `90`, `91` | Unitel LLC |
| 🟣 **Ucell** | `93`, `94`, `50` | Coscom LLC |
| 🔴 **Mobiuz** | `97`, `88` | UMS LLC |
| 🔵 **Uztelecom** | `99`, `95`, `77` | Uzbektelecom JSC |
| 🟡 **Humans** | `33` | Humans LLC |
| 🔴 **Perfectum** | `98` | RWC LLC |

---

### 3. 💰 Amounts in words (receipts and invoices)

```dart
// Latin script
print(UzMoneyToWords.convert(1450000));
// "bir million to'rt yuz ellik ming so'm"

// With tiyin
print(UzMoneyToWords.convert(2500000.50));
// "ikki million besh yuz ming so'm 50 tiyin"

// Cyrillic script
print(UzMoneyToWords.convert(1450000, script: UzScript.cyrillic));
// "бир миллион тўрт юз эллик минг сўм"

// Without the currency name
print(UzMoneyToWords.convert(125, withCurrency: false));
// "bir yuz yigirma besh"

// Amount formatting with thousand separators
print(UzMoneyFormatter.format(1250000)); // "1 250 000 so'm"
print(UzMoneyFormatter.format(99.9, symbol: r'$', symbolAtEnd: false, decimalDigits: 2));
// "$ 99.90"
```

---

### 4. 🆔 JShShIR (PINFL), passport and STIR (INN)

```dart
// JShShIR (PINFL), 14 digits with checksum
print(UzPinflValidator.isValid('30101901234569')); // true
print(UzPinflValidator.isValid('30101901234567')); // false (wrong check digit)

// Passport / ID card
print(UzPassportUtils.format('aa1234567'));   // "AA 1234567"
print(UzPassportUtils.isValid('AA 1234567')); // true

// STIR / INN, 9 digits
print(UzTinValidator.isValid('123456789')); // true
```

---

## ⌨️ Input formatters

Drop any of these into `TextField.inputFormatters`:

| Formatter | User types | Field shows |
| :--- | :--- | :--- |
| `UzCardNumberFormatter()` | `8600123456789012` | `8600 1234 5678 9012` |
| `UzCardExpiryFormatter()` | `1228` | `12/28` |
| `UzPhoneInputFormatter()` | `901234567` | `+998 (90) 123-45-67` |
| `UzMoneyInputFormatter()` | `1500000` | `1 500 000` |
| `UzPassportInputFormatter()` | `aa1234567` | `AA 1234567` |
| `UzPinflInputFormatter()` | digits | first 14 digits only |
| `UzTinInputFormatter()` | digits | first 9 digits only |

---

## 📱 Demo app

The `example/` directory has a Flutter demo with every feature:

```bash
cd example
flutter run
```

---

## 🧪 Tests

Every example in this README is covered by a unit test (`test/readme_examples_test.dart`), so the docs stay in sync with the code:

```bash
flutter test
```

---

## 🤝 Contributing

Bug reports, feature ideas and pull requests are welcome:

* [Open an issue](https://github.com/Ibrohim-Qobilov/uz_kit/issues)
* [GitHub repository](https://github.com/Ibrohim-Qobilov/uz_kit)

If a new operator code or card BIN appears in Uzbekistan, an issue or PR with the source is the fastest way to get it added.

⭐ **Found UzKit useful? [Give it a star on GitHub](https://github.com/Ibrohim-Qobilov/uz_kit)** and a 👍 on [pub.dev](https://pub.dev/packages/uz_kit).

---

## 👨‍💻 Author

Created by **[Ibrohim Qobilov](https://github.com/Ibrohim-Qobilov)**.

## 📄 License

Released under the [MIT License](LICENSE).





