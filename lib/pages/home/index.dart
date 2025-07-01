import 'package:flutter/material.dart';
import 'components/search_header.dart';
import 'components/home_banner.dart';
import 'components/home_navigation.dart';
import 'components/home_recommend.dart';

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
          // 顶部搜索栏
          const SearchHeader(),
          
          // 页面其余内容的容器
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // 轮播图
                  const HomeBanner(),
                  
                  // 导航菜单
                  const HomeNavigation(),
                  
                  // 推荐房源
                  const HomeRecommend(),
                  
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