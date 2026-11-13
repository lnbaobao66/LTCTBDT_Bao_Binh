import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(const WaterTrackerApp());
}

class WaterTrackerApp extends StatelessWidget {
  const WaterTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Water Tracker',
      theme: ThemeData(
        primaryColor: const Color(0xFF137FEC),
        fontFamily: 'Manrope', // Đảm bảo bạn đã thêm font Manrope vào pubspec.yaml
        useMaterial3: true,
      ),
      home: const WaterReminderScreen(),
    );
  }
}

class WaterReminderScreen extends StatefulWidget {
  const WaterReminderScreen({super.key});

  @override
  State<WaterReminderScreen> createState() => _WaterReminderScreenState();
}

class _WaterReminderScreenState extends State<WaterReminderScreen> {
  bool _isEnabled = true;
  String _selectedFrequency = '1 giờ';
  final List<String> _frequencies = ['30 phút', '1 giờ', '2 giờ'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Nhắc nhở uống nước',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Illustration
            _buildHeroSection(),
            const SizedBox(height: 32),

            // Main Toggle
            _buildToggleSection(),
            const SizedBox(height: 32),

            // Frequency Selection
            const Text(
              'Tần suất',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 16),
            _buildFrequencySelector(),
            const SizedBox(height: 32),

            // Time Window
            const Text(
              'Thời gian nhắc',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 16),
            _buildTimeWindowSection(),
            const SizedBox(height: 32),

            // Notification Preview
            const Text(
              'Thông báo mẫu',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 16),
            _buildNotificationPreview(),
            const SizedBox(height: 40),

            // Action Buttons
            _buildActionButtons(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      width: double.infinity,
      height: 240,
      decoration: BoxDecoration(
        color: const Color(0xFF137FEC).withOpacity(0.1),
        borderRadius: BorderRadius.circular(32),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background "Blur" effects
          Positioned(
            top: -40,
            right: -40,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: const Color(0xFF137FEC).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: const Color(0xFF137FEC),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF137FEC).withOpacity(0.4),
                      blurRadius: 30,
                      offset: const Offset(0, 15),
                    ),
                  ],
                ),
                child: const Icon(Icons.water_drop, color: Colors.white, size: 60),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.white),
                ),
                child: const Text(
                  'Stay Hydrated!',
                  style: TextStyle(
                    color: Color(0xFF137FEC),
                    fontWeight: FontWeight.w900,
                    fontSize: 14,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildToggleSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF137FEC).withOpacity(0.05),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFF137FEC).withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)
              ],
            ),
            child: const Icon(Icons.notifications_active, color: Color(0xFF137FEC)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Bật nhắc nhở',
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
                ),
                Text(
                  'Nhận thông báo uống nước',
                  style: TextStyle(color: Colors.grey[600], fontSize: 12, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          Switch(
            value: _isEnabled,
            onChanged: (val) => setState(() => _isEnabled = val),
            activeColor: Colors.white,
            activeTrackColor: const Color(0xFF137FEC),
          ),
        ],
      ),
    );
  }

  Widget _buildFrequencySelector() {
    return Row(
      children: _frequencies.map((freq) {
        bool isSelected = _selectedFrequency == freq;
        return Expanded(
          child: GestureDetector(
            onTap: () => setState(() => _selectedFrequency = freq),
            child: Container(
              margin: EdgeInsets.only(
                right: freq != _frequencies.last ? 12 : 0,
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF137FEC) : Colors.grey[100],
                borderRadius: BorderRadius.circular(16),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: const Color(0xFF137FEC).withOpacity(0.3),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        )
                      ]
                    : null,
              ),
              child: Center(
                child: Text(
                  freq,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.grey[600],
                    fontWeight: FontWeight.w900,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTimeWindowSection() {
    return Row(
      children: [
        _buildTimeCard('Bắt đầu', '08:00', Icons.access_time_filled),
        const SizedBox(width: 16),
        _buildTimeCard('Kết thúc', '22:00', Icons.nightlight_round),
      ],
    );
  }

  Widget _buildTimeCard(String label, String time, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label.toUpperCase(),
              style: TextStyle(
                fontSize: 10,
                letterSpacing: 1.5,
                fontWeight: FontWeight.w900,
                color: Colors.grey[400],
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  time,
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
                ),
                Icon(icon, color: const Color(0xFF137FEC), size: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationPreview() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 30,
            offset: const Offset(0, 10),
          )
        ],
        border: Border.all(color: Colors.grey[100]!),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: const Color(0xFF137FEC),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF137FEC).withOpacity(0.2),
                  blurRadius: 15,
                )
              ],
            ),
            child: const Icon(Icons.opacity, color: Colors.white, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'WATER TRACKER',
                      style: TextStyle(
                        color: Color(0xFF137FEC),
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1,
                      ),
                    ),
                    Text(
                      'Bây giờ',
                      style: TextStyle(color: Colors.grey[400], fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                const Text(
                  'Đã đến lúc tiếp nước rồi! Cùng uống một ly nước lọc nhé! 💧',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    height: 1.4,
                    color: Color(0xFF1E293B),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF137FEC),
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 64),
            shape: RoundedRectangleType(borderRadius: BorderRadius.circular(24)),
            elevation: 15,
            shadowColor: const Color(0xFF137FEC).withOpacity(0.4),
          ),
          child: const Text(
            'Lưu cài đặt',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
          ),
        ),
        const SizedBox(height: 12),
        TextButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.refresh, size: 18),
          label: const Text('Đặt lại mặc định'),
          style: TextButton.styleFrom(
            foregroundColor: Colors.grey[400],
            textStyle: const TextStyle(fontWeight: FontWeight.w900),
          ),
        ),
      ],
    );
  }
}

class RoundedRectangleType extends RoundedRectangleBorder {
  RoundedRectangleType({required BorderRadius borderRadius}) : super(borderRadius: borderRadius);
}