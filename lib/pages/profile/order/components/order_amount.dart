import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_render/theme/app_colors.dart';
import 'package:flutter_render/theme/app_theme.dart';

class OrderAmount extends StatelessWidget {
  final String orderId;

  const OrderAmount({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(24.w),
      padding: EdgeInsets.all(24.w),
      decoration: AppTheme.cardDecoration(),
      child: Column(
        children: [
          _buildAmountRow(label: '商品总价', amount: '¥99.00'),
          SizedBox(height: 16.h),
          _buildAmountRow(label: '运费', amount: '¥0.00'),
          SizedBox(height: 16.h),
          _buildAmountRow(label: '优惠券', amount: '-¥10.00'),
          SizedBox(height: 16.h),
          Divider(height: 1.h, color: AppColors.borderSecondary),
          SizedBox(height: 16.h),
          _buildAmountRow(label: '实付款', amount: '¥89.00', isPrimary: true),
          SizedBox(height: 24.h),
          _buildOrderDetailRow(context: context, label: '订单编号', value: orderId),
          SizedBox(height: 16.h),
          _buildOrderDetailRow(
            context: context,
            label: '创建时间',
            value: '2024-01-01 12:00:00',
          ),
          SizedBox(height: 16.h),
          _buildOrderDetailRow(context: context, label: '支付方式', value: '微信支付'),
        ],
      ),
    );
  }

  Widget _buildAmountRow({
    required String label,
    required String amount,
    bool isPrimary = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 28.sp, color: AppColors.textSecondary),
        ),
        Text(
          amount,
          style: TextStyle(
            fontSize: 28.sp,
            color: isPrimary ? AppColors.primary : AppColors.textPrimary,
            fontWeight: isPrimary ? FontWeight.w500 : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildOrderDetailRow({
    required String label,
    required String value,
    required BuildContext context,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 24.sp, color: AppColors.textSecondary),
        ),
        Row(
          children: [
            Text(
              value,
              style: TextStyle(fontSize: 24.sp, color: AppColors.textSecondary),
            ),
            if (label == '订单编号') ...[
              SizedBox(width: 8.w),
              GestureDetector(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: value));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('订单编号已复制'),
                      duration: const Duration(seconds: 1),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                child: Icon(
                  Icons.copy_outlined,
                  size: 28.w,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
} 