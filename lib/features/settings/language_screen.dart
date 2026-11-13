import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Health Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF06F957),
        scaffoldBackgroundColor: const Color(0xFF0F2316),
        textTheme: GoogleFonts.manropeTextTheme(ThemeData.dark().textTheme),
      ),
      home: const LanguageSelectionScreen(),
    );
  }
}

class Language {
  final String id;
  final String name;
  final String nativeName;
  final bool isAvailable;

  Language({
    required this.id,
    required this.name,
    required this.nativeName,
    required this.isAvailable,
  });
}

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  State<LanguageSelectionScreen> createState() => _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  String selectedId = 'vi';

  final List<Language> languages = [
    Language(id: 'vi', name: 'Tiếng Việt', nativeName: 'Vietnamese', isAvailable: true),
    Language(id: 'en', name: 'English', nativeName: 'English', isAvailable: true),
    Language(id: 'fr', name: 'Français', nativeName: 'French (Coming Soon)', isAvailable: false),
  ];

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF06F957);

    return Scaffold(
      body: Stack(
        children: [
          // Decorative Background Glows
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: primaryColor.withOpacity(0.05),
              ),
            ),
          ),
          Positioned(
            bottom: -100,
            left: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: primaryColor.withOpacity(0.1),
              ),
            ),
          ),
          
          // Main Content
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.chevron_left, size: 32),
                        onPressed: () {},
                      ),
                      const Expanded(
                        child: Center(
                          child: Text(
                            'Ngôn ngữ',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(width: 48), // Balance for back button
                    ],
                  ),
                ),
                const Divider(color: Colors.white10, height: 1),

                // Content
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Chọn Ngôn ngữ',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Vui lòng chọn ngôn ngữ bạn muốn sử dụng trong ứng dụng theo dõi sức khỏe AI.',
                          style: TextStyle(color: Colors.white60, fontSize: 14),
                        ),
                        const SizedBox(height: 32),
                        
                        // Language List
                        ...languages.map((lang) => _buildLanguageItem(lang, primaryColor)),
                      ],
                    ),
                  ),
                ),

                // Footer Button
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        foregroundColor: const Color(0xFF0F2316),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 8,
                        shadowColor: primaryColor.withOpacity(0.3),
                      ),
                      child: const Text(
                        'Xác nhận',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageItem(Language lang, Color primaryColor) {
    bool isSelected = selectedId == lang.id;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: InkWell(
        onTap: lang.isAvailable ? () => setState(() => selectedId = lang.id) : null,
        borderRadius: BorderRadius.circular(20),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected && lang.isAvailable
                  ? primaryColor
                  : Colors.white.withOpacity(0.05),
              width: 2,
            ),
            boxShadow: isSelected && lang.isAvailable
                ? [BoxShadow(color: primaryColor.withOpacity(0.1), blurRadius: 10)]
                : [],
          ),
          child: Opacity(
            opacity: lang.isAvailable ? 1.0 : 0.5,
            child: Row(
              children: [
                // Icon Container
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: isSelected && lang.isAvailable
                        ? primaryColor.withOpacity(0.2)
                        : Colors.white10,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.flag,
                    color: isSelected && lang.isAvailable ? primaryColor : Colors.white60,
                  ),
                ),
                const SizedBox(width: 16),
                
                // Text
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        lang.name,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text(
                        lang.nativeName,
                        style: const TextStyle(color: Colors.white38, fontSize: 13),
                      ),
                    ],
                  ),
                ),

                // Status Icon
                if (!lang.isAvailable)
                  const Icon(Icons.lock, color: Colors.white24)
                else if (isSelected)
                  Icon(Icons.check_circle, color: primaryColor)
                else
                  Icon(Icons.radio_button_unchecked, color: Colors.white.withOpacity(0.2)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}