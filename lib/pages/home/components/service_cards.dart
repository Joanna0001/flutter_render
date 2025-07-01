import 'package:flutter/material.dart';
import 'package:flutter_render/theme/app_colors.dart';

class ServiceCards extends StatelessWidget {
  const ServiceCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
      child: Row(
        children: [
          // 第一个卡片：我的卡券
          Expanded(
            child: _buildServiceCard(
              context,
              title: '我的卡券',
              backgroundImage: 'images/cupon.png',
            ),
          ),
          const SizedBox(width: 12),
          // 第二个卡片：我的订单
          Expanded(
            child: _buildServiceCard(
              context,
              title: '我的订单',
              backgroundImage: 'images/order.png',
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
      height: 100,
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
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(6),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              title,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
