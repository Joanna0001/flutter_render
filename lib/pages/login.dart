import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:async';
import 'package:flutter_render/theme/app_colors.dart';

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
        context.go('/home');
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
        context.go('/home');
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
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Logo或标题
                  Center(
                    child: Image.asset(
                      'images/logo.png',
                      width: 150,
                      height: 150,
                    ),
                  ),
                  const SizedBox(height: 32),

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
                    tabs: const [
                      Tab(text: '密码登录'),
                      Tab(text: '验证码登录'),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // Tab 内容
                  SizedBox(
                    height: 400, // 固定高度避免切换时跳动
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
                  const SizedBox(height: 16),

                  // 注册链接
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('还没有账号？', style: theme.textTheme.bodyMedium),
                      TextButton(
                        onPressed: () {
                          context.push('/register');
                        },
                        child: const Text('立即注册'),
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
    final theme = Theme.of(context);
    return Form(
      key: _passwordFormKey,
      child: Column(
        children: [
          // 用户名输入框
          const SizedBox(height: 6),
          TextFormField(
            controller: _usernameController,
            decoration: const InputDecoration(
              labelText: '用户名',
              hintText: '请输入用户名',
              prefixIcon: Icon(Icons.person),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '请输入用户名';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          // 密码输入框
          TextFormField(
            controller: _passwordController,
            obscureText: _obscurePassword,
            decoration: InputDecoration(
              labelText: '密码',
              hintText: '请输入密码',
              prefixIcon: const Icon(Icons.lock),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility_off : Icons.visibility,
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
          const SizedBox(height: 8),

          // 记住密码选项
          Row(
            children: [
              Checkbox(
                value: _rememberPassword,
                side: const BorderSide(color: AppColors.textHint),
                onChanged: (value) {
                  setState(() {
                    _rememberPassword = value ?? false;
                  });
                },
              ),
              Text('记住密码', style: theme.textTheme.bodyMedium),
              const Spacer(),
              TextButton(
                onPressed: () {
                  // TODO: 实现忘记密码功能
                },
                child: const Text('忘记密码？'),
              ),
            ],
          ),
          const SizedBox(height: 24),

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
          const SizedBox(height: 6),
          // 手机号输入框
          TextFormField(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              labelText: '手机号',
              hintText: '请输入手机号',
              prefixIcon: Icon(Icons.phone),
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
          const SizedBox(height: 16),

          // 验证码输入框
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _codeController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: '验证码',
                    hintText: '请输入验证码',
                    prefixIcon: Icon(Icons.security),
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
              const SizedBox(width: 12),
              SizedBox(
                width: 120,
                child: FilledButton.tonal(
                  onPressed: (_countdown > 0 || _isSendingCode)
                      ? null
                      : _sendVerificationCode,
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: _isSendingCode
                      ? const SizedBox(
                          height: 16,
                          width: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(
                          _countdown > 0 ? '${_countdown}s' : '获取验证码',
                          style: const TextStyle(fontSize: 12),
                        ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // 登录按钮
          _buildLoginButton(_handleCodeLogin),
        ],
      ),
    );
  }

  Widget _buildLoginButton(VoidCallback? onPressed) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _isLoading ? null : onPressed,
        child: _isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              )
            : const Text('登 录', style: TextStyle(fontSize: 16)),
      ),
    );
  }
}
