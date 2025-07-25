import 'package:flutter/material.dart';

/// 应用主题颜色
class AppColors {
  // 主色调
  static const Color primary = Color(0xFF8F1C46);
  static const Color primaryLight = Color(0xFFAF3964);
  static const Color primaryDark = Color(0xFF6F1535);
  
  // 辅助色调
  static const Color secondary = Color(0xFFE89441);

  // 功能色
  static const Color success = Color(0xFF52C41A);
  static const Color warning = Color(0xFFFAAD14);
  static const Color error = Color(0xFFF5222D);
  static const Color info = Color(0xFF1890FF);

  // 文字颜色
  static const Color textPrimary = Color(0xFF222222);
  static const Color textSecondary = Color(0xFF666666);
  static const Color textHint = Color(0xFF999999);
  static const Color textTertiary = Color(0xFF362B2F);
  static const Color textQuaternary = Color(0xFF000000);

  // 背景色
  static const Color background = Color(0xFFF5F5F5);
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color divider = Color(0xFFE8E8E8);

  // 边框颜色
  static const Color border = Color(0xFFE8E8E8);
  static const Color borderSecondary = Color(0xFFDEDEDE);
  
  // 禁用状态颜色
  static const Color disabled = Color(0xFFBFBFBF);
  
  // 阴影颜色
  static const Color shadow = Color(0x1A000000);
  
  // 渐变色
  static const Color gradientStart = Color(0xFFD4255A);
  static const Color gradientEnd = Color(0xFF97107C);
  
  /// 获取主要渐变色
  static LinearGradient get primaryGradient => const LinearGradient(
    colors: [gradientStart, gradientEnd],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
} 