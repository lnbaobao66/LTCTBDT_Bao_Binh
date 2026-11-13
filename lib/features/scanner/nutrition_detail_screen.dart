import 'package:flutter/material.dart';

void main() {
  runApp(const NutriScanApp());
}

class NutriScanApp extends StatelessWidget {
  const NutriScanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NutriScan',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF13EC5B),
        scaffoldBackgroundColor: const Color(0xFF102216),
        fontFamily: 'Manrope',
      ),
      home: const ScannedProductScreen(),
    );
  }
}

class ScannedProductScreen extends StatefulWidget {
  const ScannedProductScreen({super.key});

  @override
  State<ScannedProductScreen> createState() => _ScannedProductScreenState();
}

class _ScannedProductScreenState extends State<ScannedProductScreen> {
  int servingSize = 1;
  String mealTime = 'Lunch';
  final Color primaryColor = const Color(0xFF13EC5B);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Sản phẩm đã quét',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.edit, color: primaryColor),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeroSection(),
                _buildNutritionGrid(),
                _buildInputsSection(),
                _buildDailyProgress(),
                const SizedBox(height: 120),
              ],
            ),
          ),
          _buildConfirmButton(),
        ],
      ),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      height: 260,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
              "https://lh3.googleusercontent.com/aida-public/AB6AXuA1KRDD2-NPH1NcsMxIOxM2Umf0g1PyMJhnCtDBqeeQzSmb1D-cNJMwC6WjQ9-w0HXS9IBo-7Vdc5REz8XHum7TsuX_X3DheIRM8qihfGwn3WtbFsb1tHq74jkrxsbvPiBw5wLhFXkiviulkxh_DHDmhPteiP1uFnMaGr6f3GpxtG0eHuYaMuvGDg5FJLULa-AGUBbaOE70UE4PhzmTobN1Rhk_5J_QHNeEkQGQ0WyBnEFqWUTtEzV9-Y4XmmvRFC9moGcgpsEKExU"),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              const Color(0xFF102216).withOpacity(0.8),
              const Color(0xFF102216),
            ],
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'GIÀU PROTEIN',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Avocado Toast with Poached Egg',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            const Text(
              'ID: 008123456789',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNutritionGrid() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: [
          _buildNutritionCard('CALORIES', '342', 'kcal', isPrimary: true),
          _buildNutritionCard('PROTEIN', '18', 'g'),
          _buildNutritionCard('CARBS', '24', 'g'),
          _buildNutritionCard('FATS', '22', 'g'),
          _buildNutritionCard('FIBER', '7', 'g'),
        ],
      ),
    );
  }

  Widget _buildNutritionCard(String label, String value, String unit,
      {bool isPrimary = false}) {
    return Container(
      width: (MediaQuery.of(context).size.width - 52) / 3,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isPrimary ? primaryColor.withOpacity(0.1) : Colors.white10,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isPrimary ? primaryColor.withOpacity(0.3) : Colors.white12,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
                color: isPrimary ? primaryColor : Colors.grey,
                fontSize: 10,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: value,
                    style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: ' $unit',
                  style: const TextStyle(fontSize: 10, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('SERVING SIZE',
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 10,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                width: 80,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(border: InputBorder.none),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  controller: TextEditingController(text: '1'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: 'Serving (150g)',
                      items: ['Serving (150g)', 'Grams (g)', 'Ounces (oz)']
                          .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (_) {},
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text('TIME OF MEAL',
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 10,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildMealTimeButton('Breakfast', Icons.wb_sunny_outlined),
              _buildMealTimeButton('Lunch', Icons.cloud_outlined),
              _buildMealTimeButton('Dinner', Icons.nightlight_round_outlined),
              _buildMealTimeButton('Snack', Icons.icecream_outlined),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMealTimeButton(String label, IconData icon) {
    bool isSelected = mealTime == label;
    return GestureDetector(
      onTap: () => setState(() => mealTime = label),
      child: Container(
        width: (MediaQuery.of(context).size.width - 60) / 4,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? primaryColor : Colors.white12,
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: isSelected ? primaryColor : Colors.grey),
            const SizedBox(height: 4),
            Text(
              label.toUpperCase(),
              style: TextStyle(
                color: isSelected ? primaryColor : Colors.grey,
                fontSize: 8,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDailyProgress() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Tiến trình hôm nay',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                        text: '1,450',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(
                        text: ' / 2,100 kcal',
                        style: TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Stack(
              children: [
                Container(height: 8, color: Colors.white10),
                FractionallySizedBox(
                  widthFactor: 0.69, // 1450/2100
                  child: Container(height: 8, color: primaryColor.withOpacity(0.3)),
                ),
                FractionallySizedBox(
                  widthFactor: 0.85, // (1450+342)/2100
                  child: Container(
                    height: 8,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Thêm món này sẽ đạt 76% mục tiêu trong ngày.',
            style: TextStyle(color: Colors.grey, fontSize: 10),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmButton() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFF102216).withOpacity(0),
              const Color(0xFF102216),
            ],
          ),
        ),
        child: ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Thêm bữa ăn thành công!'),
                backgroundColor: primaryColor,
                duration: Duration(seconds: 2),
              ),
            );
            Future.delayed(const Duration(seconds: 2), () {
              Navigator.pop(context);
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(vertical: 18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 8,
            shadowColor: primaryColor.withOpacity(0.5),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check, fontWeight: FontWeight.bold),
              SizedBox(width: 8),
              Text(
                'Xác nhận & Thêm bữa ăn',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}