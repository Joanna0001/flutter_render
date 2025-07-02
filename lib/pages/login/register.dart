import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_render/theme/gradient_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleRegister() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      // TODO: 实现注册逻辑
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        setState(() => _isLoading = false);
        // 注册成功后返回登录页
        context.pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('注册成功，请登录')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('注册', style: TextStyle(fontSize: 32.sp)),
        centerTitle: true,
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 48.w, vertical: 24.h),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 32.h),
                  // 用户名
                  TextFormField(
                    controller: _usernameController,
                    style: TextStyle(fontSize: 28.sp),
                    decoration: InputDecoration(
                      labelText: '用户名',
                      hintText: '请输入用户名',
                      labelStyle: TextStyle(fontSize: 28.sp),
                      hintStyle: TextStyle(fontSize: 28.sp),
                      prefixIcon: Icon(Icons.person_outline, size: 36.sp),
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

                  // 密码
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    style: TextStyle(fontSize: 28.sp),
                    decoration: InputDecoration(
                      labelText: '密码',
                      hintText: '请输入密码',
                      labelStyle: TextStyle(fontSize: 28.sp),
                      hintStyle: TextStyle(fontSize: 28.sp),
                      prefixIcon: Icon(Icons.lock_outline, size: 36.sp),
                      contentPadding: EdgeInsets.symmetric(vertical: 20.h),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
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
                        return '密码长度不能少于6位';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 32.h),

                  // 确认密码
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: _obscureConfirmPassword,
                    style: TextStyle(fontSize: 28.sp),
                    decoration: InputDecoration(
                      labelText: '确认密码',
                      hintText: '请再次输入密码',
                      labelStyle: TextStyle(fontSize: 28.sp),
                      hintStyle: TextStyle(fontSize: 28.sp),
                      prefixIcon: Icon(Icons.lock_outline, size: 36.sp),
                      contentPadding: EdgeInsets.symmetric(vertical: 20.h),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureConfirmPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          size: 36.sp,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureConfirmPassword = !_obscureConfirmPassword;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '请再次输入密码';
                      }
                      if (value != _passwordController.text) {
                        return '两次输入的密码不一致';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 64.h),

                  // 注册按钮
                  SizedBox(
                    width: double.infinity,
                    height: 88.h,
                    child: _isLoading
                        ? Center(
                            child: SizedBox(
                              width: 36.w,
                              height: 36.w,
                              child: CircularProgressIndicator(
                                strokeWidth: 3.w,
                              ),
                            ),
                          )
                        : GradientButton(
                            text: '注 册',
                            onPressed: _handleRegister,
                            height: 88.h,
                          ),
                  ),
                  SizedBox(height: 32.h),

                  // 返回登录
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('已有账号？', style: TextStyle(fontSize: 24.sp)),
                      TextButton(
                        onPressed: () {
                          context.pop();
                        },
                        child: Text('立即登录', style: TextStyle(fontSize: 24.sp)),
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
} 