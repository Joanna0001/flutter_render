import 'package:flutter/material.dart';
import 'package:flutter_render/theme/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchFilterBar extends StatelessWidget {
  final TextEditingController searchController;
  final VoidCallback onFilterTap;
  final bool useBorderForFilter;

  const SearchFilterBar({
    super.key,
    required this.searchController,
    required this.onFilterTap,
    this.useBorderForFilter = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 62.h,
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: '搜索想要的商品',
                  hintStyle: TextStyle(color: AppColors.textHint, fontSize: 14),
                  prefixIcon: Icon(Icons.search, color: AppColors.textHint),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 3.h),
                  filled: true,
                  fillColor: AppColors.background),
              ),
            ),
          ),
          const SizedBox(width: 12),
          InkWell(
            onTap: onFilterTap,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: useBorderForFilter ? Border.all(color: AppColors.border) : null,
              ),
              child: Row(
                children: [
                  Image.asset(
                    'images/mall/filter.png',
                    width: 30.w,
                    height: 30.w,
                  ),
                  SizedBox(width: 10.w),
                  Text('筛选', style: TextStyle(color: AppColors.textSecondary, fontSize: 28.sp)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
} 