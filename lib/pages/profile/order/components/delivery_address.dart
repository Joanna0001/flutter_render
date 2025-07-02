import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_render/theme/app_colors.dart';
import 'package:flutter_render/theme/app_theme.dart';

class DeliveryAddress extends StatelessWidget {
  const DeliveryAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(24.w),
      padding: EdgeInsets.all(24.w),
      decoration: AppTheme.cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '收货地址',
            style: TextStyle(
              fontSize: 32.sp,
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 24.h),
          Divider(height: 1.h, color: AppColors.borderSecondary),
          SizedBox(height: 24.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('images/address.png', width: 40.w, height: 40.w),
              SizedBox(width: 20.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '张三',
                          style: TextStyle(
                            fontSize: 28.sp,
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 20.w),
                        Text(
                          '13800138000',
                          style: TextStyle(
                            fontSize: 28.sp,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      '广东省深圳市南山区科技园南区科技南十二路2号金蝶软件园',
                      style: TextStyle(
                        fontSize: 24.sp,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
} 