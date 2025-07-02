import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_render/theme/app_colors.dart';
import 'package:flutter_render/theme/app_theme.dart';
import 'package:flutter_render/pages/profile/order/list.dart';

class MyOrder extends StatefulWidget {
  const MyOrder({super.key});

  @override
  State<MyOrder> createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.fromLTRB(24.w, 20.h, 24.w, 0),
      padding: EdgeInsets.only(top: 30.h),
      decoration: AppTheme.cardDecoration(),
      child: Column(
        children: [
          _buildTitle(),
          SizedBox(height: 20.h),
          Divider(color: AppColors.borderSecondary, thickness: 1.w, height: 0.5.w),
          SizedBox(height: 30.h),
          _buildOrderTypes(),
          SizedBox(height: 30.h),
          _buildFunctionItem('我的优惠券', 'images/my_cupon.png'),
          _buildFunctionItem('领取优惠券', 'images/get_cupon.png'),
          _buildFunctionItem('地址管理', 'images/address.png'),
        ],
      ),
    );
  }

  // 标题栏
  Widget _buildTitle() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '我的订单',
            style: TextStyle(
              fontSize: 30.sp,
              color: AppColors.textTertiary,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const OrderListPage(initialTabIndex: 0),
                ),
              );
            },
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
  Widget _buildOrderTypes() {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: _buildOrderTypeItem('待付款', "images/order_to_pay.png")),
          Expanded(child: _buildOrderTypeItem('待发货', "images/order_to_ship.png")),
          Expanded(child: _buildOrderTypeItem('待收货', "images/order_to_receive.png")),
          Expanded(child: _buildOrderTypeItem('已完成', "images/order_completed.png")),
          VerticalDivider(
            color: AppColors.borderSecondary,
            thickness: 1.5.w,
            indent: 10.h, // 顶部缩进距离
            endIndent: 10.h, // 底部缩进距离
          ),
          Expanded(child: _buildOrderTypeItem('退货', "images/order_return.png")),
        ],
      ),
    );
  }

  // 订单类型项
  Widget _buildOrderTypeItem(String title, String image) {
    return GestureDetector(
      onTap: () {
        // 根据订单类型跳转到对应的订单列表页面
        int initialIndex = 0;
        switch (title) {
          case '待付款':
            initialIndex = 1;
            break;
          case '待发货':
            initialIndex = 2;
            break;
          case '待收货':
            initialIndex = 3;
            break;
          case '已完成':
            initialIndex = 4;
            break;
          case '退货':
            initialIndex = 5;
            break;
        }
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OrderListPage(initialTabIndex: initialIndex),
          ),
        );
      },
      child: Column(
        children: [
          Container(
            width: 60.w,
            height: 60.w,
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(40.w),
            ),
            child: Image.asset(image),
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
            Image.asset(
              image,
              width: 40.w,
              height: 40.w,
            ),
            SizedBox(width: 20.w),
            Text(
              title,
              style: TextStyle(
                fontSize: 28.sp,
                color: AppColors.textTertiary,
              ),
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
