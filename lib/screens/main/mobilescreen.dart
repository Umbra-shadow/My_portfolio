import 'package:device_frame/device_frame.dart';
import 'package:flutter/material.dart';
// Assuming these are the paths to your screen widgets
import 'package:myportfolio/screens/sub/sub/chat.dart';
import 'package:myportfolio/screens/sub/sub/poem.dart';
import 'package:myportfolio/screens/sub/sub/suggestion.dart';

import '../../umbra_utils/reusable/icons.dart'; // Ensure this path is correct
import 'mainscreen.dart';

class AppDetails {
  final String image;
  final String name;
  final Widget screen;
  final bool isPortfolio;

  AppDetails({
    required this.image,
    required this.name,
    required this.screen,
    this.isPortfolio = false,
  });
}

class Mobilescreen extends StatefulWidget {
  const Mobilescreen({super.key});

  @override
  State<Mobilescreen> createState() => _MobilescreenState();
}

class _MobilescreenState extends State<Mobilescreen> {
  int? _selectedScreenIndex;

  // Updated list with the 'isPortfolio' flag
  final List<AppDetails> _apps = [
    AppDetails(
      image: 'portfolio.png',
      name: 'My Portfolio',
      screen: const MainScreen(),
      isPortfolio: true,
    ),
    AppDetails(image: 'chat.png', name: 'Let Chat', screen: const ChatScreen()),
    AppDetails(
      image: 'suggestion.png',
      name: 'Suggestions',
      screen: const SuggestionScreen(),
    ),
    AppDetails(image: 'poem.png', name: 'Poems', screen: const PoemScreen()),
  ];

  void _selectScreen(int index) {
    if (_apps[index].isPortfolio) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => _apps[index].screen),
      );
    } else {
      setState(() {
        _selectedScreenIndex = index;
      });
    }
  }

  void _goToHomeScreen() {
    setState(() {
      _selectedScreenIndex = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: DeviceFrame(
              device: Devices.ios.iPad,
              screen: _buildScreenContent(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildScreenContent() {
    if (_selectedScreenIndex == null) {
      return _buildHomeScreen();
    } else {
      return Stack(
        fit: StackFit.expand,
        children: [
          _apps[_selectedScreenIndex!].screen,
          Positioned(
            top: 13,
            left: 13,
            child: FloatingActionButton(
              onPressed: _goToHomeScreen,
              mini: true,
              backgroundColor: Colors.black.withOpacity(0.5),
              foregroundColor: Colors.white,
              child: const Icon(Icons.arrow_back_ios_new, size: 16),
            ),
          ),
        ],
      );
    }
  }

  Widget _buildHomeScreen() {
    return Stack(
      children: [
        Image.asset(
          'images/back.jpg',
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
        Center(
          child: Container(
            alignment: Alignment.center,
            height: 220,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: _apps.length,
              itemBuilder: (context, index) {
                return IconsDesign(
                  path: _apps[index].image,
                  name: _apps[index].name,
                  onTap: () => _selectScreen(index),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
