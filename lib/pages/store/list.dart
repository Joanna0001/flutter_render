import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_render/theme/app_colors.dart';
import 'package:flutter_render/theme/app_theme.dart';
import 'package:flutter_render/theme/gradient_button.dart';

class StoreListPage extends StatelessWidget {
  const StoreListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('附近门店'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        itemCount: 10, // 模拟10个商家数据
        itemBuilder: (context, index) {
          // 随机生成超出服务范围状态，实际应用中应该根据真实数据
          final isOutOfServiceRange = index % 2 == 0;
          return _buildStoreItem(context, isOutOfServiceRange: isOutOfServiceRange);
        },
      ),
    );
  }

  Widget _buildStoreItem(BuildContext context, {bool isOutOfServiceRange = false}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      decoration: AppTheme.cardDecoration(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 第一行：名称和距离
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
                // 距离移到右上角
                Text(
                  '距您600m',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 22.sp,
                  ),
                ),
              ],
            ),
            
            SizedBox(height: 16.h),
            
            // 第二行：小标签
            Row(
              children: [
                _buildTag('到店自取', AppColors.primary, isOutlined: true),
                SizedBox(width: 16.w),
                _buildTag('送货到家', AppColors.secondary, isOutlined: true),
              ],
            ),
            
            SizedBox(height: 16.h),
            
            // 第三行：地址
            Text(
              '地址：北京市海淀区清华大学西门对面清华科技园3号楼101室',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 22.sp,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            
            SizedBox(height: 8.h),
            
            // 第四行：营业时间
            Text(
              '营业时间：08:00-22:00',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 22.sp,
              ),
            ),
            
            SizedBox(height: 16.h),
            
            // 底部操作区：联系电话、导航图标文字
            Row(
              children: [
                // 电话图标和号码
                Expanded(
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Row(
                          children: [
                            Icon(Icons.phone_outlined, color: AppColors.textSecondary, size: 32.sp),
                            SizedBox(width: 4.w),
                            Text(
                              '13800138000',
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 24.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 32.w),
                      // 导航图标
                      InkWell(
                        onTap: () {},
                        child: Row(
                          children: [
                            Icon(Icons.near_me_outlined, color: AppColors.textSecondary, size: 32.sp),
                            SizedBox(width: 4.w),
                            Text(
                              '导航',
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 24.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                
                // 根据状态显示"超出服务范围"或"进店逛逛"按钮
                if (isOutOfServiceRange)
                  Text(
                    '已超出服务范围',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 22.sp,
                    ),
                  )
                else
                  SizedBox(
                    height: 56.h,
                    width: 180.w,
                    child: GradientButton(
                      text: '进店逛逛',
                      onPressed: () {},
                      height: 56.h,
                      borderRadius: 28,
                      padding: EdgeInsets.all(0),
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTag(String text, Color color, {bool isOutlined = false}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: isOutlined ? Colors.white : color,
        border: isOutlined ? Border.all(color: color, width: 1) : null,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isOutlined ? color : Colors.white,
          fontSize: 20.sp,
        ),
      ),
    );
  }
}
