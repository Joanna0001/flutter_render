import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_render/theme/app_colors.dart';
import 'package:flutter_render/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:flutter_render/services/location_provider.dart';

class StoreCard extends StatelessWidget {
  const StoreCard({super.key});

  @override
  Widget build(BuildContext context) {
    // 2. 使用 context.watch 来监听 LocationProvider 的状态变化
    //    每当 LocationProvider 调用 notifyListeners()，这个 build 方法就会重新执行
    final locationProvider = context.watch<LocationProvider>();

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
      decoration: AppTheme.cardDecoration(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
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
                      Icon(
                        Icons.phone_outlined,
                        color: AppColors.textSecondary,
                        size: 32.sp,
                      ),
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
                      Icon(
                        Icons.near_me_outlined,
                        color: AppColors.textSecondary,
                        size: 32.sp,
                      ),
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

            SizedBox(height: 16.h),

            // 第二行：小标签
            Row(
              children: [
                _buildTag('到店自取', AppColors.primary),
                SizedBox(width: 16.w),
                _buildTag('送货到家', AppColors.secondary),
              ],
            ),

            SizedBox(height: 16.h),

            // 第三行：地址和距离
            Row(
              children: [
                Expanded(
                  child: Text(
                    locationProvider.currentLocation?.address ??
                        '地址：北京市海淀区清华大学西门对面清华科技园3号楼101室',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 22.sp,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(width: 16.w),
                Text(
                  '距您600m',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 22.sp,
                  ),
                ),
              ],
            ),

            SizedBox(height: 8.h),

            // 第四行：营业时间
            Text(
              '营业时间：08:00-22:00',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 22.sp),
            ),

            SizedBox(height: 8.h),

            // 第五行：提示超出服务范围
            Text(
              '当前地址超出服务范围',
              textAlign: TextAlign.start,
              style: TextStyle(color: AppColors.primary, fontSize: 22.sp),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTag(String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontSize: 20.sp),
      ),
    );
  }
}
