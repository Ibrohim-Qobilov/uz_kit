<p align="center">
  <img src="https://raw.githubusercontent.com/Ibrohim-Qobilov/uz_kit/main/assets/screenshots/preview.png" width="800" alt="UzKit Flutter Package Banner" />
</p>

<p align="center">
  <a href="README_UZ.md">🇺🇿 <b>O'zbekcha hujjat</b></a> &nbsp;•&nbsp;
  <a href="README.md">🇬🇧 <b>English documentation</b></a>
</p>

# 🇺🇿 UzKit — O'zbekiston uchun Flutter & Dart kutubxonasi

<p align="center">
  <a href="https://pub.dev/packages/uz_kit"><img src="https://img.shields.io/pub/v/uz_kit.svg?style=for-the-badge&logo=dart&color=0284C7" alt="Pub Version" /></a>
  <a href="https://pub.dev/packages/uz_kit/score"><img src="https://img.shields.io/pub/points/uz_kit?style=for-the-badge&color=10B981" alt="Pub Points" /></a>
  <a href="https://github.com/Ibrohim-Qobilov/uz_kit/stargazers"><img src="https://img.shields.io/github/stars/Ibrohim-Qobilov/uz_kit?style=for-the-badge&logo=github&color=F59E0B" alt="GitHub Stars" /></a>
  <a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/License-MIT-purple.svg?style=for-the-badge" alt="License: MIT" /></a>
  <a href="https://flutter.dev"><img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter" /></a>
</p>

O'zbekistondagi **fintech, bank ilovalari, e-commerce (onlayn do'konlar), hisob-fakturalar va mobil ilovalar** uchun yengil, null-safe Flutter / Dart kutubxonasi. Flutter'dan boshqa hech qanday tashqi bog'liqlik yo'q.

> ⭐ **UzKit vaqtingizni tejagan bo'lsa, [GitHub'da yulduzcha bosing](https://github.com/Ibrohim-Qobilov/uz_kit).** Shunda boshqa o'zbek dasturchilar ham uni osonroq topadi.

---

## ⚡ Nega UzKit?

O'zbekiston bozori uchun ilova yozganda har safar bir xil narsalarni qaytadan yozishga to'g'ri keladi: mahalliy kartalar, `+998` telefon formati, chekdagi summani so'z bilan yozish, JShShIR va pasport tekshiruvi. UzKit bularning barchasini bitta kichik, testlangan paketda beradi.

* 💳 **Bank kartalari:** **Uzcard**, **Humo**, **Visa**, **Mastercard**, **UnionPay** va **Mir** kartalarini aniqlaydi, formatlaydi (`8600 1234 ...`), yashiradi (`8600 **** **** 9012`) va Luhn algoritmi bilan tekshiradi.
* 📞 **Telefon va operatorlar:** `+998 (90) 123-45-67` ko'rinishida formatlaydi va kod bo'yicha **Beeline**, **Ucell**, **Mobiuz**, **Uztelecom (Uzmobile)**, **Humans** va **Perfectum**ni aniqlaydi.
* 💰 **Summani so'z bilan yozish:** trillionlargacha bo'lgan summani o'zbekcha yozadi (*"bir million to'rt yuz ellik ming so'm"*), **lotin** va **kirill** alifbosida, tiyin bilan.
* 🆔 **Rasmiy hujjatlar:**
  * **JShShIR (PINFL):** 14 xonali raqamni nazorat summasi bilan tekshirish.
  * **Pasport / ID-karta:** formatlash va seriya tekshiruvi (`AA 1234567`).
  * **STIR (INN):** 9 xonali soliq to'lovchi raqamini tekshirish.
* ⌨️ **7 ta tayyor `TextInputFormatter`:** foydalanuvchi yozayotgan paytda maydonni avtomatik formatlaydi.

---

## 📦 O'rnatish

```bash
flutter pub add uz_kit
```

Yoki `pubspec.yaml` fayliga qo'lda qo'shing:

```yaml
dependencies:
  uz_kit: ^0.1.2
```

Keyin import qiling:

```dart
import 'package:uz_kit/uz_kit.dart';
```

---

## 🚀 Ishlatish

### 1. 💳 Bank kartalari

```dart
// Karta turini aniqlash (Uzcard, Humo, Visa, Mastercard va h.k.)
final type = UzCardUtils.detectType('8600123456789012');
print(type.displayName); // "Uzcard"
print(type.isLocal);     // true (mahalliy karta)
final color = Color(type.brandColor); // brend rangi, 0xFF005696

// Formatlash va yashirish
print(UzCardUtils.format('9860123456789012')); // "9860 1234 5678 9012"
print(UzCardUtils.mask('8600123456789012'));   // "8600 **** **** 9012"

// Tekshirish
print(UzCardUtils.isValidLength('8600 1234 5678 9012')); // true
print(UzCardUtils.isValidLuhn('8600123456789012'));      // true (Luhn)

// Amal qilish muddati
print(UzCardUtils.formatExpiry('1228'));   // "12/28"
print(UzCardUtils.isExpiryValid('12/28')); // muddat tugaguncha true
```

| Karta | BIN prefikslari | Turi |
| :--- | :--- | :---: |
| 💳 **Uzcard** | `8600`, `5614` | Mahalliy |
| 💳 **Humo** | `9860` | Mahalliy |
| 💳 **Visa** | `4...` | Xalqaro |
| 💳 **Mastercard** | `51-55`, `2221-2720` | Xalqaro |
| 💳 **UnionPay** | `62...` | Xalqaro |
| 💳 **Mir** | `2200-2204` | Xalqaro |

---

### 2. 📞 Telefon raqamlari va operatorlar

```dart
// Operatorni aniqlash
final op = UzPhoneUtils.detectOperator('998901234567');
print(op.displayName); // "Beeline"
print(op.companyName); // "Unitel LLC"

// Formatlash
print(UzPhoneUtils.format('901234567')); // "+998 (90) 123-45-67"
print(UzPhoneUtils.format('998901234567', withCountryCode: false)); // "(90) 123-45-67"

// Bitta standart ko'rinishga keltirish (12 raqam)
print(UzPhoneUtils.normalize('+998 (90) 123-45-67')); // "998901234567"

// Raqam to'g'riligini tekshirish
print(UzPhoneUtils.isValid('+998 93 123 45 67')); // true (Ucell)
print(UzPhoneUtils.isValid('+998 92 123 45 67')); // false (bunday kod yo'q)
```

| Operator | Kodlar | Kompaniya |
| :--- | :--- | :--- |
| 🟡 **Beeline** | `90`, `91` | Unitel LLC |
| 🟣 **Ucell** | `93`, `94`, `50` | Coscom LLC |
| 🔴 **Mobiuz** | `97`, `88` | UMS LLC |
| 🔵 **Uztelecom** | `99`, `95`, `77` | Uzbektelecom JSC |
| 🟡 **Humans** | `33` | Humans LLC |
| 🔴 **Perfectum** | `98` | RWC LLC |

---

### 3. 💰 Summani so'z bilan yozish

Hisob-faktura, shartnoma, chek va kvitansiyalar uchun:

```dart
// Lotin alifbosida
print(UzMoneyToWords.convert(1450000));
// "bir million to'rt yuz ellik ming so'm"

// Kirill alifbosida
print(UzMoneyToWords.convert(1450000, script: UzScript.cyrillic));
// "бир миллион тўрт юз эллик минг сўм"

// Tiyin bilan
print(UzMoneyToWords.convert(2500000.50));
// "ikki million besh yuz ming so'm 50 tiyin"

// Valyuta nomisiz
print(UzMoneyToWords.convert(125, withCurrency: false));
// "bir yuz yigirma besh"

// Summani xonalarga ajratib formatlash
print(UzMoneyFormatter.format(1250000)); // "1 250 000 so'm"
```

---

### 4. 🆔 JShShIR, pasport va STIR (INN)

```dart
// JShShIR (PINFL): 14 xona, nazorat summasi bilan
print(UzPinflValidator.isValid('30101901234569')); // true
print(UzPinflValidator.isValid('30101901234567')); // false (nazorat raqami noto'g'ri)

// Pasport / ID-karta
print(UzPassportUtils.format('aa1234567'));   // "AA 1234567"
print(UzPassportUtils.isValid('AA 1234567')); // true

// STIR (INN): 9 xona
print(UzTinValidator.isValid('123456789')); // true
```

---

## ⌨️ TextField uchun formatterlar

Foydalanuvchi yozayotganda maydonni avtomatik formatlaydi:

```dart
TextField(
  keyboardType: TextInputType.number,
  inputFormatters: [UzCardNumberFormatter()],
  decoration: const InputDecoration(
    labelText: 'Karta raqami',
    hintText: '8600 0000 0000 0000',
  ),
)

TextField(
  keyboardType: TextInputType.phone,
  inputFormatters: [UzPhoneInputFormatter()],
  decoration: const InputDecoration(
    labelText: 'Telefon raqam',
    hintText: '+998 (90) 123-45-67',
  ),
)
```

| Formatter | Foydalanuvchi yozadi | Maydonda ko'rinadi |
| :--- | :--- | :--- |
| `UzCardNumberFormatter()` | `8600123456789012` | `8600 1234 5678 9012` |
| `UzCardExpiryFormatter()` | `1228` | `12/28` |
| `UzPhoneInputFormatter()` | `901234567` | `+998 (90) 123-45-67` |
| `UzMoneyInputFormatter()` | `1500000` | `1 500 000` |
| `UzPassportInputFormatter()` | `aa1234567` | `AA 1234567` |
| `UzPinflInputFormatter()` | raqamlar | faqat 14 ta raqam |
| `UzTinInputFormatter()` | raqamlar | faqat 9 ta raqam |

---

## 📱 Demo ilova

`example/` papkasida barcha imkoniyatlarni ko'rsatadigan Flutter ilova bor:

```bash
cd example
flutter run
```

---

## 🤝 Hissa qo'shish

Xato topsangiz yoki yangi g'oyangiz bo'lsa, [issue oching](https://github.com/Ibrohim-Qobilov/uz_kit/issues) yoki pull request yuboring. Yangi operator kodi yoki karta BIN'i paydo bo'lsa, manbasi bilan issue yozing, tezda qo'shiladi.

⭐ **UzKit foydali bo'ldimi? [GitHub'da yulduzcha bosing](https://github.com/Ibrohim-Qobilov/uz_kit)** va [pub.dev'da](https://pub.dev/packages/uz_kit) 👍 bosing.

---

## 📄 Litsenziya

[MIT litsenziyasi](LICENSE) asosida erkin tarqatiladi.
Muallif: **Ibrohim Qobilov** ([@Ibrohim-Qobilov](https://github.com/Ibrohim-Qobilov))
