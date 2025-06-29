import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_render/pages/home/index.dart';
import 'package:flutter_render/pages/login.dart';
import 'package:flutter_render/pages/register.dart';

final GoRouter router = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterPage(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomePage(),
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Text('页面不存在: ${state.uri}'),
    ),
  ),
);
