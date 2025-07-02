import 'package:flutter/material.dart';
import 'package:flutter_render/theme/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NavCards extends StatelessWidget {
  const NavCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(24.w, 0, 24.w, 24.h),
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
              iconHeight: 120.h,
            ),
          ),
          SizedBox(width: 24.w),
          // 第二个卡片：摩葡商城
          Expanded(
            child: _buildNavCard(
              context,
              title: '摩葡商城',
              backgroundImage: 'images/send_to_home_bg.png',
              iconImage: 'images/send_to_home.png',
              subTitle: '送货到家',
              iconHeight: 140.h,
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
      height: 290.h,
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
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 标题和箭头
                Row(
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 32.sp,
                      ),
                    ),
                    Icon(
                      Icons.arrow_right,
                      color: AppColors.textPrimary,
                      size: 28.sp,
                    ),
                  ],
                ),

                Text(subTitle, style: TextStyle(color: AppColors.textSecondary, fontSize: 20.sp)),
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