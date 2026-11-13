import 'package:flutter/material.dart';
import 'package:btl_mobile/core/services/user_manager.dart';

class ProfileEditorScreen extends StatefulWidget {
  const ProfileEditorScreen({super.key});

  @override
  State<ProfileEditorScreen> createState() => _ProfileEditorScreenState();
}

class _ProfileEditorScreenState extends State<ProfileEditorScreen> {
  String _activityLevel = 'moderate';
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _heightController;
  late final TextEditingController _weightController;

  @override
  void initState() {
    super.initState();
    final userManager = UserManager();
    _nameController = TextEditingController(text: userManager.name);
    _emailController = TextEditingController(text: userManager.email);
    _heightController = TextEditingController(text: userManager.height.toString());
    _weightController = TextEditingController(text: userManager.weight.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F2316),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Chỉnh sửa hồ sơ',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: Colors.white10, height: 1),
        ),
      ),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 100),
            children: [
              // Ảnh đại diện
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
                            border: Border.all(color: const Color(0xFF06F957).withOpacity(0.2), width: 4),
                            image: const DecorationImage(
                              image: NetworkImage('https://lh3.googleusercontent.com/aida-public/AB6AXuDgfZx8Q95mlHdqybze8ZGrpmNcwv_wDPwiZvq2a349SN4N1amTd8IvPvfJTLkEfr7kdZdbpTuYYDKeY2qG3UM70cbDKDWDVLwl5zkhj2w8zGb6VWR3L6hsIDGqY0aNXigNok6bSslP38qcw3yoUNCDifelNYlN1-w0EP6Qg9VLESUiFb5BzKJZd7xBBOvNvD74VufRvB4lQROJmVEmeawxf9W8_Ki8WBkKD180OUXQMkpuL8G4MfXyRkDoR-Z7F2WbeGgpbWj8-5s'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFF06F957),
                              shape: BoxShape.circle,
                              border: Border.all(color: const Color(0xFF0F2316), width: 2),
                            ),
                            child: const Icon(Icons.camera_alt, size: 16, color: Color(0xFF0F2316)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text('Ảnh đại diện', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF06F957),
                        side: BorderSide(color: const Color(0xFF06F957).withOpacity(0.2)),
                        backgroundColor: const Color(0xFF06F957).withOpacity(0.1),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      ),
                      child: const Text('Thay đổi ảnh', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              // Thông tin cá nhân
              _buildSectionTitle('THÔNG TIN CÁ NHÂN'),
              const SizedBox(height: 16),
              _buildTextField('Họ tên', _nameController),
              const SizedBox(height: 16),
              _buildTextField('Email', _emailController),
              const SizedBox(height: 32),

              // Chỉ số cơ thể
              _buildSectionTitle('CHỈ SỐ CƠ THỂ'),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(child: _buildTextField('Chiều cao (cm)', _heightController, suffix: 'cm')),
                  const SizedBox(width: 16),
                  Expanded(child: _buildTextField('Cân nặng (kg)', _weightController, suffix: 'kg')),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(child: _buildTextField('Ngày sinh', TextEditingController(text: '29/10/2005'), icon: Icons.calendar_today)),
                  const SizedBox(width: 16),
                  Expanded(child: _buildTextField('Giới tính', TextEditingController(text: 'Nam'), icon: Icons.keyboard_arrow_down)),
                ],
              ),
              const SizedBox(height: 32),

              // Mức độ hoạt động
              _buildSectionTitle('MỨC ĐỘ HOẠT ĐỘNG'),
              const SizedBox(height: 16),
              _buildActivityOption('sedentary', 'Ít vận động (Sedentary)', 'Công việc văn phòng, ít tập luyện'),
              const SizedBox(height: 12),
              _buildActivityOption('moderate', 'Vừa phải (Moderate)', 'Tập luyện 3-5 ngày mỗi tuần'),
              const SizedBox(height: 12),
              _buildActivityOption('active', 'Năng động (Active)', 'Tập luyện cường độ cao hàng ngày'),
            ],
          ),

          // Nút Lưu thay đổi cố định
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF0F2316).withOpacity(0.8),
                border: const Border(top: BorderSide(color: Colors.white10)),
              ),
              child: ElevatedButton(
                onPressed: () {
                  final userManager = UserManager();
                  userManager.name = _nameController.text;
                  userManager.email = _emailController.text;
                  final height = double.tryParse(_heightController.text) ?? userManager.height;
                  final weight = double.tryParse(_weightController.text) ?? userManager.weight;
                  userManager.height = height;
                  userManager.weight = weight;
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF06F957),
                  foregroundColor: const Color(0xFF0F2316),
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 8,
                  shadowColor: const Color(0xFF06F957).withOpacity(0.4),
                ),
                child: const Text('Lưu thay đổi', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Color(0xFF06F957),
        fontSize: 12,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.2,
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {String? suffix, IconData? icon}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(label, style: const TextStyle(color: Colors.white60, fontSize: 14)),
        ),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white.withOpacity(0.05),
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            suffixText: suffix,
            suffixIcon: icon != null ? Icon(icon, color: Colors.white38) : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xFF06F957)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActivityOption(String id, String title, String subtitle) {
    bool isSelected = _activityLevel == id;
    return GestureDetector(
      onTap: () => setState(() => _activityLevel = id),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF06F957).withOpacity(0.1) : Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? const Color(0xFF06F957) : Colors.white.withOpacity(0.1),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: const TextStyle(color: Colors.white38, fontSize: 13)),
                ],
              ),
            ),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? const Color(0xFF06F957) : Colors.white24,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: const BoxDecoration(color: Color(0xFF06F957), shape: BoxShape.circle),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}