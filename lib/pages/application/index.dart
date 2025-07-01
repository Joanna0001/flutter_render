import 'package:flutter/material.dart';
import 'package:flutter_render/pages/find_house/index.dart';
import 'package:flutter_render/pages/home/index.dart';
import 'package:flutter_render/pages/news/index.dart';
import 'package:flutter_render/pages/profile/index.dart';
import 'package:flutter_render/theme/app_colors.dart';


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
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
        items: [
          BottomNavigationBarItem(
            icon: NavIcon(
              iconPath: 'images/home.png',
              activeIconPath: 'images/home_active.png',
              isActive: _currentIndex == 0,
            ),
            label: '首页',
          ),
          BottomNavigationBarItem(
            icon: NavIcon(
              iconPath: 'images/mall.png',
              activeIconPath: 'images/mall_active.png',
              isActive: _currentIndex == 1,
            ),
            label: '商城',
          ),
          BottomNavigationBarItem(
            icon: NavIcon(
              iconPath: 'images/store.png',
              activeIconPath: 'images/store_active.png',
              isActive: _currentIndex == 2,
            ),
            label: '附近门店',
          ),
          BottomNavigationBarItem(
            icon: NavIcon(
              iconPath: 'images/my.png',
              activeIconPath: 'images/my_active.png',
              isActive: _currentIndex == 3,
            ),
            label: '我的',
          ),
        ],
      ),
    );
  }
}

// 导航栏图标组件
class NavIcon extends StatelessWidget {
  final String iconPath;
  final String activeIconPath;
  final bool isActive;
  final double size;

  const NavIcon({
    super.key,
    required this.iconPath,
    required this.activeIconPath,
    required this.isActive,
    this.size = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      isActive ? activeIconPath : iconPath,
      width: size,
      height: size,
      color: isActive ? AppColors.primary : null,
    );
  }
}