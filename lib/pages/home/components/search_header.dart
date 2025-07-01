import 'package:flutter/material.dart';
import 'package:flutter_render/theme/app_colors.dart';

class SearchHeader extends StatelessWidget {
  const SearchHeader({super.key});

  @override
  Widget build(BuildContext context) {
    // 获取系统状态栏高度
    final statusBarHeight = MediaQuery.of(context).padding.top;
    
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(top: statusBarHeight),
      child: Column(
        children: [
          // 搜索栏
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            color: Colors.white,
            child: Row(
              children: [
                // 位置选择
                GestureDetector(
                  onTap: () {
                    // 位置选择点击事件
                  },
                  child: Row(
                    children: [
                      const Icon(
                        Icons.location_on_sharp,
                        color: AppColors.primary,
                        size: 18.0,
                      ),
                      const Text(
                        '北京',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),
                
                // 搜索框
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12.0),
                    height: 40.0,
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 12.0, right: 6.0),
                          child: Icon(
                            Icons.search,
                            size: 20.0,
                            color: AppColors.textHint,
                          ),
                        ),
                        const Text(
                          '请输入小区或地址',
                          style: TextStyle(
                            color: AppColors.textHint,
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                // 地图定位按钮
                GestureDetector(
                  onTap: () {
                    // 地图定位点击事件
                  },
                  child: const Icon(
                    Icons.location_on_outlined,
                    color: AppColors.primary,
                    size: 24.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 