import 'package:flutter/material.dart';
import 'package:memory_lane/screens/main/memories_grid_screen.dart';
import 'package:memory_lane/widgets/custom_bottom_navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    MemoriesGridScreen(),
    Center(child: Text("Tela Explore"),),
    Center(child: Text("Tela Settings"),)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _screens,),
      bottomNavigationBar: CustomNavigationBar(selectedIndex: _selectedIndex, onItemTapped: (value) {
        setState(() {
          _selectedIndex = value;
        });
      },),
    );
  }
}
