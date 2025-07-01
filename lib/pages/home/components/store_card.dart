import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';

class StoreCard extends StatelessWidget {
  const StoreCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color ?? Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withAlpha(5),
            blurRadius: 4,
            spreadRadius: 0,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 第一行：名称、电话、导航
            Row(
              children: [
                Expanded(
                  child: Text(
                    '优品生活超市',
                    style: Theme.of(context).textTheme.titleMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                // 电话图标和号码
                InkWell(
                  onTap: () {},
                  child: Row(
                    children: [
                      Icon(Icons.phone_outlined, color: AppColors.textSecondary, size: 16),
                      const SizedBox(width: 2),
                      Text(
                        '13800138000',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                // 导航图标
                InkWell(
                  onTap: () {},
                  child: Row(
                    children: [
                      Icon(Icons.near_me_outlined, color: AppColors.textSecondary, size: 16),
                      const SizedBox(width: 2),
                      Text(
                        '导航',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 8),
            
            // 第二行：小标签
            Row(
              children: [
                _buildTag('到店自取', AppColors.primary),
                const SizedBox(width: 8),
                _buildTag('送货到家', AppColors.secondary),
              ],
            ),
            
            const SizedBox(height: 8),
            
            // 第三行：地址和距离
            Row(
              children: [
                Expanded(
                  child: Text(
                    '地址：北京市海淀区清华大学西门对面清华科技园3号楼101室',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '距您600m',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 6),
            
            // 第四行：营业时间
            Text(
              '营业时间：08:00-22:00',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
              ),
            ),
            
            const SizedBox(height: 6),
            
            // 第五行：提示超出服务范围
            Text(
              '当前地址超出服务范围',
              textAlign: TextAlign.start,
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTag(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),
      ),
    );
  }
} 