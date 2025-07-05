import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_render/pages/application/index.dart';
import 'package:flutter_render/pages/home/index.dart';
import 'package:flutter_render/pages/login/login.dart';
import 'package:flutter_render/pages/login/register.dart';
import 'package:flutter_render/pages/profile/index.dart';
import 'package:flutter_render/pages/store/list.dart';
import 'package:flutter_render/pages/mall/list.dart';
import 'package:flutter_render/pages/profile/address/list.dart';
import 'package:flutter_render/pages/profile/order/list.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/home',
  routes: [
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterPage(),
    ),
    GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
    ShellRoute(
      builder: (context, state, child) {
        return ApplicationPage(child: child);
      },
      routes: [
        GoRoute(path: '/home', builder: (context, state) => const HomePage()),
        GoRoute(
          path: '/mall',
          builder: (context, state) => const MallListPage(),
        ),
        GoRoute(
          path: '/store',
          builder: (context, state) => const StoreListPage(),
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) => const ProfilePage(),
        ),
      ],
    ),
    GoRoute(
      path: '/address',
      builder: (context, state) => const AddressListPage(),
    ),
    GoRoute(
      path: '/order',
      builder: (context, state) {
        final index =
            int.tryParse(state.uri.queryParameters['initialTabIndex'] ?? '0') ??
            0;
        return OrderListPage(initialTabIndex: index);
      },
    ),
  ],
  errorBuilder: (context, state) =>
      Scaffold(body: Center(child: Text('页面不存在: ${state.uri}'))),
);
