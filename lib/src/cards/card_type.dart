/// Supported card types in Uzbekistan and international payment systems.
enum UzCardType {
  /// Uzcard (local payment system in Uzbekistan, BIN: 8600, 5614)
  uzcard(
    displayName: 'Uzcard',
    brandColor: 0xFF005696,
    isLocal: true,
  ),

  /// Humo (local payment system in Uzbekistan, BIN: 9860)
  humo(
    displayName: 'Humo',
    brandColor: 0xFFF7931E,
    isLocal: true,
  ),

  /// Visa international payment system (BIN: 4...)
  visa(
    displayName: 'Visa',
    brandColor: 0xFF1A1F71,
    isLocal: false,
  ),

  /// Mastercard international payment system (BIN: 51-55, 2221-2720)
  mastercard(
    displayName: 'Mastercard',
    brandColor: 0xFFEB001B,
    isLocal: false,
  ),

  /// UnionPay international payment system (BIN: 62...)
  unionpay(
    displayName: 'UnionPay',
    brandColor: 0xFF007A87,
    isLocal: false,
  ),

  /// Mir payment system (BIN: 2200-2204)
  mir(
    displayName: 'Mir',
    brandColor: 0xFF0F7545,
    isLocal: false,
  ),

  /// Unknown or unsupported card type
  unknown(
    displayName: 'Unknown',
    brandColor: 0xFF757575,
    isLocal: false,
  );

  const UzCardType({
    required this.displayName,
    required this.brandColor,
    required this.isLocal,
  });

  /// Human-readable display name.
  final String displayName;

  /// Primary brand color hex integer (0xAARRGGBB).
  final int brandColor;

  /// Whether this is a domestic Uzbekistan card (Uzcard or Humo).
  final bool isLocal;
}
