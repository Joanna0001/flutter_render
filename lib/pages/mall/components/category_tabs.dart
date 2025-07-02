import 'package:flutter/material.dart';
import 'package:flutter_render/theme/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryTabs extends StatefulWidget {
  final List<String> tabs;
  final List<String> icons;
  final String selectedTab;
  final Function(String) onTabSelected;

  const CategoryTabs({
    super.key,
    required this.tabs,
    required this.icons,
    required this.selectedTab,
    required this.onTabSelected,
  });

  @override
  State<CategoryTabs> createState() => _CategoryTabsState();
}

class _CategoryTabsState extends State<CategoryTabs> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 120.h,
      color: Colors.white,
      child: Row(
        children: List.generate(
          widget.tabs.length,
          (index) {
            final tab = widget.tabs[index];
            final icon = widget.icons[index];
            final isSelected = tab == widget.selectedTab;

            return Expanded(
              child: GestureDetector(
                onTap: () => widget.onTabSelected(tab),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: isSelected
                        ? const Border(
                            bottom: BorderSide(
                              color: AppColors.primary,
                              width: 2,
                            ),
                          )
                        : null,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'images/mall/$icon.png',
                        width: 60.w,
                        height: 60.w,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        tab,
                        style: TextStyle(
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.textSecondary,
                          fontSize: 24.sp,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
} 