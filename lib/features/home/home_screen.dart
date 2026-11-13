import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'dart:math' as math;
import '../../routes/app_routes.dart';

void main() {
  runApp(const NutriTrackApp());
}

class NutriTrackApp extends StatelessWidget {
  const NutriTrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0F2316),
        textTheme: GoogleFonts.manropeTextTheme(ThemeData.dark().textTheme),
      ),
      home: const DashboardPage(),
      routes: appRoutes,
    );
  }
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 25),
                  const _CalorieCard(),
                  const SizedBox(height: 30),
                  const _QuickActions(),
                  const SizedBox(height: 25),
                  const _WaterTracker(),
                  const SizedBox(height: 25),
                  const _AIInsights(),
                  const SizedBox(height: 120), 
                ],
              ),
            ),
          ),
          const _BottomNav(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF06F957).withOpacity(0.3), width: 2),
              ),
              child: const CircleAvatar(
                radius: 18,
                backgroundImage: NetworkImage(''),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Xin chào,',
                  style: TextStyle(fontSize: 10, color: Colors.grey[400], fontWeight: FontWeight.w700, letterSpacing: 1),
                ),
                const Text(
                  'Thịnh',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: IconButton(
            icon: const Icon(LucideIcons.bell, size: 20),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}

class _CalorieCard extends StatelessWidget {
  const _CalorieCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF1A2E21).withOpacity(0.4),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 180,
                height: 180,
                child: CustomPaint(
                  painter: _CircularProgressPainter(percentage: 0.74),
                ),
              ),
              Column(
                children: [
                  const Text(
                    '1,850',
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.w900, letterSpacing: -1),
                  ),
                  Text(
                    'KCAL CÒN LẠI',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF06F957),
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 35),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildNutrient('Đạm', '80/120g', 0.65, const Color(0xFF06F957)),
              _buildNutrient('Carbs', '110/250g', 0.44, Colors.blueAccent),
              _buildNutrient('Béo', '45/65g', 0.69, Colors.orangeAccent),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNutrient(String label, String value, double progress, Color color) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey)),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.white.withOpacity(0.05),
                valueColor: AlwaysStoppedAnimation<Color>(color),
                minHeight: 6,
              ),
            ),
            const SizedBox(height: 8),
            Text(value, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

class _CircularProgressPainter extends CustomPainter {
  final double percentage;
  _CircularProgressPainter({required this.percentage});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final strokeWidth = 12.0;

    final bgPaint = Paint()
      ..color = Colors.white.withOpacity(0.05)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final progressPaint = Paint()
      ..color = const Color(0xFF06F957)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;

    canvas.drawCircle(center, radius, bgPaint);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * percentage,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _QuickActions extends StatelessWidget {
  const _QuickActions();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'LỐI TẮT NHANH',
          style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey[600], letterSpacing: 1.5),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildAction(context, LucideIcons.scan, 'Quét AI', '/ai_scan', isActive: true),
            _buildAction(context, LucideIcons.arrowLeftRight, 'So sánh', '/compare'),
            _buildAction(context, LucideIcons.utensils, 'Gợi ý bữa ăn', '/suggest_meal'),
            _buildAction(context, LucideIcons.qrCode, 'Quét mã', '/qr_scan'),
          ],
        ),
      ],
    );
  }

  Widget _buildAction(BuildContext context, IconData icon, String label, String routeName, {bool isActive = false}) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, routeName);
      },
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: isActive ? const Color(0xFF06F957).withOpacity(0.1) : Colors.white.withOpacity(0.03),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: isActive ? const Color(0xFF06F957).withOpacity(0.3) : Colors.white.withOpacity(0.05)),
            ),
            child: Icon(icon, color: isActive ? const Color(0xFF06F957) : Colors.white70, size: 24),
          ),
          const SizedBox(height: 10),
          Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey)),
        ],
      ),
    );
  }
}

class _WaterTracker extends StatelessWidget {
  const _WaterTracker();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.05),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.blue.withOpacity(0.1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Icon(LucideIcons.droplets, color: Colors.white, size: 22),
              ),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Nước uống', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  Text('1,200 / 2,000 ml', style: TextStyle(color: Colors.blue[400], fontSize: 12, fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
          Container(
            decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
            child: IconButton(
              icon: const Icon(LucideIcons.plus, color: Colors.white, size: 20),
              onPressed: () {
                Navigator.pushNamed(context, '/water_reminder');
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _AIInsights extends StatelessWidget {
  const _AIInsights();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white.withOpacity(0.05), Colors.white.withOpacity(0.02)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: const Color(0xFF06F957).withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                child: const Icon(LucideIcons.sparkles, color: Color(0xFF06F957), size: 18),
              ),
              const SizedBox(width: 15),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Gợi ý từ AI của bạn', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    SizedBox(height: 5),
                    Text(
                      'Bạn đã nạp khá nhiều protein hôm nay. Hãy thử một chút hoa quả giàu xơ vào bữa xế để cân bằng tiêu hóa nhé!',
                      style: TextStyle(color: Colors.grey, fontSize: 12, height: 1.5),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: List.generate(2, (index) => Container(
                  margin: const EdgeInsets.only(right: 4),
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(color: Color(0xFF1A2E21), shape: BoxShape.circle),
                  child: const Icon(LucideIcons.check, color: Color(0xFF06F957), size: 12),
                )),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const Text('Chi tiết', style: TextStyle(color: Color(0xFF06F957), fontSize: 12, fontWeight: FontWeight.bold)),
                label: const Icon(LucideIcons.arrowRight, color: Color(0xFF06F957), size: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BottomNav extends StatelessWidget {
  const _BottomNav();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 30,
      left: 20,
      right: 20,
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: const Color(0xFF1A2E21).withOpacity(0.95),
          borderRadius: BorderRadius.circular(35),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 10))],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _navItem(context, LucideIcons.home, 'Trang chủ', '/dashboard', isActive: true),
            _navItem(context, LucideIcons.bookOpen, 'Nhật ký', '/journal'),
            const SizedBox(width: 40), 
            _navItem(context, LucideIcons.barChart3, 'Thống kê', '/statistics'),
            _navItem(context, LucideIcons.user, 'Hồ sơ', '/profile'),
          ],
        ),
      ),
    ).withFloatingButton();
  }

  Widget _navItem(BuildContext context, IconData icon, String label, String routeName, {bool isActive = false}) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, routeName);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: isActive ? const Color(0xFF06F957) : Colors.grey, size: 22),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: isActive ? const Color(0xFF06F957) : Colors.grey)),
        ],
      ),
    );
  }
}

extension _BottomNavExtension on Widget {
  Widget withFloatingButton() {
    return Stack(
      alignment: Alignment.center,
      children: [
        this,
        Positioned(
          bottom: 55,
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: const Color(0xFF06F957),
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: const Color(0xFF06F957).withOpacity(0.3), blurRadius: 15, spreadRadius: 2)],
            ),
            child: const Icon(LucideIcons.plus, color: Color(0xFF0F2316), size: 30, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}