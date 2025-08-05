import 'package:flutter/material.dart';
import 'package:myportfolio/screens/main/mainscreen.dart';
import 'package:myportfolio/umbra_utils/design/color.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.portfolioSkyBlue,
        scaffoldBackgroundColor: AppColors.backgroundBlack,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.textSecondaryBlack,
          elevation: 0,
          centerTitle: true,
        ),
      ),
      home: const MainScreen(),
    );
  }
}
