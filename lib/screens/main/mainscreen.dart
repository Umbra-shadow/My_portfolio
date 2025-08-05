import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Assuming these are the paths to your screen widgets and other files
import '../../umbra_utils/design/color.dart';
import '../../umbra_utils/reusable/pText.dart';
import '../sub/main/about.dart';
import '../sub/main/contact.dart';
import '../sub/main/experience.dart';
import '../sub/main/home.dart';
import '../sub/main/resume.dart';
import '../sub/main/work.dart';

// --- MAIN SCREEN WITH RESPONSIVE LOGIC ---
class MainScreen extends StatefulWidget {
  final int? index;
  const MainScreen({super.key, this.index});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // --- STATE AND CONSTANTS ---
  late int selectedIndex;
  static const double _compactScreenBreakpoint =
      900.0; // Breakpoint for mobile layout
  static const double navSpacer = 20;

  // Navigation items and content widgets
  final List<String> navItems = [
    'Home',
    'About',
    'Experience',
    'Work',
    'Contact',
  ];
  final List<List<Widget>> mainContentWidgets = [
    [const HomeContent(isTablet: true), const HomeContent(isTablet: false)],
    [const AboutContent(isTablet: true), const AboutContent(isTablet: false)],
    [
      const ExperienceContent(isTablet: true),
      const ExperienceContent(isTablet: false),
    ],
    [const WorkContent(isTablet: true), const WorkContent(isTablet: false)],
    // Assuming a ContactContent widget exists
    [const ContactScreen(isTablet: true), const ContactScreen(isTablet: false)],
  ];

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.index ?? 0;
  }

  void _onNavItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
    // If on mobile, close the drawer after selection
    if (MediaQuery.of(context).size.width < _compactScreenBreakpoint) {
      Navigator.of(context).pop();
    }
  }

  void _navigateToResume() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ResumeScreen()),
    );
    // final url = Uri.parse('assets/assets/pdf/resume.pdf');
    // if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
    //   throw 'Could not launch resume';
    // }
    // ;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isCompact = constraints.maxWidth < _compactScreenBreakpoint;

        return Scaffold(
          appBar: _buildAppBar(isCompact),
          drawer: isCompact ? _buildMobileDrawer() : null,
          body: SafeArea(
            child: isCompact ? _buildCompactLayout() : _buildDesktopLayout(),
          ),
        );
      },
    );
  }

  AppBar _buildAppBar(bool isCompact) {
    return AppBar(
      title: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.portfolioPurple, width: 2),
        ),
        child: Text(
          'D',
          style: GoogleFonts.poppins(
            fontSize: 18,
            color: AppColors.portfolioPurple,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      centerTitle: false,
      actions: isCompact ? null : _buildDesktopAppBarActions(),
      actionsPadding: const EdgeInsets.only(right: 40, top: 10),
    );
  }

  List<Widget> _buildDesktopAppBarActions() {
    return [
      for (int i = 0; i < navItems.length; i++) ...[
        NavButton(
          text: navItems[i],
          number: "0${i + 1}.",
          isSelected: selectedIndex == i,
          onPressed: () => _onNavItemTapped(i),
        ),
        if (i != navItems.length - 1) const SizedBox(width: navSpacer),
      ],
      const SizedBox(width: 20),
      ElevatedButton(
        onPressed: _navigateToResume,
        style: ElevatedButton.styleFrom(
          foregroundColor: AppColors.portfolioPurple,
          backgroundColor: Colors.transparent,
          side: const BorderSide(color: AppColors.portfolioPurple, width: 1),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        child: Text('Resume', style: GoogleFonts.poppins()),
      ),
    ];
  }

  Widget _buildMobileDrawer() {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          for (int i = 0; i < navItems.length; i++)
            ListTile(
              leading: Text(
                "0${i + 1}.",
                style: GoogleFonts.robotoMono(color: AppColors.portfolioPurple),
              ),
              title: Text(navItems[i], style: GoogleFonts.poppins()),
              selected: selectedIndex == i,
              selectedTileColor: AppColors.portfolioPurple.withOpacity(0.1),
              onTap: () => _onNavItemTapped(i),
            ),
          const Divider(color: AppColors.slate),
          ListTile(
            leading: const Icon(
              Icons.article_outlined,
              color: AppColors.portfolioPurple,
            ),
            title: Text('Resume', style: GoogleFonts.poppins()),
            onTap: _navigateToResume,
          ),
        ],
      ),
    );
  }

  Widget _buildCompactLayout() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: SingleChildScrollView(child: mainContentWidgets[selectedIndex][1]),
    );
  }

  Widget _buildDesktopLayout() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: DeviceFrame(
              device: Devices.ios.iPad,
              screen: Column(
                children: [
                  Expanded(
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(color: Colors.white),
                      child: Column(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:
                                  mainContentWidgets[selectedIndex][0], // Tablet content
                            ),
                          ),
                          _buildTabletBottomNav(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              height: 700,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: SingleChildScrollView(
                child: mainContentWidgets[selectedIndex][1],
              ), // Desktop content
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabletBottomNav() {
    return Container(
      height: 80,
      width: double.infinity,
      decoration: const BoxDecoration(color: AppColors.portfolioPurple),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          for (int i = 0; i < navItems.length; i++)
            NavBarButton(
              text: navItems[i],
              isSelected: selectedIndex == i,
              onPressed: () => _onNavItemTapped(i),
            ),
        ],
      ),
    );
  }
}
