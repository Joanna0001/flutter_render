import 'package:flutter/material.dart';
import 'app_colors.dart';

/// 应用主题
class AppTheme {
  /// 亮色主题
  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        // 主要颜色
        primary: AppColors.primary,
        onPrimary: Colors.white,
        primaryContainer: AppColors.primaryLight,
        onPrimaryContainer: Colors.white,
        // 次要颜色
        secondary: AppColors.primaryLight,
        onSecondary: Colors.white,
        secondaryContainer: AppColors.primaryLight.withAlpha(50),
        onSecondaryContainer: AppColors.primary,
        // 错误颜色
        error: AppColors.error,
        onError: Colors.white,
        errorContainer: Color.alphaBlend(
          AppColors.error.withAlpha(25), // 10% 透明度
          Colors.white,
        ),
        onErrorContainer: AppColors.error,
        // 背景和表面颜色
        surface: AppColors.cardBackground,
        onSurface: AppColors.textPrimary,
        surfaceTint: Color.alphaBlend(
          AppColors.primary.withAlpha(25), // 10% 透明度
          Colors.white,
        ),
        inverseSurface: AppColors.textPrimary,
        onInverseSurface: AppColors.cardBackground,
        // 中性色
        outline: AppColors.border,
        outlineVariant: AppColors.divider,
        // 其他
        shadow: AppColors.shadow,
        scrim: const Color(0x8A000000), // 54% 透明度的黑色
      ),
      scaffoldBackgroundColor: AppColors.background,
      // AppBar主题
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      // 卡片主题
      cardTheme: CardThemeData(
        elevation: 2,
        shadowColor: AppColors.shadow,
        margin: EdgeInsets.zero,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
      // 输入框主题
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.cardBackground,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.error, width: 2),
        ),
        labelStyle: const TextStyle(color: AppColors.textSecondary),
        hintStyle: const TextStyle(color: AppColors.textHint),
        prefixIconColor: AppColors.textHint.withAlpha(95),
        suffixIconColor: AppColors.textHint.withAlpha(95),
      ),
      // 按钮主题
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 2,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
      ),
      // 文字主题
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        titleMedium: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        bodyLarge: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 16,
        ),
        bodyMedium: TextStyle(
          color: AppColors.textSecondary,
          fontSize: 14,
        ),
      ),
    );
  }

  /// 暗色主题
  static ThemeData dark() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.dark,
        // 主要颜色
        primary: AppColors.primary,
        onPrimary: Colors.white,
        primaryContainer: AppColors.primaryLight,
        onPrimaryContainer: Colors.white,
        // 次要颜色
        secondary: AppColors.primaryLight,
        onSecondary: Colors.white,
        // 错误颜色
        error: AppColors.error,
        onError: Colors.white,
        errorContainer: Color.alphaBlend(
          AppColors.error.withAlpha(25), // 10% 透明度
          const Color(0xFF121212), // 暗色背景
        ),
        onErrorContainer: AppColors.error,
        // 背景和表面颜色
        surface: const Color(0xFF121212), // 标准暗色背景
        onSurface: Colors.white,
        surfaceTint: Color.alphaBlend(
          AppColors.primary.withAlpha(25), // 10% 透明度
          const Color(0xFF121212),
        ),
        inverseSurface: Colors.white,
        onInverseSurface: const Color(0xFF121212),
        // 中性色
        outline: const Color(0xFF424242), // Material 暗色边框
        outlineVariant: const Color(0xFF323232), // 更暗的边框
        // 其他
        shadow: const Color(0x66000000), // 40% 透明度的黑色
        scrim: const Color(0xDD000000), // 87% 透明度的黑色
      ),
      scaffoldBackgroundColor: Colors.black,
      // AppBar主题
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF1F1F1F), // 暗色AppBar背景
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      // 卡片主题
      cardTheme: CardThemeData(
        elevation: 2,
        shadowColor: const Color(0x66000000),
        margin: EdgeInsets.zero,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        color: const Color(0xFF1E1E1E), // 暗色卡片背景
      ),
      // 输入框主题
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF2C2C2C), // 暗色输入框背景
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF424242)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF424242)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.error, width: 2),
        ),
        labelStyle: const TextStyle(color: Colors.white70),
        hintStyle: const TextStyle(color: Colors.white54),
        prefixIconColor: Colors.white70,
        suffixIconColor: Colors.white70,
      ),
      // 按钮主题
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 2,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
      ),
      // 文字主题
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        titleMedium: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        bodyLarge: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
        bodyMedium: TextStyle(
          color: Colors.white70,
          fontSize: 14,
        ),
      ),
    );
  }

  /// 渐变按钮装饰
  static BoxDecoration gradientButtonDecoration({
    double borderRadius = 8.0,
    LinearGradient? gradient,
  }) {
    return BoxDecoration(
      gradient: gradient ?? AppColors.primaryGradient,
      borderRadius: BorderRadius.circular(borderRadius),
      boxShadow: const [
        BoxShadow(
          color: Color(0x29000000),
          offset: Offset(0, 3),
          blurRadius: 6,
        ),
      ],
    );
  }
} 