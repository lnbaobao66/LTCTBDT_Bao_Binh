import 'package:flutter/material.dart';
import 'dart:async';

class OnboardingData {
  final String title;
  final String description;
  final String imageUrl;
  final IconData icon;

  OnboardingData({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.icon,
  });
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentStep = 0;
  bool _isFinished = false;

  final List<OnboardingData> _data = [
    OnboardingData(
      title: "Quét thực phẩm thông minh với AI",
      description: "Tự động nhận diện món ăn và phân tích hàm lượng calories, dinh dưỡng chi tiết chỉ trong một lần chạm.",
      imageUrl: "https://lh3.googleusercontent.com/aida-public/AB6AXuCBRAdldN5uOJYxib9xHs6Mh8eFGtKJpWeJhsyUNOcpvSLkG-_bzFuQ1KdW1GgEOJ9eM9YFgVtTYu0CR2X6Buwf-21K4hMNNWckuVJ6z-FRKhxv7DNv8tOVH94K_H9vqOKgEGVSQwmMqkyxm8lUdRsRpV_4oFxfvCP-TG8qnMTIsWS3CX_CeotLtMrMSp-0aEc-PFWAdkPq_iFdRnCeImaMyHarxUJEKRYlmCevfP6Y6xDT8gf8gCvFoJOOTO8NkcLuIxLiridndGw",
      icon: Icons.camera_alt_outlined,
    ),
    OnboardingData(
      title: "Phân tích dinh dưỡng chuyên sâu",
      description: "Theo dõi Protein, Carbs, Fats và các vi chất thiết yếu để đảm bảo cơ thể luôn ở trạng thái tốt nhất.",
      imageUrl: "https://picsum.photos/seed/nutrition/800/800",
      icon: Icons.bar_chart_outlined,
    ),
    OnboardingData(
      title: "Cá nhân hóa mục tiêu sức khỏe",
      description: "Xây dựng lộ trình ăn uống phù hợp với thể trạng và mục tiêu giảm cân hoặc tăng cơ của riêng bạn.",
      imageUrl: "https://picsum.photos/seed/goals/800/800",
      icon: Icons.track_changes_outlined,
    ),
  ];

  void _nextStep() {
    if (_currentStep < _data.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOut,
      );
    } else {
      setState(() => _isFinished = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isFinished) {
      return Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: const Color(0xFF13EC5B).withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.camera_alt, color: Color(0xFF13EC5B), size: 40),
                ),
                const SizedBox(height: 24),
                const Text(
                  "Chào mừng bạn!",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Bắt đầu hành trình ăn uống lành mạnh ngay hôm nay.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/onboarding_goal');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF13EC5B),
                      foregroundColor: const Color(0xFF102216),
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: const Text("Bắt đầu", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => setState(() => _isFinished = true),
                  child: const Text(
                    "Bỏ qua",
                    style: TextStyle(color: Color(0xFF13EC5B), fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
            ),
            
            // Content
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) => setState(() => _currentStep = index),
                itemCount: _data.length,
                itemBuilder: (context, index) {
                  final item = _data[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Image Container with Scanning Effect
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(32),
                              child: Container(
                                width: 320,
                                height: 320,
                                color: const Color(0xFF1A2E21),
                                child: Image.network(
                                  item.imageUrl,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            if (index == 0) const ScanningOverlay(),
                          ],
                        ),
                        const SizedBox(height: 40),
                        Text(
                          item.title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w800, height: 1.2),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          item.description,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.grey, fontSize: 16, height: 1.5),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Footer
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                children: [
                  // Pagination Dots
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(_data.length, (index) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        height: 8,
                        width: index == _currentStep ? 24 : 8,
                        decoration: BoxDecoration(
                          color: index == _currentStep ? const Color(0xFF13EC5B) : const Color(0xFF1A2E21),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 32),
                  // Action Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_currentStep == _data.length - 1) {
                          Navigator.pushNamed(context, '/onboarding_goal');
                        } else {
                          _nextStep();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF13EC5B),
                        foregroundColor: const Color(0xFF102216),
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        elevation: 8,
                        shadowColor: const Color(0xFF13EC5B).withOpacity(0.3),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _currentStep == _data.length - 1 ? "Bắt đầu" : "Tiếp tục",
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.chevron_right),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // iOS Home Indicator Placeholder
                  Container(
                    width: 120,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Hiệu ứng quét AI cho màn hình đầu tiên
class ScanningOverlay extends StatefulWidget {
  const ScanningOverlay({super.key});

  @override
  State<ScanningOverlay> createState() => _ScanningOverlayState();
}

class _ScanningOverlayState extends State<ScanningOverlay> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Stack(
          children: [
            // Bốn góc khung quét
            Align(alignment: Alignment.topLeft, child: _buildCorner(top: true, left: true)),
            Align(alignment: Alignment.topRight, child: _buildCorner(top: true, left: false)),
            Align(alignment: Alignment.bottomLeft, child: _buildCorner(top: false, left: true)),
            Align(alignment: Alignment.bottomRight, child: _buildCorner(top: false, left: false)),
            
            // Đường quét chuyển động
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Positioned(
                  top: 250 * _controller.value,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 2,
                    decoration: BoxDecoration(
                      color: const Color(0xFF13EC5B),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF13EC5B).withOpacity(0.5),
                          blurRadius: 10,
                          spreadRadius: 2,
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCorner({required bool top, required bool left}) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        border: Border(
          top: top ? const BorderSide(color: Color(0xFF13EC5B), width: 4) : BorderSide.none,
          bottom: !top ? const BorderSide(color: Color(0xFF13EC5B), width: 4) : BorderSide.none,
          left: left ? const BorderSide(color: Color(0xFF13EC5B), width: 4) : BorderSide.none,
          right: !left ? const BorderSide(color: Color(0xFF13EC5B), width: 4) : BorderSide.none,
        ),
      ),
    );
  }
}