import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_render/theme/app_colors.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 293.h,
      padding: EdgeInsets.symmetric(vertical: 76.h, horizontal: 30.w),
      decoration: const BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage('images/profile/my_bg.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 60.w,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 56.w,
              backgroundImage: const AssetImage('images/profile/avatar.png'),
            ),
          ),
          SizedBox(width: 30.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Flutter 用户',
                style: TextStyle(
                  fontSize: 36.sp,
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                '138****8888',
                style: TextStyle(
                  fontSize: 28.sp,
                  color: Colors.grey,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
} 