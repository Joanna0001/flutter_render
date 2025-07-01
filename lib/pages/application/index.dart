import 'package:flutter/material.dart';
import 'package:flutter_render/pages/find_house/index.dart';
import 'package:flutter_render/pages/home/index.dart';
import 'package:flutter_render/pages/news/index.dart';
import 'package:flutter_render/pages/profile/index.dart';

class ApplicationPage extends StatefulWidget {
  const ApplicationPage({super.key});

  @override
  State<ApplicationPage> createState() => _ApplicationPageState();
}

class _ApplicationPageState extends State<ApplicationPage> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    const HomePage(),
    const FindHousePage(),
    const NewsPage(),
    const ProfilePage(),
  ];

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: _onTap,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '首页',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '找房',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: '资讯',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '我的',
          ),
        ],
      ),
    );
  }
} 