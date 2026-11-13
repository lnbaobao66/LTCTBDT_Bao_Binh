import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(const GreenSettingsApp());
}

class GreenSettingsApp extends StatelessWidget {
  const GreenSettingsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0F2316),
        primaryColor: const Color(0xFF06F957),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF06F957),
          surface: Color(0xFF1A2E21),
        ),
      ),
      home: const SettingsPage(),
    );
  }
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _darkMode = true;
  bool _biometrics = false;
  int _selectedIndex = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F2316).withOpacity(0.8),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Cài đặt',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Colors.white10,
            height: 1.0,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('ỨNG DỤNG'),
            _buildSectionContainer([
              _buildSettingItem(
                icon: Icons.translate,
                label: 'Ngôn ngữ',
                value: 'Tiếng Việt',
                onTap: () {},
              ),
              _buildSettingItem(
                icon: Icons.dark_mode,
                label: 'Chế độ tối',
                isToggle: true,
                toggleValue: _darkMode,
                onToggle: (val) => setState(() => _darkMode = val),
              ),
            ]),
            const SizedBox(height: 24),
            _buildSectionTitle('BẢO MẬT'),
            _buildSectionContainer([
              _buildSettingItem(
                icon: Icons.lock_outline,
                label: 'Đổi mật khẩu',
                onTap: () {
                  Navigator.pushNamed(context, '/change_password');
                },
              ),
              _buildSettingItem(
                icon: Icons.fingerprint,
                label: 'Sinh trắc học',
                isToggle: true,
                toggleValue: _biometrics,
                onToggle: (val) => setState(() => _biometrics = val),
              ),
            ]),
            const SizedBox(height: 24),
            _buildSectionTitle('HỖ TRỢ'),
            _buildSectionContainer([
              _buildSettingItem(
                icon: Icons.help_outline,
                label: 'Trung tâm trợ giúp',
                showExternal: true,
                onTap: () {},
              ),
              _buildSettingItem(
                icon: Icons.info_outline,
                label: 'Về ứng dụng',
                value: 'v2.4.0',
                showChevron: false,
                onTap: () {},
              ),
            ]),
            const SizedBox(height: 32),
            // Center(
            //   child: TextButton.icon(
            //     onPressed: () {},
            //     icon: const Icon(Icons.logout, color: Colors.red),
            //     label: const Text(
            //       'Đăng xuất',
            //       style: TextStyle(
            //         color: Colors.red,
            //         fontWeight: FontWeight.bold,
            //         fontSize: 16,
            //       ),
            //     ),
            //     style: TextButton.styleFrom(
            //       padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF0F2316),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF06F957),
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
        unselectedLabelStyle: const TextStyle(fontSize: 10),
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Trang chủ'),
          BottomNavigationBarItem(icon: Icon(Icons.book_outlined), label: 'Nhật ký'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Thống kê'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Cài đặt'),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF06F957),
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildSectionContainer(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF06F957).withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF06F957).withOpacity(0.1)),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String label,
    String? value,
    bool isToggle = false,
    bool toggleValue = false,
    bool showChevron = true,
    bool showExternal = false,
    Function(bool)? onToggle,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF06F957).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: const Color(0xFF06F957), size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            if (value != null)
              Text(
                value,
                style: const TextStyle(color: Colors.grey, fontSize: 14),
              ),
            const SizedBox(width: 8),
            if (isToggle)
              CupertinoSwitch(
                value: toggleValue,
                activeColor: const Color(0xFF06F957),
                onChanged: onToggle,
              )
            else if (showExternal)
              const Icon(Icons.open_in_new, color: Colors.grey, size: 18)
            else if (showChevron)
              const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}