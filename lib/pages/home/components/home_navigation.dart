import 'package:flutter/material.dart';
import 'package:flutter_render/theme/app_colors.dart';

class HomeNavigation extends StatelessWidget {
  const HomeNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    // 导航菜单数据
    final List<Map<String, dynamic>> navItems = [
      {'icon': Icons.home_outlined, 'title': '租赁'},
      {'icon': Icons.apartment, 'title': '合租'},
      {'icon': Icons.holiday_village_outlined, 'title': '地图找房'},
      {'icon': Icons.maps_home_work_outlined, 'title': '去出租'},
    ];

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      margin: const EdgeInsets.only(top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(4, (index) {
          return _buildNavItem(
            context,
            navItems[index]['icon'],
            navItems[index]['title'],
          );
        }),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, IconData icon, String title) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 4,
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Icon(icon, color: AppColors.primary, size: 28),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(fontSize: 12, color: AppColors.textPrimary),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
