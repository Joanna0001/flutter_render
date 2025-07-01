import 'package:flutter/material.dart';
import 'package:flutter_render/theme/app_colors.dart';

class HomeRecommend extends StatelessWidget {
  const HomeRecommend({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(top: 10.0),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 标题
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '房屋推荐',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              TextButton(
                onPressed: () {
                  // 更多按钮点击事件
                },
                child: Row(
                  children: [
                    const Text(
                      '更多',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                      color: AppColors.textSecondary,
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          // 推荐列表
          Column(
            children: List.generate(3, (index) {
              return _buildRecommendItem();
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendItem() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.divider,
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 左侧图片
          ClipRRect(
            borderRadius: BorderRadius.circular(4.0),
            child: Image.asset(
              'images/banner_1.png', // 使用占位图
              width: 120,
              height: 90,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          
          // 右侧信息
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 标题
                const Text(
                  '阳光花园 精装修三居室 南北通透',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                
                // 房屋信息
                const Row(
                  children: [
                    Text(
                      '3室2厅',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      '89㎡',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      '南北',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                
                // 位置信息
                const Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 12,
                      color: AppColors.textHint,
                    ),
                    SizedBox(width: 2),
                    Expanded(
                      child: Text(
                        '朝阳区 望京 阳光花园小区',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textHint,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                
                // 价格
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '580',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                        Text(
                          ' 万',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: const Text(
                        '精装修',
                        style: TextStyle(
                          fontSize: 10,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 