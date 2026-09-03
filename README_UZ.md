<p align="center">
  <img src="https://raw.githubusercontent.com/Ibrohim-Qobilov/uz_kit/main/assets/screenshots/preview.png" width="800" alt="UzKit Flutter Package Banner" />
</p>

<p align="center">
  <a href="README_UZ.md">🇺🇿 <b>O'zbekcha Hujjatlar</b></a> &nbsp;•&nbsp;
  <a href="README.md">🇬🇧 <b>English Documentation</b></a>
</p>

# 🇺🇿 UzKit — O'zbekiston uchun Eng Mukammal Flutter & Dart Kutubxonasi

<p align="center">
  <a href="https://pub.dev/packages/uz_kit"><img src="https://img.shields.io/pub/v/uz_kit.svg?style=for-the-badge&logo=dart&color=0284C7" alt="Pub Version" /></a>
  <a href="https://pub.dev/packages/uz_kit/score"><img src="https://img.shields.io/pub/points/uz_kit?style=for-the-badge&color=10B981" alt="Pub Points" /></a>
  <a href="https://github.com/Ibrohim-Qobilov/uz_kit/stargazers"><img src="https://img.shields.io/github/stars/Ibrohim-Qobilov/uz_kit?style=for-the-badge&logo=github&color=F59E0B" alt="GitHub Stars" /></a>
  <a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/License-MIT-purple.svg?style=for-the-badge" alt="License: MIT" /></a>
  <a href="https://flutter.dev"><img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter" /></a>
</p>

---

O'zbekistondagi **Fintech, Bank ilovalari, E-commerce (onlayn do'konlar), hisob-fakturalar va mobil ilovalar** uchun maxsus yaratilgan eng to'liq va tezkor Flutter / Dart kutubxonasi.

---

## ⚡ Nega Aynan UzKit?

O'zbekiston bozori uchun ilova yaratishda mahalliy to'lov tizimlari, telefon raqam formatlari, hisob-faktura cheklaridagi so'zlarni yozish va rasmiy hujjatlarni tekshirish talab etiladi. **UzKit** barcha bu ehtiyojlarni bitta toza, 100% testlangan va null-safe to'plamda taqdim etadi.

* 💳 **Bank Kartalarini Aniqlash:** **Uzcard**, **Humo**, **Visa**, **Mastercard**, **UnionPay** va **Mir** kartalarini bir zumda aniqlaydi, chiroyli formatlaydi (`8600 1234 ...`), yashiradi (`8600 **** **** 3456`) va Luhn algoritmi bo'yicha haqiqiyligini tekshiradi.
* 📞 **Telefon & Uyali Aloqa Operatorlari:** `+998 (90) 123-45-67` formatlaydi va prefiks bo'yicha **Beeline**, **Ucell**, **Mobiuz**, **Uztelecom (Uzmobile)**, **Humans** va **Perfectum** operatorlarini aniqlab beradi.
* 💰 **Raqamli Pulni So'zga Aylantirish:** Trillionlargacha bo'lgan summalarni o'zbek tilida so'z bilan yozib beradi (*"bir million to'rt yuz ellik ming so'm"*). **Lotin** va **Kirill** alifbolari hamda tiyinlar to'liq qo'llab-quvvatlanadi.
* 🆔 **Rasmiy Hujjatlar Validatsiyasi:**
  * **JShShIR (PINFL):** Davlat Soliq Qo'mitasining 14 xonali rasmiy nazorat summasi algoritmi bilan tekshirish.
  * **Pasport & ID-karta:** Formatlash va seriya tekshiruvi (`AA 1234567`).
  * **STIR (INN):** 9 xonali Soliq to'lovchining identifikatsiya raqami tekshiruvi.

---

## 📦 O'rnatish

Loyihangizdagi `pubspec.yaml` fayliga qo'shing:

```yaml
dependencies:
  uz_kit: ^0.1.0
```

Yoki terminal orqali o'rnating:

```bash
flutter pub add uz_kit
```

Dart kodingizda import qiling:

```dart
import 'package:uz_kit/uz_kit.dart';
```

---

## 🚀 Ishlatish Bo'yicha Qo'llanma

### 1. 💳 Bank Kartalari bilan Ishlash

```dart
// Karta turini aniqlash (Uzcard, Humo, Visa, Mastercard va h.k.)
UzCardType type = UzCardUtils.getCardType('8600123456789012');
print(type.name); // Uzcard
print(type.isLocal); // true

// Karta raqamini probellar bilan chiroyli formatlash
String formatted = UzCardUtils.formatCardNumber('9860123456789012');
print(formatted); // "9860 1234 5678 9012"

// Xavfsiz ko'rinishda yashirish (Masking)
String masked = UzCardUtils.maskCardNumber('8600123456789012');
print(masked); // "8600 **** **** 9012"

// Luhn algoritmi bo'yicha karta raqami haqiqiyligini tekshirish
bool isValid = UzCardUtils.isValidCardNumber('8600123456789012');
print(isValid); // true
```

---

### 2. 📞 Telefon Raqamlari & Aloqa Operatorlari

```dart
// Formatlash (+998 (90) 123-45-67)
String phone = UzPhoneUtils.formatPhoneNumber('998901234567');
print(phone); // "+998 (90) 123-45-67"

// Operatorni aniqlash
UzOperator op = UzPhoneUtils.getOperator('998901234567');
print(op.name); // "Beeline"
print(op.brandColor); // Beeline brend rangi (0xFFFFD600)

// Raqam to'g'riligini tekshirish
bool isValid = UzPhoneUtils.isValidUzPhone('+998 93 123 45 67');
print(isValid); // true (Ucell)
```

---

### 3. 💰 So'm Summasini So'z Bilan Yozish (Money to Words)

Hisob-faktura, shartnoma, chek va kvitansiyalar uchun ayni muddao!

```dart
// Lotin alifbosida
String wordsLat = UzMoneyWords.toWords(1450000);
print(wordsLat); 
// "bir million to'rt yuz ellik ming so'm"

// Kirill alifbosida
String wordsCyr = UzMoneyWords.toWords(2500000, script: UzScript.cyrillic);
print(wordsCyr); 
// "икки миллион беш юз минг сўм"

// Tiyinlar bilan birga
String withTiyin = UzMoneyWords.toWords(15000.50, includeCurrency: true);
print(withTiyin); 
// "o'n besh ming so'm 50 tiyin"

// Pul formatlash (1 450 000 so'm)
String formattedMoney = UzMoneyWords.formatMoney(1450000);
print(formattedMoney); // "1 450 000 so'm"
```

---

### 4. 🆔 JShShIR, Pasport va STIR (INN) Tekshiruvi

```dart
// 14 xonali JShShIR (PINFL) rasmiy nazorat summasi bo'yicha tekshirish
bool isPinflValid = UzIdentityUtils.isValidPinfl('32109876543210');

// Pasport / ID-karta formati
bool isPassportValid = UzIdentityUtils.isValidPassport('AA1234567');
String formattedPassport = UzIdentityUtils.formatPassport('aa1234567'); // "AA 1234567"

// 9 xonali STIR (INN) tekshiruvi
bool isInnValid = UzIdentityUtils.isValidInn('123456789');
```

---

## 🎨 UI uchun Qulay TextField Formatterlar

Foydalanuvchi kiritayotganda avtomatik bo'shliqlar qo'yib boruvchi tayyor TextInputFormatter'lar:

```dart
TextField(
  inputFormatters: [UzCardNumberFormatter()],
  decoration: const InputDecoration(
    hintText: '8600 0000 0000 0000',
    labelText: 'Karta raqami',
  ),
)

TextField(
  inputFormatters: [UzPhoneNumberFormatter()],
  decoration: const InputDecoration(
    hintText: '+998 (90) 123-45-67',
    labelText: 'Telefon raqam',
  ),
)
```

---

## 📄 Litsenziya

Ushbu loyiha [MIT Litsenziyasi](LICENSE) asosida erkin tarqatiladi.
Muallif: **Ibrohim Qobilov** ([@Ibrohim-Qobilov](https://github.com/Ibrohim-Qobilov))
