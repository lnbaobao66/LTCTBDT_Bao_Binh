
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';

class SignUpScreen extends StatefulWidget {
    static String? registeredEmail;
    static String? registeredPassword;
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _obscurePassword = true;
  bool _agreeToTerms = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Hiệu ứng Glow trang trí
          Positioned(
            bottom: -100,
            left: -100,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF13EC5B).withOpacity(0.1),
              ),
            ),
          ),
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF13EC5B).withOpacity(0.05),
              ),
            ),
          ),
          
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  // Logo BarChart
                  Center(
                    child: Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: const Color(0xFF13EC5B).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFF13EC5B).withOpacity(0.3),
                        ),
                      ),
                      child: const Icon(
                        LucideIcons.barChart3,
                        color: Color(0xFF13EC5B),
                        size: 32,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Tạo tài khoản mới',
                    style: GoogleFonts.manrope(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Khởi đầu hành trình sống khỏe cùng AI',
                    style: GoogleFonts.manrope(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[400],
                    ),
                  ),
                  const SizedBox(height: 40),
                  
                  // Form nhập liệu
                  _buildInputField(
                    label: 'Họ và tên',
                    hint: 'Nguyễn Văn A',
                    icon: LucideIcons.user,
                    controller: _nameController,
                  ),
                  const SizedBox(height: 20),
                  _buildInputField(
                    label: 'Email',
                    hint: 'example@gmail.com',
                    icon: LucideIcons.mail,
                    controller: _emailController,
                  ),
                  const SizedBox(height: 20),
                  _buildPasswordField(controller: _passwordController),
                  const SizedBox(height: 20),
                  
                  // Điều khoản
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 24,
                        width: 24,
                        child: Checkbox(
                          value: _agreeToTerms,
                          onChanged: (val) => setState(() => _agreeToTerms = val!),
                          activeColor: const Color(0xFF13EC5B),
                          checkColor: const Color(0xFF102216),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          side: BorderSide(color: Colors.grey[700]!),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style: GoogleFonts.manrope(
                              fontSize: 14,
                              color: Colors.grey[400],
                            ),
                            children: const [
                              TextSpan(text: 'Tôi đồng ý với các '),
                              TextSpan(
                                text: 'Điều khoản',
                                style: TextStyle(color: Color(0xFF13EC5B), fontWeight: FontWeight.bold),
                              ),
                              TextSpan(text: ' và '),
                              TextSpan(
                                text: 'Chính sách bảo mật',
                                style: TextStyle(color: Color(0xFF13EC5B), fontWeight: FontWeight.bold),
                              ),
                              TextSpan(text: ' của ứng dụng.'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Nút Đăng ký
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        final name = _nameController.text.trim();
                        final email = _emailController.text.trim();
                        final password = _passwordController.text.trim();

                        final nameRegExp = RegExp(r'^[a-zA-ZÀ-ỹ\s]+$');
                        if (name.isEmpty || email.isEmpty || password.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Vui lòng điền đầy đủ thông tin!',
                                style: GoogleFonts.manrope(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              backgroundColor: const Color.fromARGB(255, 56, 122, 56),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                          return;
                        }
                        if (!nameRegExp.hasMatch(name) || name.split(' ').length < 2) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Họ và tên phải gồm ít nhất 2 từ, không chứa số hoặc ký tự đặc biệt!',
                                style: GoogleFonts.manrope(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              backgroundColor: const Color.fromARGB(255, 56, 122, 56),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                          return;
                        }
                        // Kiểm tra email chỉ nhận @gmail.com
                        final emailRegExp = RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$');
                        if (!emailRegExp.hasMatch(email)) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Chỉ chấp nhận email đúng định dạng @gmail.com!',
                                style: GoogleFonts.manrope(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              backgroundColor: const Color.fromARGB(255, 56, 122, 56),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                          return;
                        }
                        if (!_agreeToTerms) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Bạn cần đồng ý với điều khoản và chính sách bảo mật!',
                                style: GoogleFonts.manrope(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              backgroundColor: const Color.fromARGB(255, 56, 122, 56),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                          return;
                        }
                        // Lưu email và mật khẩu đã đăng ký
                        SignUpScreen.registeredEmail = email;
                        SignUpScreen.registeredPassword = password;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Đăng ký thành công!',
                              style: GoogleFonts.manrope(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            backgroundColor: const Color(0xFF13EC5B),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                        Future.delayed(const Duration(seconds: 2), () {
                          Navigator.pushNamed(context, '/login');
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF13EC5B),
                        foregroundColor: const Color(0xFF102216),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 8,
                        shadowColor: const Color(0xFF13EC5B).withOpacity(0.4),
                      ),
                      child: Text(
                        'Đăng ký',
                        style: GoogleFonts.manrope(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Dòng kẻ phân cách
                  Row(
                    children: [
                      Expanded(child: Divider(color: Colors.grey[800])),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'HOẶC ĐĂNG KÝ BẰNG',
                          style: GoogleFonts.manrope(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[600],
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                      Expanded(child: Divider(color: Colors.grey[800])),
                    ],
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Nút mạng xã hội
                  Row(
                    children: [
                      Expanded(
                        child: _buildSocialButton(
                          icon: Image.network(
                            'https://lh3.googleusercontent.com/aida-public/AB6AXuDPwfTrdFOKSXUaz7ydGBVIXOvAifAXmD5ysCetO87G9pafTaLeUbP94ywZzBSiEWPX82gfG7TK7XVwu5JXWtGjYEe_1NRhgBdBgXzhRPVU8L_WxOsicKWosB146TRQwwzVHw_WCT5fg92OE0DHh-DTggAlkIgMXozvNJgwtRI58X6zT5D9dzd71GlcftZYwA4X1uz5s613r3T1gGlERuXkk8rPJ7wmJeLatVoLk2Ij0ddcsgz5YyQVikEfF1KK068wX5ynryu4feE',
                            width: 20,
                          ),
                          label: 'Google',
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildSocialButton(
                          icon: const Icon(LucideIcons.apple, color: Colors.white, size: 20),
                          label: 'Apple',
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 48),
                  
                  // Footer
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Đã có tài khoản?',
                        style: GoogleFonts.manrope(
                          fontSize: 14,
                          color: Colors.grey[400],
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        child: Text(
                          'Đăng nhập ngay',
                          style: GoogleFonts.manrope(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF13EC5B),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField({required String label, required String hint, required IconData icon, required TextEditingController controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            label,
            style: GoogleFonts.manrope(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey[300],
            ),
          ),
        ),
        TextField(
          controller: controller,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey[600]),
            prefixIcon: Icon(icon, color: Colors.grey[500], size: 20),
            filled: true,
            fillColor: Colors.grey[800]!.withOpacity(0.4),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.grey[700]!.withOpacity(0.5)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xFF13EC5B)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField({required TextEditingController controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            'Mật khẩu',
            style: GoogleFonts.manrope(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey[300],
            ),
          ),
        ),
        TextField(
          controller: controller,
          obscureText: _obscurePassword,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: '••••••••',
            hintStyle: TextStyle(color: Colors.grey[600]),
            prefixIcon: Icon(LucideIcons.lock, color: Colors.grey[500], size: 20),
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? LucideIcons.eyeOff : LucideIcons.eye,
                color: Colors.grey[500],
                size: 20,
              ),
              onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
            ),
            filled: true,
            fillColor: Colors.grey[800]!.withOpacity(0.4),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.grey[700]!.withOpacity(0.5)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xFF13EC5B)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialButton({required Widget icon, required String label}) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: Colors.grey[800]!.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[800]!),
      ),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.manrope(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.grey[200],
              ),
            ),
          ],
        ),
      ),
    );
  }
}