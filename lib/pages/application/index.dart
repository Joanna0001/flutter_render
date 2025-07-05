import 'package:flutter/material.dart';
import 'package:flutter_render/theme/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ApplicationPage extends StatelessWidget {
  const ApplicationPage({super.key, required this.child});

  final Widget child;

  // 根据当前路由计算currentIndex
  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();
    if (location.startsWith('/home')) {
      return 0;
    }
    if (location.startsWith('/mall')) {
      return 1;
    }
    if (location.startsWith('/store')) {
      return 2;
    }
    if (location.startsWith('/profile')) {
      return 3;
    }
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go('/home');
        break;
      case 1:
        context.go('/mall');
        break;
      case 2:
        context.go('/store');
        break;
      case 3:
        context.go('/profile');
        break;
    }
  }

  Widget _buildIcon(String iconPath) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5.h),
      child: Image.asset(iconPath, width: 40.w, height: 40.w),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: _buildIcon('images/app/home.png'),
            activeIcon: _buildIcon('images/app/home_active.png'),
            label: '首页',
          ),
          BottomNavigationBarItem(
            icon: _buildIcon('images/app/mall.png'),
            activeIcon: _buildIcon('images/app/mall_active.png'),
            label: '商城',
          ),
          BottomNavigationBarItem(
            icon: _buildIcon('images/app/store.png'),
            activeIcon: _buildIcon('images/app/store_active.png'),
            label: '门店',
          ),
          BottomNavigationBarItem(
            icon: _buildIcon('images/app/my.png'),
            activeIcon: _buildIcon('images/app/my_active.png'),
            label: '我的',
          ),
        ],
        currentIndex: _calculateSelectedIndex(context),
        onTap: (index) => _onItemTapped(index, context),
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(
          color: AppColors.primary,
          fontSize: 22.sp,
        ),
        unselectedLabelStyle: TextStyle(
          color: AppColors.textSecondary,
          fontSize: 22.sp,
        ),
      ),
    );
  }
}
