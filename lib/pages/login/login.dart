import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:async';
import 'package:flutter_render/theme/app_colors.dart';
import 'package:flutter_render/theme/gradient_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _passwordFormKey = GlobalKey<FormState>();
  final _codeFormKey = GlobalKey<FormState>();

  // 密码登录相关控制器
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _rememberPassword = false;

  // 验证码登录相关控制器
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();
  bool _isLoading = false;
  bool _isSendingCode = false;
  int _countdown = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _codeController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _handlePasswordLogin() async {
    if (_passwordFormKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      // TODO: 实现实际的密码登录逻辑
      await Future.delayed(const Duration(seconds: 2)); // 模拟网络请求

      if (mounted) {
        setState(() => _isLoading = false);
        context.go('/application');
      }
    }
  }

  void _handleCodeLogin() async {
    if (_codeFormKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      // TODO: 实现实际的验证码登录逻辑
      await Future.delayed(const Duration(seconds: 2)); // 模拟网络请求

      if (mounted) {
        setState(() => _isLoading = false);
        context.go('/application');
      }
    }
  }

  void _sendVerificationCode() async {
    if (_phoneController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('请输入手机号')));
      return;
    }

    if (!RegExp(r'^1[3-9]\d{9}$').hasMatch(_phoneController.text)) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('请输入正确的手机号')));
      return;
    }

    setState(() => _isSendingCode = true);

    // TODO: 实现发送验证码逻辑
    await Future.delayed(const Duration(seconds: 1)); // 模拟网络请求

    if (mounted) {
      setState(() {
        _isSendingCode = false;
        _countdown = 60;
      });

      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (mounted) {
          setState(() {
            if (_countdown > 0) {
              _countdown--;
            } else {
              timer.cancel();
            }
          });
        }
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('验证码已发送')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 48.w, vertical: 24.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Logo或标题
                  Center(
                    child: Image.asset(
                      'images/app/logo.png',
                      width: 150.w,
                      height: 150.w,
                    ),
                  ),
                  SizedBox(height: 70.h),

                  // Tab 切换
                  TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    tabAlignment: TabAlignment.start,
                    indicatorSize: TabBarIndicatorSize.label,
                    dividerColor: Colors.transparent,
                    indicator: UnderlineTabIndicator(
                      borderSide: BorderSide(color: theme.colorScheme.primary, width: 2),
                    ),
                    labelColor: theme.colorScheme.primary,
                    unselectedLabelColor: theme.colorScheme.onSurface,
                    labelStyle: TextStyle(fontSize: 28.sp),
                    unselectedLabelStyle: TextStyle(fontSize: 28.sp),
                    tabs: const [
                      Tab(text: '密码登录'),
                      Tab(text: '验证码登录'),
                    ],
                  ),
                  SizedBox(height: 50.h),

                  // Tab 内容
                  SizedBox(
                    height: 700.h, // 固定高度避免切换时跳动
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        // 密码登录表单
                        _buildPasswordLoginForm(),
                        // 验证码登录表单
                        _buildCodeLoginForm(),
                      ],
                    ),
                  ),

                  // 注册链接
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('还没有账号？', style: TextStyle(fontSize: 24.sp)),
                      TextButton(
                        onPressed: () {
                          context.push('/register');
                        },
                        child: Text('立即注册', style: TextStyle(fontSize: 24.sp)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordLoginForm() {
    return Form(
      key: _passwordFormKey,
      child: Column(
        children: [
          // 用户名输入框
          SizedBox(height: 6.h),
          TextFormField(
            controller: _usernameController,
            style: TextStyle(fontSize: 28.sp),
            decoration: InputDecoration(
              labelText: '用户名',
              hintText: '请输入用户名',
              labelStyle: TextStyle(fontSize: 28.sp),
              hintStyle: TextStyle(fontSize: 28.sp),
              prefixIcon: Icon(Icons.person, size: 36.sp),
              contentPadding: EdgeInsets.symmetric(vertical: 20.h),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '请输入用户名';
              }
              return null;
            },
          ),
          SizedBox(height: 32.h),

          // 密码输入框
          TextFormField(
            controller: _passwordController,
            obscureText: _obscurePassword,
            style: TextStyle(fontSize: 28.sp),
            decoration: InputDecoration(
              labelText: '密码',
              hintText: '请输入密码',
              labelStyle: TextStyle(fontSize: 28.sp),
              hintStyle: TextStyle(fontSize: 28.sp),
              prefixIcon: Icon(Icons.lock, size: 36.sp),
              contentPadding: EdgeInsets.symmetric(vertical: 20.h),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility_off : Icons.visibility,
                  size: 36.sp,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '请输入密码';
              }
              if (value.length < 6) {
                return '密码长度不能小于6位';
              }
              return null;
            },
          ),
          SizedBox(height: 16.h),

          // 记住密码选项
          Row(
            children: [
              Transform.scale(
                scale: 1.2,
                child: Checkbox(
                  value: _rememberPassword,
                  side: BorderSide(color: AppColors.textHint),
                  onChanged: (value) {
                    setState(() {
                      _rememberPassword = value ?? false;
                    });
                  },
                ),
              ),
              Text('记住密码', style: TextStyle(fontSize: 24.sp)),
              const Spacer(),
              TextButton(
                onPressed: () {
                  // TODO: 实现忘记密码功能
                },
                child: Text('忘记密码？', style: TextStyle(fontSize: 24.sp)),
              ),
            ],
          ),
          SizedBox(height: 28.h),

          // 登录按钮
          _buildLoginButton(_handlePasswordLogin),
        ],
      ),
    );
  }

  Widget _buildCodeLoginForm() {
    return Form(
      key: _codeFormKey,
      child: Column(
        children: [
          SizedBox(height: 12.h),
          // 手机号输入框
          TextFormField(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            style: TextStyle(fontSize: 28.sp),
            decoration: InputDecoration(
              labelText: '手机号',
              hintText: '请输入手机号',
              labelStyle: TextStyle(fontSize: 28.sp),
              hintStyle: TextStyle(fontSize: 28.sp),
              prefixIcon: Icon(Icons.phone, size: 36.sp),
              contentPadding: EdgeInsets.symmetric(vertical: 20.h),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '请输入手机号';
              }
              if (!RegExp(r'^1[3-9]\d{9}$').hasMatch(value)) {
                return '请输入正确的手机号';
              }
              return null;
            },
          ),
          SizedBox(height: 32.h),

          // 验证码输入框
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _codeController,
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontSize: 28.sp),
                  decoration: InputDecoration(
                    labelText: '验证码',
                    hintText: '请输入验证码',
                    labelStyle: TextStyle(fontSize: 28.sp),
                    hintStyle: TextStyle(fontSize: 28.sp),
                    prefixIcon: Icon(Icons.security, size: 36.sp),
                    contentPadding: EdgeInsets.symmetric(vertical: 20.h),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '请输入验证码';
                    }
                    if (value.length != 6) {
                      return '验证码为6位数字';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(width: 24.w),
              SizedBox(
                width: 220.w,
                child: FilledButton.tonal(
                  onPressed: (_countdown > 0 || _isSendingCode)
                      ? null
                      : _sendVerificationCode,
                  style: FilledButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                  ),
                  child: _isSendingCode
                      ? SizedBox(
                          height: 24.w,
                          width: 24.w,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(
                          _countdown > 0 ? '${_countdown}s' : '获取验证码',
                          style: TextStyle(fontSize: 24.sp),
                        ),
                ),
              ),
            ],
          ),
          SizedBox(height: 48.h),

          // 登录按钮
          _buildLoginButton(_handleCodeLogin),
        ],
      ),
    );
  }

  Widget _buildLoginButton(VoidCallback? onPressed) {
    return SizedBox(
      width: double.infinity,
      child: _isLoading
          ? Center(
              child: SizedBox(
                height: 36.w,
                width: 36.w,
                child: CircularProgressIndicator(strokeWidth: 3),
              ),
            )
          : GradientButton(
              text: '登 录',
              onPressed: onPressed,
              height: 88.h,
            ),
    );
  }
} 