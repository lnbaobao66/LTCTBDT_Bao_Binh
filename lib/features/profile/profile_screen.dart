import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:btl_mobile/features/profile/acc_manager/profile_information_screen.dart';
import 'package:btl_mobile/core/services/user_manager.dart';

void main() {
  runApp(const FitnessApp());
}

class FitnessApp extends StatelessWidget {
  const FitnessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fitness Profile',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0F2316),
        textTheme: GoogleFonts.manropeTextTheme(
          ThemeData.dark().textTheme,
        ),
      ),
      home: const ProfileScreen(),
      routes: {
        '/profile_info': (context) => ProfileEditorScreen(),
      },
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF06F957);
    const surfaceColor = Color(0xFF1A2E21);
    const accentRed = Color(0xFFFF4D4D);

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
          'Hồ sơ Cá nhân',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            // Profile Section
            Center(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: primaryColor.withOpacity(0.2), width: 4),
                          image: const DecorationImage(
                            image: NetworkImage(
                              "https://lh3.googleusercontent.com/aida-public/AB6AXuCObSJr15mN7nvr8whvyExMWS9F7WiukztsIfD9cabxM_otQgdi_5atu3cNnKBYpC5pw932grsc0gFGTyun4kmqgO5Y6FIEROvurTKiVQAhiIWPLUfD4P8jCTAq-1xTNJiUgnjEhp4dmZhX1RMPAilr3WIfNuAjt58sxIQR2fYheYo3FvIoBZZGAhDMBpbqJWuZfQlzU7mf4VRU5kgGmL6nlPtXrOCkD18f0o3jzkZf9P2KWP9x2rHexew7zw1DzbncNxi6WSD_8iY",
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.edit, size: 18, color: Color(0xFF0F2316)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ValueListenableBuilder<String>(
                    valueListenable: UserManager().nameNotifier,
                    builder: (context, name, _) {
                      return Text(
                        name.isEmpty ? 'Chưa có tên' : name,
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: -0.5),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      color: primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: primaryColor.withOpacity(0.2)),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.track_changes, color: primaryColor, size: 16),
                        SizedBox(width: 8),
                        Text(
                          'MỤC TIÊU: GIẢM CÂN',
                          style: TextStyle(color: primaryColor, fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Quick Stats
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'THỐNG KÊ NHANH',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 2),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                ValueListenableBuilder<double>(
                  valueListenable: UserManager().weightNotifier,
                  builder: (context, weight, _) {
                    return _buildStatCard('Cân nặng', weight.toStringAsFixed(1), 'kg', primaryColor, surfaceColor);
                  },
                ),
                const SizedBox(width: 12),
                ValueListenableBuilder<double>(
                  valueListenable: UserManager().heightNotifier,
                  builder: (context, height, _) {
                    return _buildStatCard('Chiều cao', height.toStringAsFixed(1), 'cm', primaryColor, surfaceColor);
                  },
                ),
                const SizedBox(width: 12),
                ValueListenableBuilder(
                  valueListenable: UserManager().weightNotifier,
                  builder: (context, weight, _) {
                    return ValueListenableBuilder(
                      valueListenable: UserManager().heightNotifier,
                      builder: (context, height, __) {
                        double bmi = height > 0 ? weight / ((height / 100) * (height / 100)) : 0;
                        return _buildStatCard('BMI', bmi.toStringAsFixed(1), '', primaryColor, surfaceColor);
                      },
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: 40),

            // Account Management
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'QUẢN LÝ TÀI KHOẢN',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 2),
              ),
            ),
            const SizedBox(height: 16),
            _buildMenuItem(
              Icons.person_outline,
              'Thông tin cá nhân',
              surfaceColor,
              primaryColor,
              onTap: () {
                Navigator.pushNamed(context, '/profile_info');
              },
            ),
            _buildMenuItem(
              Icons.restaurant_menu,
              'Mục tiêu dinh dưỡng',
              surfaceColor,
              primaryColor,
              onTap: () {
                Navigator.pushNamed(context, '/nutrition_goal');
              },
            ),
            _buildMenuItem(
              Icons.watch_outlined,
              'Thiết bị đã kết nối',
              surfaceColor,
              primaryColor,
              onTap: () {
                Navigator.pushNamed(context, '/connected_devices');
              },
            ),
            _buildMenuItem(
              Icons.notifications_none,
              'Cài đặt thông báo',
              surfaceColor,
              primaryColor,
              onTap: () {
                Navigator.pushNamed(context, '/notification_settings');
              },
            ),

            const SizedBox(height: 32),

            // Logout Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/onboarding_ai');
                },
                icon: const Icon(Icons.logout, color: accentRed),
                label: const Text('Đăng xuất', style: TextStyle(color: accentRed, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: accentRed.withOpacity(0.1),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(color: accentRed.withOpacity(0.2)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 100), // Space for bottom nav
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.white.withOpacity(0.05))),
        ),
        child: BottomNavigationBar(
          backgroundColor: surfaceColor.withOpacity(0.95),
          type: BottomNavigationBarType.fixed,
          selectedItemColor: primaryColor,
          unselectedItemColor: Colors.grey,
          currentIndex: 3,
          selectedLabelStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          unselectedLabelStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'TRANG CHỦ'),
            BottomNavigationBarItem(icon: Icon(Icons.book_outlined), label: 'NHẬT KÝ'),
            BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'THỐNG KÊ'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'HỒ SƠ'),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String value, String unit, Color primary, Color surface) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label.toUpperCase(),
              style: const TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  value,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: primary),
                ),
                if (unit.isNotEmpty) ...[
                  const SizedBox(width: 2),
                  Text(unit, style: const TextStyle(fontSize: 10, color: Colors.grey)),
                ]
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    IconData icon,
    String label,
    Color surface,
    Color primary,
    {VoidCallback? onTap}
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: primary, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}