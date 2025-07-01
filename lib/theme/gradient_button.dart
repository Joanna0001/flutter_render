import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_theme.dart';

/// 渐变按钮组件
class GradientButton extends StatelessWidget {
  /// 按钮文本
  final String text;

  /// 点击事件回调
  final VoidCallback? onPressed;

  /// 按钮宽度，为null时适应内容宽度
  final double? width;

  /// 按钮高度
  final double height;

  /// 文本样式
  final TextStyle? textStyle;

  /// 内边距
  final EdgeInsetsGeometry padding;

  /// 边框圆角
  final double borderRadius;

  /// 自定义渐变色，不设置则使用默认渐变色
  final LinearGradient? gradient;

  /// 是否禁用
  final bool isDisabled;

  /// 创建渐变按钮
  const GradientButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.width,
    this.height = 48.0,
    this.textStyle,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    this.borderRadius = 8.0,
    this.gradient,
    this.isDisabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttonGradient = isDisabled
        ? LinearGradient(
            colors: [Colors.grey.shade400, Colors.grey.shade500],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          )
        : gradient ?? AppColors.primaryGradient;

    final defaultTextStyle = const TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.w600,
    );

    return GestureDetector(
      onTap: isDisabled ? null : onPressed,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: AppTheme.gradientButtonDecoration(
          borderRadius: borderRadius,
          gradient: buttonGradient,
        ),
        child: Center(
          child: Text(
            text,
            style: textStyle ?? defaultTextStyle,
          ),
        ),
      ),
    );
  }

  /// 创建小号按钮
  factory GradientButton.small({
    required String text,
    required VoidCallback? onPressed,
    double? width,
    TextStyle? textStyle,
    LinearGradient? gradient,
    bool isDisabled = false,
  }) {
    return GradientButton(
      text: text,
      onPressed: onPressed,
      width: width,
      height: 36.0,
      textStyle: textStyle ?? const TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      borderRadius: 6.0,
      gradient: gradient,
      isDisabled: isDisabled,
    );
  }

  /// 创建大号按钮
  factory GradientButton.large({
    required String text,
    required VoidCallback? onPressed,
    double? width,
    TextStyle? textStyle,
    LinearGradient? gradient,
    bool isDisabled = false,
  }) {
    return GradientButton(
      text: text,
      onPressed: onPressed,
      width: width,
      height: 56.0,
      textStyle: textStyle ?? const TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      borderRadius: 10.0,
      gradient: gradient,
      isDisabled: isDisabled,
    );
  }

  /// 创建全宽按钮
  factory GradientButton.fullWidth({
    required String text,
    required VoidCallback? onPressed,
    double height = 48.0,
    TextStyle? textStyle,
    LinearGradient? gradient,
    bool isDisabled = false,
  }) {
    return GradientButton(
      text: text,
      onPressed: onPressed,
      width: double.infinity,
      height: height,
      textStyle: textStyle,
      gradient: gradient,
      isDisabled: isDisabled,
    );
  }
} 