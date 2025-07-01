import 'package:flutter/material.dart';
import 'package:flutter_render/theme/app_colors.dart';

class NavCards extends StatelessWidget {
  const NavCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
      child: Row(
        children: [
          // 第一个卡片：附近门店
          Expanded(
            child: _buildNavCard(
              context,
              title: '附近门店',
              backgroundImage: 'images/near_sort_bg.png',
              iconImage: 'images/near_sort.png',
              subTitle: '导航前往',
              iconHeight: 60,
            ),
          ),
          const SizedBox(width: 12),
          // 第二个卡片：摩葡商城
          Expanded(
            child: _buildNavCard(
              context,
              title: '摩葡商城',
              backgroundImage: 'images/send_to_home_bg.png',
              iconImage: 'images/send_to_home.png',
              subTitle: '送货到家',
              iconHeight: 70,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavCard(
    BuildContext context, {
    required String title,
    required String backgroundImage,
    required String iconImage,
    required String subTitle,
    required double iconHeight,
  }) {
    return Container(
      height: 140,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        image: DecorationImage(
          image: AssetImage(backgroundImage),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withAlpha(5),
            blurRadius: 4,
            spreadRadius: 0,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(6),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 标题和箭头
                Row(
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const Icon(
                      Icons.arrow_right,
                      color: AppColors.textPrimary,
                      size: 14,
                    ),
                  ],
                ),

                Text(subTitle, style: const TextStyle(color: AppColors.textSecondary, fontSize: 11)),
                const Spacer(),
                // 底部图标 - 居中显示
                Center(
                  child: Image.asset(
                    iconImage,
                    height: iconHeight,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
} 