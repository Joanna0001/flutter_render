import 'package:flutter/material.dart';
import 'package:flutter_render/theme/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartBottomBar extends StatelessWidget {
  final double totalPrice;
  final int itemCount;
  final VoidCallback onCheckout;

  const CartBottomBar({
    super.key,
    required this.totalPrice,
    required this.itemCount,
    required this.onCheckout,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 86.h,
      padding: EdgeInsets.only(left: 16.w),
      margin: EdgeInsets.symmetric(horizontal: 30.w),
      decoration: BoxDecoration(
        color: AppColors.textTertiary,
        borderRadius: BorderRadius.all(Radius.circular(20.w)),
      ),
      child: Row(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('images/mall/cart.png', width: 56.w, height: 56.w),
              Container(
                padding: EdgeInsets.all(8.w),
                margin: EdgeInsets.only(left: 8.w),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '$itemCount',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 40.w),
          Text(
            '¥${totalPrice.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 30.sp,
              color: Colors.white,
            ),
          ),
          const Spacer(),
          SizedBox(
            height: 86.h,
            child: ElevatedButton(
              onPressed: onCheckout,
              style: ElevatedButton.styleFrom(
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                backgroundColor: AppColors.primary,
                padding: EdgeInsets.symmetric(horizontal: 40.w),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.w)),
                ),
              ),
              child: Text(
                '下单',
                style: TextStyle(
                  fontSize: 30.sp,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
