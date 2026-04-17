import 'package:flutter/material.dart';
import '../main.dart';

class AreaConverterScreen extends StatefulWidget {
  const AreaConverterScreen({super.key});
  @override
  State<AreaConverterScreen> createState() => _AreaConverterScreenState();
}
class _AreaConverterScreenState extends State<AreaConverterScreen> {
  final TextEditingController _inputController = TextEditingController(text: '1');
  String _fromUnit = 'Square Meters';
  String _toUnit = 'Square Feet';
  double _result = 10.7639;
  final Map<String, double> _unitFactors = {
    'Square Millimeters': 0.000001,
    'Square Centimeters': 0.0001,
    'Square Meters': 1.0,
    'Square Kilometers': 1000000.0,
    'Square Inches': 0.00064516,
    'Square Feet': 0.092903,
    'Acres': 4046.86,
    'Hectares': 10000.0,
  };
  @override
  void initState() {
    super.initState();
    _inputController.addListener(_convert);
  }
  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }
  void _convert() {
    final input = double.tryParse(_inputController.text.replaceAll(',', '')) ?? 0;
    final fromFactor = _unitFactors[_fromUnit] ?? 1.0;
    final toFactor = _unitFactors[_toUnit] ?? 1.0;
    setState(() {
      _result = (input * fromFactor) / toFactor;
    });
  }
  void _swapUnits() {
    setState(() {
      final temp = _fromUnit;
      _fromUnit = _toUnit;
      _toUnit = temp;
      _convert();
    });
  }
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = const Color(0xFF145DA2);
    final bgColor = isDarkMode ? const Color(0xFF1A1C1E) : const Color(0xFFF5F7F9);
    final cardColor = isDarkMode ? const Color(0xFF2C2F31) : Colors.white;
    final textColor = isDarkMode ? Colors.white : const Color(0xFF2C2F31);
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: textColor, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Area Converter',
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w900,
            fontSize: 18,
            letterSpacing: -0.5,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              isDarkMode ? Icons.light_mode : Icons.dark_mode,
              color: textColor,
            ),
            onPressed: () {
              themeNotifier.value = isDarkMode ? ThemeMode.light : ThemeMode.dark;
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(textColor),
            const SizedBox(height: 32),
            _buildConverterCard(cardColor, textColor, primaryColor, isDarkMode),
            const SizedBox(height: 32),
            _buildQuickReferences(cardColor, textColor),
          ],
        ),
      ),
    );
  }
  Widget _buildHeader(Color textColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Precision Area',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w800,
            color: textColor,
            letterSpacing: -1.0,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Calculate surface area across multiple units.',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: textColor.withValues(alpha: 0.6),
          ),
        ),
      ],
    );
  }
  Widget _buildConverterCard(Color cardColor, Color textColor, Color primaryColor, bool isDarkMode) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 40,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildUnitSelector('From', _fromUnit, (val) {
            setState(() => _fromUnit = val!);
            _convert();
          }, textColor, isDarkMode),
          const SizedBox(height: 16),
          TextField(
            controller: _inputController,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.w300,
              color: textColor,
              letterSpacing: -2,
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: '0',
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Expanded(child: Divider(color: textColor.withValues(alpha: 0.1))),
                GestureDetector(
                  onTap: _swapUnits,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.swap_vert, color: Colors.white, size: 20),
                  ),
                ),
                Expanded(child: Divider(color: textColor.withValues(alpha: 0.1))),
              ],
            ),
          ),
          _buildUnitSelector('To', _toUnit, (val) {
            setState(() => _toUnit = val!);
            _convert();
          }, textColor, isDarkMode),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              _result < 0.0001 ? _result.toStringAsExponential(4) : _result.toStringAsFixed(4),
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.w300,
                color: Color(0xFF145DA2),
                letterSpacing: -2,
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildUnitSelector(String label, String value, void Function(String?) onChanged, Color textColor, bool isDarkMode) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label.toUpperCase(),
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: textColor.withValues(alpha: 0.5),
            letterSpacing: 1.0,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: isDarkMode ? Colors.white.withValues(alpha: 0.05) : const Color(0xFFF0F4F8),
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButton<String>(
            value: value,
            underline: const SizedBox(),
            icon: const Icon(Icons.keyboard_arrow_down, size: 18),
            items: _unitFactors.keys.map((String unit) {
              return DropdownMenuItem<String>(
                value: unit,
                child: Text(unit, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
  Widget _buildQuickReferences(Color cardColor, Color textColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Reference',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: textColor),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            _buildRefCard('1 km²', '247.1 Acres', cardColor, textColor),
            const SizedBox(width: 16),
            _buildRefCard('1 m²', '10.76 ft²', cardColor, textColor),
          ],
        ),
      ],
    );
  }
  Widget _buildRefCard(String title, String value, Color cardColor, Color textColor) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: textColor.withValues(alpha: 0.05)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 12, color: textColor.withValues(alpha: 0.6)),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: textColor),
            ),
          ],
        ),
      ),
    );
  }
}
