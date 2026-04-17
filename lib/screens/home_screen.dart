import 'package:flutter/material.dart';
import '../main.dart';
import 'length_screen.dart';
import 'weightscreen.dart';
import 'areascreen.dart';
import 'tempscreen.dart';
import 'currencyscreen.dart';
import 'timescreen.dart';
import 'todoscrren.dart';


class UtilityDashboardScreen extends StatefulWidget {
  const UtilityDashboardScreen({super.key});

  @override
  State<UtilityDashboardScreen> createState() => _UtilityDashboardScreenState();
}

class _UtilityDashboardScreenState extends State<UtilityDashboardScreen> {

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkMode ? const Color(0xFF1A1C1E) : const Color(0xFFF5F7F9);
    final primaryTextColor = isDarkMode ? Colors.white : const Color(0xFF2C2F31);
    final secondaryTextColor = isDarkMode ? Colors.white70 : const Color(0xFF595C5E);
    final cardColor = isDarkMode ? const Color(0xFF2C2F31) : Colors.white;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            _buildAppBar(backgroundColor, primaryTextColor),
            SliverPadding(
              padding:
              const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _buildAllUtilitiesHeader(primaryTextColor),
                  const SizedBox(height: 24),
                  _buildUtilitiesGrid(cardColor, primaryTextColor, secondaryTextColor),
                  const SizedBox(height: 80),
                  _buildAestheticSpacer(primaryTextColor, secondaryTextColor),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(Color bgColor, Color textColor) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return SliverAppBar(
      backgroundColor: bgColor,
      floating: true,
      pinned: true,
      elevation: 0,
      title: Row(
        children: [
          const Icon(Icons.architecture, color: Color(0xFF145DA2)),
          const SizedBox(width: 8),
          Text(
            'Precision Utility',
            style: TextStyle(
              color: textColor == Colors.white ? Colors.white : const Color(0xFF145DA2),
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
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
    );
  }

  Widget _buildAllUtilitiesHeader(Color textColor) {
    return Text(
      'UNIT CONVERTER',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: textColor,
        letterSpacing: -0.5,
      ),
    );
  }

  Widget _buildUtilitiesGrid(Color cardBg, Color primaryText, Color secondaryText) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      children: [
        _buildUtilityCard(
          context: context,
          icon: Icons.straighten,
          title: 'LENGTH',
          iconColor: const Color(0xFF145DA2),
          cardBg: cardBg,
          primaryText: primaryText,
          secondaryText: secondaryText, subtitle: 'Meters, Feet, Kilometer',
          destination: LengthConverterScreen(),
        ),
        _buildUtilityCard(
          context: context,
          icon: Icons.scale,
          title: 'WEIGHT',
          iconColor: const Color(0xFF803F9D),
          cardBg: cardBg,
          primaryText: primaryText,
          secondaryText: secondaryText, subtitle: 'Kilograms, Pounds',
          destination: WeightConverterScreen(),
        ),
        _buildUtilityCard(
          context: context,
          icon: Icons.thermostat,
          title: 'TEMPERATURE',
          iconColor: const Color(0xFF006666),
          cardBg: cardBg,
          primaryText: primaryText,
          secondaryText: secondaryText, subtitle: 'Celsius, Fahrenheit',
          destination: TemperatureConverterScreen(),
        ),
        _buildUtilityCard(
          context: context,
          icon: Icons.landscape,
          title: 'AREA',
          iconColor: const Color(0xFF006666),
          cardBg: cardBg,
          primaryText: primaryText,
          secondaryText: secondaryText, subtitle: 'Square Meters, Square Feet',
          destination: AreaConverterScreen(),
        ),
        _buildUtilityCard(
          context: context,
          icon: Icons.currency_exchange,
          title: 'CURRENCY',
          iconColor: const Color(0xFF006666),
          cardBg: cardBg,
          primaryText: primaryText,
          secondaryText: secondaryText, subtitle: "USD, Euros",
          destination: const CurrencyConverterScreen(),
        ),
        _buildUtilityCard(
          context: context,
          icon: Icons.watch,
          title: 'TIME',
          iconColor: const Color(0xFF006666),
          cardBg: cardBg,
          primaryText: primaryText,
          secondaryText: secondaryText, subtitle: 'Hours, Minutes, Seconds',
          destination: const TimeConverterScreen(),
        ),
        _buildUtilityCard(
          context: context,
          icon: Icons.check_box,
          title: 'TODO LIST',
          iconColor: const Color(0xFF006666),
          cardBg: cardBg,
          primaryText: primaryText,
          secondaryText: secondaryText, subtitle: 'Task Management',
          destination: const TodoListScreen(),
        ),
      ],
    );
  }

  Widget _buildUtilityCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color iconColor,
    required Color cardBg,
    required Color primaryText,
    required Color secondaryText,
    required BuildContext context,
    Widget? destination,
  }) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => destination ?? Lendetailscreen(
                title: title,
                icon: icon)
          ),
        );
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.withValues(alpha: 0.05)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Hero(
              tag: title,
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white.withValues(alpha: 0.05)
                      : const Color(0xFFF0F4F8),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: iconColor),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: primaryText,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: secondaryText,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildAestheticSpacer(Color primaryText, Color secondaryText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(color: secondaryText.withValues(alpha: 0.05)),
        const SizedBox(height: 48),
        Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 24,
                offset: Offset(0, 12),
              ),
            ],
          ),
        ),
      ],
    );
  }

}
