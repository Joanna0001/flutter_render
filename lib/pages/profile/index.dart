import 'package:flutter/material.dart';
import 'package:flutter_render/theme/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'components/header.dart';
import 'components/my_order.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我的', style: TextStyle(fontSize: 32.sp, color: AppColors.textPrimary)),
      ),
      backgroundColor: const Color(0xfff5f5f5),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Stack(
            children: [
              const Header(),
              Padding(
                padding: EdgeInsets.only(top: 228.h),
                child: const MyOrder(),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 