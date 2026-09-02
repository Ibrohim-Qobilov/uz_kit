/// Supported mobile operators in Uzbekistan.
enum UzMobileOperator {
  /// Beeline Uzbekistan (Unitel LLC, Prefixes: 90, 91)
  beeline(
    displayName: 'Beeline',
    companyName: 'Unitel LLC',
    prefixes: ['90', '91'],
    brandColor: 0xFFFFD200,
  ),

  /// Ucell (Coscom LLC, Prefixes: 93, 94, 50)
  ucell(
    displayName: 'Ucell',
    companyName: 'Coscom LLC',
    prefixes: ['93', '94', '50'],
    brandColor: 0xFF652D90,
  ),

  /// Mobiuz (Universal Mobile Systems LLC, Prefixes: 97, 88)
  mobiuz(
    displayName: 'Mobiuz',
    companyName: 'UMS LLC',
    prefixes: ['97', '88'],
    brandColor: 0xFFE30613,
  ),

  /// Uztelecom / UzMobile (Uzbektelecom JSC, Prefixes: 99, 95, 77)
  uztelecom(
    displayName: 'Uztelecom',
    companyName: 'Uzbektelecom JSC',
    prefixes: ['99', '95', '77'],
    brandColor: 0xFF0066B3,
  ),

  /// Humans (Humans Companies LLC, Prefix: 33)
  humans(
    displayName: 'Humans',
    companyName: 'Humans LLC',
    prefixes: ['33'],
    brandColor: 0xFFFEE600,
  ),

  /// Perfectum Mobile (Rubicon Wireless Communication, Prefix: 98)
  perfectum(
    displayName: 'Perfectum',
    companyName: 'RWC LLC',
    prefixes: ['98'],
    brandColor: 0xFFED1C24,
  ),

  /// Unknown or unsupported mobile operator
  unknown(
    displayName: 'Unknown',
    companyName: 'Unknown',
    prefixes: [],
    brandColor: 0xFF757575,
  );

  const UzMobileOperator({
    required this.displayName,
    required this.companyName,
    required this.prefixes,
    required this.brandColor,
  });

  /// Operator commercial display name.
  final String displayName;

  /// Official legal company name.
  final String companyName;

  /// List of assigned mobile network code prefixes.
  final List<String> prefixes;

  /// Brand primary color hex integer.
  final int brandColor;
}
