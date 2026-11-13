import 'package:flutter/material.dart';


void main() {
  runApp(const HealthReportApp());
}

class HealthReportApp extends StatelessWidget {
  const HealthReportApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0A1A0F),
        primaryColor: const Color(0xFF13EC5B),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF13EC5B),
          surface: Color(0xFF152B1E),
        ),
      ),
      home: const HealthReportScreen(),
    );
  }
}

class HealthReportScreen extends StatefulWidget {
  const HealthReportScreen({super.key});

  @override
  State<HealthReportScreen> createState() => _HealthReportScreenState();
}

class _HealthReportScreenState extends State<HealthReportScreen> {
  int _selectedIndex = 2; // "Báo cáo" tab

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
          'Báo cáo Sức khỏe',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            // Tab Selector (Ngày, Tuần, Tháng)
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  _buildTab('Ngày', false),
                  _buildTab('Tuần', true),
                  _buildTab('Tháng', false),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Date Range Selector
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.chevron_left, color: Theme.of(context).primaryColor.withOpacity(0.6)),
                Text(
                  '14 TH10 - 20 TH10',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
                Icon(Icons.chevron_right, color: Theme.of(context).primaryColor.withOpacity(0.6)),
              ],
            ),
            const SizedBox(height: 24),
            // Calorie Card
            _buildCalorieCard(),
            const SizedBox(height: 24),
            // Nutrition Balance
            const Text(
              'CÂN BẰNG DINH DƯỠNG',
              style: TextStyle(color: Colors.white30, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.5),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildNutrientCircle(0.7, 'Đạm', const Color(0xFF13EC5B)),
                _buildNutrientCircle(0.85, 'Tinh bột', Colors.blueAccent),
                _buildNutrientCircle(0.45, 'Chất béo', Colors.amber),
              ],
            ),
            const SizedBox(height: 24),
            // Water Intake Card
            _buildWaterCard(),
            const SizedBox(height: 24),
            // AI Insights Card
            _buildAIInsights(),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/water_reminder');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF06F957),
                  foregroundColor: const Color(0xFF0F2316),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  textStyle: const TextStyle(fontWeight: FontWeight.bold),
                ),
                child: const Text('Đi đến Water Reminder'),
              ),
            ),
            const SizedBox(height: 100), // Space for bottom nav
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildTab(String label, bool isActive) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? Theme.of(context).primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isActive ? const Color(0xFF0A1A0F) : Colors.white38,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCalorieCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF152B1E).withOpacity(0.6),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Trung bình Calorie', style: TextStyle(color: Colors.white38, fontSize: 14)),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      const Text('1,850', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                      const SizedBox(width: 4),
                      Text('kcal', style: TextStyle(color: Colors.white.withOpacity(0.2), fontSize: 14)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.trending_up, color: Theme.of(context).primaryColor, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        '+2% so với tuần trước',
                        style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
              const Icon(Icons.info_outline, color: Colors.white12),
            ],
          ),
          const SizedBox(height: 24),
          // Simple Bar Chart Placeholder
          SizedBox(
            height: 120,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildBar(0.6, 'T2'),
                _buildBar(0.7, 'T3'),
                _buildBar(0.9, 'T4', isActive: true),
                _buildBar(0.5, 'T5'),
                _buildBar(0.4, 'T6'),
                _buildBar(0.8, 'T7'),
                _buildBar(0.65, 'CN'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBar(double heightFactor, String label, {bool isActive = false}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 30,
          height: 80 * heightFactor,
          decoration: BoxDecoration(
            color: isActive ? Theme.of(context).primaryColor : Theme.of(context).primaryColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(color: Colors.white30, fontSize: 10, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildNutrientCircle(double progress, String label, Color color) {
    return Container(
      width: (MediaQuery.of(context).size.width - 64) / 3,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF152B1E).withOpacity(0.4),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 4,
                  backgroundColor: Colors.white.withOpacity(0.05),
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                ),
              ),
              Text('${(progress * 100).toInt()}%', style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(color: Colors.white60, fontSize: 11, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildWaterCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF152B1E).withOpacity(0.6),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(color: Colors.blue.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                    child: const Icon(Icons.water_drop, color: Colors.blueAccent, size: 18),
                  ),
                  const SizedBox(width: 12),
                  const Text('Lượng nước uống', style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              const Text('2.1L / ngày', style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold, fontSize: 14)),
            ],
          ),
          const SizedBox(height: 20),
          // Wave Chart Placeholder
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              height: 60,
              width: double.infinity,
              color: Colors.blue.withOpacity(0.05),
              child: CustomPaint(painter: WavePainter()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAIInsights() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Theme.of(context).primaryColor.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.auto_awesome, color: Theme.of(context).primaryColor, size: 18),
              const SizedBox(width: 8),
              Text('Phân tích từ AI', style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 12),
          RichText(
            text: TextSpan(
              style: const TextStyle(color: Colors.white70, fontSize: 14, height: 1.5),
              children: [
                const TextSpan(text: 'Bạn đã hoàn thành mục tiêu Protein '),
                TextSpan(
                  text: '5/7 ngày',
                  style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
                ),
                const TextSpan(text: '! Đây là một kết quả tuyệt vời cho việc phát triển cơ bắp.'),
              ],
            ),
          ),
          Divider(color: Theme.of(context).primaryColor.withOpacity(0.1), height: 24),
          RichText(
            text: const TextSpan(
              style: TextStyle(color: Colors.white70, fontSize: 14, height: 1.5),
              children: [
                TextSpan(text: 'Lời khuyên: ', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                TextSpan(text: 'Hãy cố gắng tăng lượng nước uống vào cuối tuần, bạn thường uống ít hơn 30% so với ngày thường.'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      padding: const EdgeInsets.only(bottom: 30, top: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF0A1A0F).withOpacity(0.9),
        border: const Border(top: BorderSide(color: Colors.white10, width: 0.5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.add_circle_outline, 'Ghi chép', false),
          _buildNavItem(Icons.menu_book, 'Kế hoạch', false),
          _buildNavItem(Icons.bar_chart, 'Báo cáo', true),
          _buildNavItem(Icons.person_outline, 'Cá nhân', false),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: isActive ? Theme.of(context).primaryColor : Colors.white24),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: isActive ? Theme.of(context).primaryColor : Colors.white24,
            fontSize: 10,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}

class WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.blueAccent.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    var path = Path();
    path.moveTo(0, size.height * 0.7);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.5, size.width * 0.5, size.height * 0.7);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.9, size.width, size.height * 0.7);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}