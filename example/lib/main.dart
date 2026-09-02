import 'package:flutter/material.dart';
import 'package:uz_kit/uz_kit.dart';

void main() {
  runApp(const UzKitExampleApp());
}

class UzKitExampleApp extends StatelessWidget {
  const UzKitExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UzKit Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF0284C7),
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: const Color(0xFF38BDF8),
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.system,
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _cardController = TextEditingController();
  final _expiryController = TextEditingController();
  final _phoneController = TextEditingController();
  final _moneyController = TextEditingController(text: '1450000');
  final _pinflController = TextEditingController();
  final _passportController = TextEditingController();

  UzCardType _cardType = UzCardType.unknown;
  UzMobileOperator _operator = UzMobileOperator.unknown;

  @override
  void initState() {
    super.initState();
    _cardController.addListener(() {
      setState(() {
        _cardType = UzCardUtils.detectType(_cardController.text);
      });
    });
    _phoneController.addListener(() {
      setState(() {
        _operator = UzPhoneUtils.detectOperator(_phoneController.text);
      });
    });
    _moneyController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _cardController.dispose();
    _expiryController.dispose();
    _phoneController.dispose();
    _moneyController.dispose();
    _pinflController.dispose();
    _passportController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final amount = double.tryParse(_moneyController.text.replaceAll(RegExp(r'\D'), '')) ?? 0;
    final wordsLatin = UzMoneyToWords.convert(amount, script: UzScript.latin);
    final wordsCyrillic = UzMoneyToWords.convert(amount, script: UzScript.cyrillic);

    return Scaffold(
      appBar: AppBar(
        title: const Text('🇺🇿 UzKit — Flutter Demo'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Section 1: Bank Card
          _buildSectionHeader('1. Bank Kartasi (Uzcard / Humo / Visa)'),
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    controller: _cardController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [UzCardNumberFormatter()],
                    decoration: InputDecoration(
                      labelText: 'Karta raqami',
                      hintText: '8600 0000 0000 0000',
                      prefixIcon: const Icon(Icons.credit_card),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Chip(
                          label: Text(
                            _cardType.displayName,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          backgroundColor: Color(_cardType.brandColor).withValues(alpha: 0.15),
                        ),
                      ),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _expiryController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [UzCardExpiryFormatter()],
                          decoration: const InputDecoration(
                            labelText: 'Amal qilish muddati',
                            hintText: 'MM/YY',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Niqoblangan:\n${UzCardUtils.mask(_cardController.text)}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Section 2: Phone & Operator
          _buildSectionHeader('2. Telefon va Mobil Operator'),
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                inputFormatters: [UzPhoneInputFormatter()],
                decoration: InputDecoration(
                  labelText: 'Telefon raqam',
                  hintText: '+998 (90) 123-45-67',
                  prefixIcon: const Icon(Icons.phone),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Chip(
                      label: Text(
                        _operator.displayName,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      backgroundColor: Color(_operator.brandColor).withValues(alpha: 0.2),
                    ),
                  ),
                  border: const OutlineInputBorder(),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Section 3: Money to Words
          _buildSectionHeader('3. Summani So\'z bilan Yozish (Kvitansiyalar)'),
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _moneyController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [UzMoneyInputFormatter()],
                    decoration: const InputDecoration(
                      labelText: 'Summa (so\'m)',
                      prefixIcon: Icon(Icons.payments),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text('Lotin alifbosida:', style: TextStyle(fontWeight: FontWeight.bold)),
                  SelectableText(wordsLatin, style: const TextStyle(color: Colors.green)),
                  const SizedBox(height: 8),
                  const Text('Кирилл алифбосида:', style: TextStyle(fontWeight: FontWeight.bold)),
                  SelectableText(wordsCyrillic, style: const TextStyle(color: Colors.blue)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Section 4: Passport & PINFL
          _buildSectionHeader('4. Pasport & JShShIR (PINFL)'),
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    controller: _passportController,
                    inputFormatters: [UzPassportInputFormatter()],
                    decoration: InputDecoration(
                      labelText: 'Pasport / ID karta',
                      hintText: 'AA 1234567',
                      suffixIcon: UzPassportUtils.isValid(_passportController.text)
                          ? const Icon(Icons.check_circle, color: Colors.green)
                          : null,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _pinflController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [UzPinflInputFormatter()],
                    decoration: InputDecoration(
                      labelText: 'JShShIR (14 xonali PINFL)',
                      hintText: '30101901234567',
                      suffixIcon: UzPinflValidator.isValid(_pinflController.text)
                          ? const Icon(Icons.check_circle, color: Colors.green)
                          : null,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 4),
      child: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}
