import 'package:flutter/material.dart';
import 'package:flutter_render/theme/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_render/theme/app_theme.dart';

class ServiceCards extends StatelessWidget {
  const ServiceCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(24.w, 0, 24.w, 24.h),
      child: Row(
        children: [
          // 第一个卡片：我的卡券
          Expanded(
            child: _buildServiceCard(
              context,
              title: '我的卡券',
              backgroundImage: 'images/home/cupon.png',
            ),
          ),
          SizedBox(width: 24.w),
          // 第二个卡片：我的订单
          Expanded(
            child: _buildServiceCard(
              context,
              title: '我的订单',
              backgroundImage: 'images/home/order.png',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(
    BuildContext context, {
    required String title,
    required String backgroundImage,
  }) {
    return Container(
      height: 150.h,
      decoration: AppTheme.cardDecoration(backgroundImage: backgroundImage),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(6),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
            child: Text(
              title,
              style: TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 26.sp,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
