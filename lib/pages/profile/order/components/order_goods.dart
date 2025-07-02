import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_render/theme/app_colors.dart';
import 'package:flutter_render/theme/app_theme.dart';

class OrderGoods extends StatelessWidget {
  const OrderGoods({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.w),
      padding: EdgeInsets.all(24.w),
      decoration: AppTheme.cardDecoration(),
      child: Column(
        children: [
          // 店铺信息
          Row(
            children: [
              Image.asset('images/app/store.png', width: 40.w, height: 40.w),
              SizedBox(width: 10.w),
              Text(
                '店铺名称',
                style: TextStyle(
                  fontSize: 28.sp,
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.arrow_forward_ios,
                size: 24.w,
                color: AppColors.textSecondary,
              ),
            ],
          ),
          SizedBox(height: 20.h),
          // 商品信息
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 160.w,
                height: 160.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.w),
                  color: AppColors.background,
                ),
              ),
              SizedBox(width: 20.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '商品名称商品名称商品名称商品名称',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 28.sp,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      '规格：默认',
                      style: TextStyle(
                        fontSize: 24.sp,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '¥99.00',
                          style: TextStyle(
                            fontSize: 28.sp,
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'x1',
                          style: TextStyle(
                            fontSize: 24.sp,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
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