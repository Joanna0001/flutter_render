import 'package:flutter/material.dart';
import 'components/home_banner.dart';
import 'components/store_card.dart';
import 'components/nav_cards.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // 轮播图
                  const HomeBanner(),
                  
                  // 店铺信息卡片
                  const StoreCard(),
                  
                  // 导航卡片
                  const NavCards(),
                  
                  // 更多模块可以在这里添加...
                  const SizedBox(height: 80), // 底部留白
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}