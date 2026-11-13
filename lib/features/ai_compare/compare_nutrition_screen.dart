import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const NutriCompareApp());
}

class NutriCompareApp extends StatelessWidget {
  const NutriCompareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NutriCompare AI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF13EC5B),
        scaffoldBackgroundColor: const Color(0xFF102216),
        textTheme: GoogleFonts.manropeTextTheme(ThemeData.dark().textTheme),
      ),
      home: const ComparisonScreen(),
    );
  }
}

class ComparisonScreen extends StatefulWidget {
  const ComparisonScreen({super.key});

  @override
  State<ComparisonScreen> createState() => _ComparisonScreenState();
}

class _ComparisonScreenState extends State<ComparisonScreen> {
  final TextEditingController _foodAController = TextEditingController(text: 'Phở Bò');
  final TextEditingController _foodBController = TextEditingController(text: 'Bún Chả');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'So sánh món ăn',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Inputs
              Row(
                children: [
                  Expanded(
                    child: _buildSearchInput('Món A', _foodAController),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildSearchInput('Món B', _foodBController),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Food Visuals
              Row(
                children: [
                  Expanded(
                    child: _buildFoodCard(
                      'Phở Bò',
                      'Lựa chọn cân bằng',
                      'https://images.unsplash.com/photo-1582878826629-29b7ad1cdc43?q=80&w=1000&auto=format&fit=crop',
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildFoodCard(
                      'Bún Chả',
                      'Hương vị đậm đà',
                      'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?q=80&w=1000&auto=format&fit=crop',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Nutrition Section Title
              const Row(
                children: [
                  Icon(Icons.bar_chart, color: Color(0xFF13EC5B)),
                  SizedBox(width: 8),
                  Text(
                    'Chỉ số dinh dưỡng',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Nutrition Rows
              _buildNutritionRow('Calories', '450 kcal', '380 kcal', winner: 'B'),
              _buildNutritionRow('Protein', '28g', '22g', winner: 'A'),
              _buildNutritionRow('Carbs', '55g', '45g', winner: 'B'),
              _buildNutritionRow('Fats', '12g', '18g', winner: 'A'),
              const SizedBox(height: 24),
              // AI Recommendation
              _buildAIRecommendation('Phở Bò'),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.white.withOpacity(0.1))),
        ),
        child: BottomNavigationBar(
          backgroundColor: const Color(0xFF102216),
          selectedItemColor: const Color(0xFF13EC5B),
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          currentIndex: 1,
          selectedFontSize: 10,
          unselectedFontSize: 10,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'TRANG CHỦ'),
            BottomNavigationBarItem(icon: Icon(Icons.compare_arrows), label: 'SO SÁNH'),
            BottomNavigationBarItem(icon: Icon(Icons.book_outlined), label: 'NHẬT KÝ'),
            BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'CÁ NHÂN'),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchInput(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.grey)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          style: const TextStyle(fontSize: 14),
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search, size: 18, color: Colors.grey),
            hintText: 'Tìm $label',
            filled: true,
            fillColor: Colors.white.withOpacity(0.05),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF13EC5B)),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildFoodCard(String title, String subtitle, String imageUrl) {
    return Container(
      height: 220,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
          ),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
            Text(subtitle, style: const TextStyle(color: Color(0xFF13EC5B), fontSize: 11)),
          ],
        ),
      ),
    );
  }

  Widget _buildNutritionRow(String label, String valA, String valB, {required String winner}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          // Món A
          Expanded(
            child: Row(
              children: [
                if (winner == 'A') const Icon(Icons.check_circle, color: Color(0xFF13EC5B), size: 18),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(valA, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: winner == 'A' ? const Color(0xFF13EC5B) : Colors.white)),
                    const Text('MÓN A', style: TextStyle(fontSize: 9, color: Colors.grey)),
                  ],
                ),
              ],
            ),
          ),
          // Label
          Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey, fontWeight: FontWeight.w500)),
          // Món B
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(valB, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: winner == 'B' ? const Color(0xFF13EC5B) : Colors.white)),
                    const Text('MÓN B', style: TextStyle(fontSize: 9, color: Colors.grey)),
                  ],
                ),
                const SizedBox(width: 8),
                if (winner == 'B') const Icon(Icons.check_circle, color: Color(0xFF13EC5B), size: 18),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAIRecommendation(String food) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF13EC5B).withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF13EC5B).withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.psychology, color: Color(0xFF13EC5B), size: 20),
              SizedBox(width: 8),
              Text('GỢI Ý TỪ AI', style: TextStyle(color: Color(0xFF13EC5B), fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 1)),
            ],
          ),
          const SizedBox(height: 12),
          RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 13, height: 1.6, color: Colors.white70, fontFamily: 'Manrope'),
              children: [
                TextSpan(text: '$food ', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                const TextSpan(text: 'là lựa chọn tốt hơn cho bữa trưa hôm nay vì ít chất béo bão hòa hơn và cung cấp hàm lượng protein dồi dào, giúp bạn no lâu và duy trì năng lượng.'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}