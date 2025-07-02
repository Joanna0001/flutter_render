import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_render/theme/app_colors.dart';

class BottomActions extends StatelessWidget {
  const BottomActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(
        left: 30.w,
        right: 0,
        top: 0,
        bottom: MediaQuery.of(context).padding.bottom,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            '小计：',
            style: TextStyle(fontSize: 28.sp, color: AppColors.textSecondary),
          ),
          Text(
            '¥89.00',
            style: TextStyle(
              fontSize: 36.sp,
              color: AppColors.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          Row(
            children: [
              OutlinedButton(
                onPressed: () {
                  // TODO: 处理取消订单
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor: const Color(0xFFCF9EB0),
                  side: BorderSide.none,
                  padding: EdgeInsets.zero,
                  minimumSize: Size(220.w, 100.h),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  foregroundColor: Colors.white,
                ),
                child: Text(
                  '取消订单',
                  style: TextStyle(fontSize: 26.sp),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // TODO: 处理去支付
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: EdgeInsets.zero,
                  minimumSize: Size(220.w, 100.h),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  foregroundColor: Colors.white,
                ),
                child: Text(
                  '去支付',
                  style: TextStyle(fontSize: 26.sp),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
} 