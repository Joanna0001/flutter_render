import 'package:flutter/material.dart';
import 'package:flutter_render/pages/find_house/index.dart';
import 'package:flutter_render/pages/home/index.dart';
import 'package:flutter_render/pages/news/index.dart';
import 'package:flutter_render/pages/profile/index.dart';
import 'package:flutter_render/theme/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        selectedLabelStyle: TextStyle(
          color: AppColors.primary,
          fontSize: 22.sp,
        ),
        unselectedLabelStyle: TextStyle(
          color: AppColors.textSecondary,
          fontSize: 22.sp,
        ),
        items: [
          BottomNavigationBarItem(
            icon: _buildIcon('images/home.png', 'images/home_active.png', _currentIndex == 0),
            activeIcon: _buildIcon('images/home_active.png', 'images/home_active.png', _currentIndex == 0),
            label: '首页',
          ),
          BottomNavigationBarItem(
            icon: _buildIcon('images/mall.png', 'images/mall_active.png', _currentIndex == 1),
            activeIcon: _buildIcon('images/mall_active.png', 'images/mall_active.png', _currentIndex == 1),
            label: '商城',
          ),
          BottomNavigationBarItem(
            icon: _buildIcon('images/store.png', 'images/store_active.png', _currentIndex == 2),
            activeIcon: _buildIcon('images/store_active.png', 'images/store_active.png', _currentIndex == 2),
            label: '附近门店',
          ),
          BottomNavigationBarItem(
            icon: _buildIcon('images/my.png', 'images/my_active.png', _currentIndex == 3),
            activeIcon: _buildIcon('images/my_active.png', 'images/my_active.png', _currentIndex == 3),
            label: '我的',
          ),
        ],
      ),
    );
  }

  Widget _buildIcon(String iconPath, String activeIconPath, bool isActive) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5.h),
      child: Image(
        image: AssetImage(isActive ? activeIconPath : iconPath),
        width: 40.w,
        height: 40.w,
      ),
    );
  }
}
