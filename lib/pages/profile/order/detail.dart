import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'components/order_status.dart';
import 'components/delivery_address.dart';
import 'components/order_goods.dart';
import 'components/order_amount.dart';
import 'components/bottom_actions.dart';

class OrderDetailPage extends StatelessWidget {
  final String orderId;

  const OrderDetailPage({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('订单详情')),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      const OrderStatus(),
                      Positioned(
                        top: 175.h,
                        left: 0,
                        right: 0,
                        child: const DeliveryAddress(),
                      ),
                    ],
                  ),
                  SizedBox(height: 150.h),
                  const OrderGoods(),
                  OrderAmount(orderId: orderId),
                ],
              ),
            ),
          ),
          const BottomActions(),
        ],
      ),
    );
  }
}
