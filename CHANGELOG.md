# Changelog

All notable changes to the `uz_kit` package will be documented in this file.

## [0.1.1] - 2026-09-02

### Added
* Add Uzbek documentation (`README_UZ.md`) and language switcher buttons.
* Improve documentation and examples.

## [0.1.0] - 2026-09-02

### Added
* 💳 **Card Utilities:**
  * Auto-detection for `Uzcard`, `Humo`, `Visa`, `Mastercard`, `UnionPay`, and `Mir`.
  * `UzCardNumberFormatter` for automatic `xxxx xxxx xxxx xxxx` spacing in TextFields.
  * `UzCardExpiryFormatter` for `MM/YY` inputs with past-date verification.
  * Card masking utility (e.g., `8600 **** **** 1234`).
  * Luhn checksum (Mod 10) algorithm validation.
* 📞 **Phone & Operator Utilities:**
  * Auto-detection for Uzbekistan mobile operators (`Beeline`, `Ucell`, `Mobiuz`, `Uztelecom`, `Humans`, `Perfectum`).
  * `UzPhoneInputFormatter` for `+998 (xx) xxx-xx-xx` format.
  * Normalization to standard 12-digit format `998901234567`.
* 💰 **Money & Currency:**
  * `UzMoneyToWords`: Converts numerical amounts up to trillions into written words in Uzbek Latin and Cyrillic with tiyin support.
  * `UzMoneyFormatter` and `UzMoneyInputFormatter` for formatting currency with space separators.
* 🆔 **Identity & Validation:**
  * `UzPinflValidator` and `UzPinflInputFormatter` for 14-digit JShShIR with official checksum validation.
  * `UzPassportUtils` and `UzPassportInputFormatter` for `AA 1234567` series formatting and validation.
  * `UzTinValidator` for 9-digit STIR (INN) validation.
* 📱 **Example Application:**
  * Full interactive demo showcasing all features with Material 3 light and dark themes.
