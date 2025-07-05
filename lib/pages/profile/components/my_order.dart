import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_render/theme/app_colors.dart';
import 'package:flutter_render/theme/app_theme.dart';
import 'package:go_router/go_router.dart';

class MyOrder extends StatelessWidget {
  const MyOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.fromLTRB(24.w, 20.h, 24.w, 0),
      padding: EdgeInsets.only(top: 30.h),
      decoration: AppTheme.cardDecoration(),
      child: Column(
        children: [
          _buildTitle(context),
          SizedBox(height: 20.h),
          Divider(
            color: AppColors.borderSecondary,
            thickness: 1.w,
            height: 0.5.w,
          ),
          SizedBox(height: 30.h),
          _buildOrderTypes(context),
          SizedBox(height: 30.h),
          _buildFunctionItem('我的优惠券', 'images/profile/my_cupon.png'),
          _buildFunctionItem('领取优惠券', 'images/profile/get_cupon.png'),
          _buildFunctionItem('地址管理', 'images/profile/address.png'),
        ],
      ),
    );
  }

  // 标题栏
  Widget _buildTitle(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '我的订单',
            style: TextStyle(fontSize: 30.sp, color: AppColors.textTertiary),
          ),
          InkWell(
            onTap: () => context.push('/order?initialTabIndex=0'),
            child: Row(
              children: [
                Text(
                  '全部订单',
                  style: TextStyle(
                    fontSize: 28.sp,
                    color: AppColors.textQuaternary,
                  ),
                ),
                SizedBox(width: 5.w),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 24.sp,
                  color: AppColors.textSecondary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 订单类型
  Widget _buildOrderTypes(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: _buildOrderItem(
              context,
              'images/profile/order_to_pay.png',
              '待付款',
              1,
            ),
          ),
          Expanded(
            child: _buildOrderItem(
              context,
              'images/profile/order_to_ship.png',
              '待发货',
              2,
            ),
          ),
          Expanded(
            child: _buildOrderItem(
              context,
              'images/profile/order_to_receive.png',
              '待收货',
              3,
            ),
          ),
          Expanded(
            child: _buildOrderItem(
              context,
              'images/profile/order_completed.png',
              '已完成',
              4,
            ),
          ),
          VerticalDivider(
            color: AppColors.borderSecondary,
            thickness: 1.5.w,
            indent: 10.h, // 顶部缩进距离
            endIndent: 10.h, // 底部缩进距离
          ),
          Expanded(
            child: _buildOrderItem(
              context,
              'images/profile/order_return.png',
              '退换/售后',
              0,
            ),
          ),
        ],
      ),
    );
  }

  // 订单类型项
  Widget _buildOrderItem(
    BuildContext context,
    String icon,
    String title,
    int initialTabIndex,
  ) {
    return GestureDetector(
      onTap: () => context.push('/order?initialTabIndex=$initialTabIndex'),
      child: Column(
        children: [
          Container(
            width: 60.w,
            height: 60.w,
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(40.w),
            ),
            child: Image.asset(icon),
          ),
          SizedBox(height: 10.h),
          Text(
            title,
            style: TextStyle(fontSize: 24.sp, color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }

  // 功能项
  Widget _buildFunctionItem(String title, String image) {
    return GestureDetector(
      onTap: () {
        // 处理点击事件
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 25.h),
        child: Row(
          children: [
            Image.asset(image, width: 40.w, height: 40.w),
            SizedBox(width: 20.w),
            Text(
              title,
              style: TextStyle(fontSize: 28.sp, color: AppColors.textTertiary),
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              size: 24.sp,
              color: AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }
}
