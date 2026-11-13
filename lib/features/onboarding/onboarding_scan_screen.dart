import 'package:flutter/material.dart';

class SetupScreen extends StatelessWidget {
  const SetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'AI Insights',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Progress Indicator
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Hoàn tất thiết lập', style: TextStyle(fontWeight: FontWeight.w500)),
                          Text('3/3', style: TextStyle(fontSize: 12, color: Colors.grey)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: const LinearProgressIndicator(
                          value: 1.0,
                          backgroundColor: Color(0x3313EC5B),
                          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF13EC5B)),
                          minHeight: 8,
                        ),
                      ),
                    ],
                  ),
                ),

                // Hero Image Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    height: 360,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      image: const DecorationImage(
                        image: NetworkImage("https://lh3.googleusercontent.com/aida-public/AB6AXuDejrMdlMZ3miIOMr7nwf4O7pReOTeewI2OUAOZQ2Pq3c0xh_gSyuW7K-fxGoqMQGv1c2UbdOM-Dqs2JTxnVDe3iKCFfhmyV9avrpR_2kFWWVCext7dNxThZjHCQWynN5itlWQ2MA0vurNoztezAbk7GRkuyQWCdGTrkFakJa8oBcPxbPlELlQYHjklioKNljroPI9jCIN6v9bBCsiiHl-to76-CdbIB9KfiCS9fOe3vuW57KuTvAuA2FSN93GHgWAc7YIFdgNpLyI"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            const Color(0xFF102216).withOpacity(0.4),
                            const Color(0xFF102216),
                          ],
                          stops: const [0.5, 0.8, 1.0],
                        ),
                      ),
                      padding: const EdgeInsets.all(24),
                      alignment: Alignment.bottomLeft,
                      child: const Text(
                        'Gợi ý món ăn &\nNhắc nhở thông minh',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          height: 1.2,
                        ),
                      ),
                    ),
                  ),
                ),

                // Description
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 24),
                  child: Text(
                    'AI sẽ đồng hành cùng bạn để cảnh báo những lựa chọn không lành mạnh và gợi ý thực đơn thay thế tốt hơn mỗi ngày.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey, fontSize: 15, height: 1.5),
                  ),
                ),

                // Features List
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Tính năng thông minh',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      _buildFeatureItem(
                        Icons.warning_amber_rounded,
                        'Cảnh báo rủi ro',
                        'Nhận biết thực phẩm chứa nhiều đường và chất béo xấu.',
                      ),
                      _buildFeatureItem(
                        Icons.restaurant_rounded,
                        'Thực đơn thay thế',
                        'Đề xuất các món ăn tương đương nhưng lành mạnh hơn.',
                      ),
                      _buildFeatureItem(
                        Icons.notifications_active_outlined,
                        'Nhắc nhở đúng lúc',
                        'Gợi ý uống nước và ăn nhẹ vào các khung giờ vàng.',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Bottom Button
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(24),
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
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF13EC5B),
                      foregroundColor: const Color(0xFF102216),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      elevation: 8,
                      shadowColor: const Color(0xFF13EC5B).withOpacity(0.4),
                    ),
                    child: const Text(
                      'Bắt đầu ngay',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String title, String desc) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0x0D13EC5B),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0x1A13EC5B)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Color(0x3313EC5B),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: const Color(0xFF13EC5B), size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Text(desc, style: const TextStyle(color: Colors.grey, fontSize: 13)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}