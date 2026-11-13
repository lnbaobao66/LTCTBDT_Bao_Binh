import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/widgets.dart';
// Nếu có sử dụng hình ảnh hoặc network, có thể thêm:
 import 'package:flutter/services.dart';
 import 'package:flutter/cupertino.dart';
 import 'package:fl_chart/fl_chart.dart';
 import 'package:google_fonts/google_fonts.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:lucide_icons/lucide_icons.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF102216),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Scanner'),
      ),
      body: Stack(
        children: [
          // 1. Camera Viewfinder (Simulated Background)
          Positioned.fill(
            child: Image.network(
              'https://lh3.googleusercontent.com/aida-public/AB6AXuA0FWfB2yQGZ04mi3vbIWJP9NWO5-2CnpEQQYT-nlqtDP0j8A9dbQE0GSLwaiyyRKTiha_GkkgmXhALAvksCTYZ1N89eTYt1WYfbjeZNrhI2QmTEPdCpH-xZywZPYy7Q63GjWYveMUeMe-tPUXun616g_BJ-xfwLWWAi5WfX_aMoz9xjzZ5fBobuxjDj8VmVFIP2jjRR_dwRMAgX4fFLCjk5xIGOAh8aCyO5jGLBA4J4KAdUy73DFoSPoA0knh0PXiGgBELNMsUFqw',
              fit: BoxFit.cover,
              color: Colors.black.withOpacity(0.4),
              colorBlendMode: BlendMode.darken,
            ),
          ),
          // 2. Quick Action Button (Quét mã)
          Positioned(
            bottom: 40,
            left: 24,
            right: 24,
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/qr_scan');
                },
                icon: const Icon(Icons.qr_code_scanner, color: Color(0xFF0F2316)),
                label: const Text('Quét mã'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF06F957),
                  foregroundColor: const Color(0xFF0F2316),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  textStyle: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          // 3. Scanner Frame & Animation
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  children: [
                    Container(
                      width: 280,
                      height: 200,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    _buildScannerCorners(),
                    AnimatedBuilder(
                      animation: _animationController,
                      builder: (context, child) {
                        return Positioned(
                          top: _animationController.value * 200,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 2,
                            decoration: BoxDecoration(
                              color: const Color(0xFF13ec5b),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF13ec5b).withOpacity(0.5),
                                  blurRadius: 10,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                _buildScanningStatus(),
              ],
            ),
          ),
          // 4. Viewfinder Controls
          Positioned(
            bottom: 200,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildControlItem(Icons.image, 'Gallery'),
                _buildMainCaptureButton(),
                _buildControlItem(Icons.edit_note, 'Manual'),
              ],
            ),
          ),
          // 5. Result Card
          Positioned(
            bottom: 100,
            left: 16,
            right: 16,
            child: _buildResultCard(context),
          ),
          // 6. Bottom Navigation
          Positioned(bottom: 0, left: 0, right: 0, child: _buildBottomNav()),
        ],
      ),
    );
  }
  }

  Widget _buildCircleButton(IconData icon) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Icon(icon, color: Colors.white, size: 20),
    );
  }

  Widget _buildScannerCorners() {
    return SizedBox(
      width: 280,
      height: 200,
      child: Stack(
        children: [
          // Top Left
          Positioned(top: 0, left: 0, child: _corner(top: true, left: true)),
          // Top Right
        Positioned(top: 0, right: 0, child: _corner(top: true, left: false)),
          // Bottom Left
          Positioned(bottom: 0, left: 0, child: _corner(top: false, left: true)),
          // Bottom Right
          Positioned(bottom: 0, right: 0, child: _corner(top: false, left: false)),
        ],
      ),
    );
  }


  Widget _corner({required bool top, required bool left}) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        border: Border(
          top: top
              ? const BorderSide(color: Color(0xFF13ec5b), width: 4)
              : BorderSide.none,
          bottom: !top
              ? const BorderSide(color: Color(0xFF13ec5b), width: 4)
              : BorderSide.none,
          left: left
              ? const BorderSide(color: Color(0xFF13ec5b), width: 4)
              : BorderSide.none,
          right: !left
              ? const BorderSide(color: Color(0xFF13ec5b), width: 4)
              : BorderSide.none,
        ),
        borderRadius: BorderRadius.only(
          topLeft: top && left ? const Radius.circular(12) : Radius.zero,
          topRight: top && !left ? const Radius.circular(12) : Radius.zero,
          bottomLeft: !top && left ? const Radius.circular(12) : Radius.zero,
          bottomRight: !top && !left ? const Radius.circular(12) : Radius.zero,
        ),
      ),
    );
  }

  Widget _buildScanningStatus() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFF13ec5b).withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFF13ec5b).withOpacity(0.3)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                width: 8,
                height: 8,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Color(0xFF13ec5b),
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'SCANNING...',
                style: TextStyle(
                  color: Color(0xFF13ec5b),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            'Position the barcode inside the frame to identify product',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildControlItem(IconData icon, String label) {
    return Column(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.4),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
        const SizedBox(height: 6),
        Text(
          label.toUpperCase(),
          style: const TextStyle(
            color: Colors.white60,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildMainCaptureButton() {
    return Container(
      width: 80,
      height: 80,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white.withOpacity(0.2), width: 4),
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFF102216), width: 2),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResultCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A2E21).withOpacity(0.95),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              'https://lh3.googleusercontent.com/aida-public/AB6AXuA1KRDD2-NPH1NcsMxIOxM2Umf0g1PyMJhnCtDBqeeQzSmb1D-cNJMwC6WjQ9-w0HXS9IBo-7Vdc5REz8XHum7TsuX_X3DheIRM8qihfGwn3WtbFsb1tHq74jkrxsbvPiBw5wLhFXkiviulkxh_DHDmhPteiP1uFnMaGr6f3GpxtG0eHuYaMuvGDg5FJLULa-AGUBbaOE70UE4PhzmTobN1Rhk_5J_QHNeEkQGQ0WyBnEFqWUTtEzV9-Y4XmmvRFC9moGcgpsEKExU',
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
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
                      'PRODUCT FOUND',
                      style: TextStyle(
                        color: Color(0xFF13ec5b),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      '1 serving = 150g',
                      style: TextStyle(color: Colors.white38, fontSize: 10),
                    ),
                  ],
                ),
                const Text(
                  'Avocado Toast with Poached Egg',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.local_fire_department,
                      color: Color(0xFF13ec5b),
                      size: 14,
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      '120 kcal',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(width: 1, height: 12, color: Colors.white10),
                    const SizedBox(width: 12),
                    const Text(
                      'High Protein',
                      style: TextStyle(color: Colors.white38, fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/nutrition_detail');
                  },
                  icon: const Icon(Icons.add_circle, size: 18),
                  label: const Text('Add to Log'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF13ec5b),
                    foregroundColor: const Color(0xFF102216),
                    minimumSize: const Size(double.infinity, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    textStyle: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      height: 90,
      padding: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: const Color(0xFF102216).withOpacity(0.8),
        border: const Border(top: BorderSide(color: Colors.white10)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navItem(Icons.calendar_today, 'Diary'),
          _navItem(Icons.qr_code_scanner, 'Scanner', active: true),
          _navItem(Icons.insights, 'Insights'),
          _navItem(Icons.person, 'Profile'),
        ],
      ),
    );
  }

  Widget _navItem(IconData icon, String label, {bool active = false}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: active ? const Color(0xFF13ec5b) : Colors.white30),
        const SizedBox(height: 4),
        Text(
          label.toUpperCase(),
          style: TextStyle(
            color: active ? const Color(0xFF13ec5b) : Colors.white30,
            fontSize: 10,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }

