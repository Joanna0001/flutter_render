import 'package:flutter/material.dart';
import 'package:flutter_render/theme/app_colors.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // 获取系统状态栏高度
    final statusBarHeight = MediaQuery.of(context).padding.top;
    
    // 轮播图数据
    final List<String> imageList = [
      'https://img.ljcdn.com/beike/haofangwangfront/image/1682310063344.jpg',
      'https://img.ljcdn.com/beike/haofangwangfront/image/1668156758900.jpg',
      'https://img.ljcdn.com/beike/haofangwangfront/image/1665462631318.jpg',
    ];
    
    return Scaffold(
      body: Column(
        children: [
          // 顶部安全区域和搜索栏容器
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(top: statusBarHeight),
            child: Column(
              children: [
                // 搜索栏
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  color: Colors.white,
                  child: Row(
                    children: [
                      // 位置选择
                      GestureDetector(
                        onTap: () {
                          // 位置选择点击事件
                        },
                        child: Row(
                          children: [
                            const Icon(
                              Icons.location_on_sharp,
                              color: AppColors.primary,
                              size: 18.0,
                            ),
                            const Text(
                              '北京',
                              style: TextStyle(
                                color: AppColors.textPrimary,
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      // 搜索框
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 12.0),
                          height: 40.0,
                          decoration: BoxDecoration(
                            color: AppColors.background,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 12.0, right: 6.0),
                                child: Icon(
                                  Icons.search,
                                  size: 20.0,
                                  color: AppColors.textHint,
                                ),
                              ),
                              const Text(
                                '请输入小区或地址',
                                style: TextStyle(
                                  color: AppColors.textHint,
                                  fontSize: 14.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      
                      // 地图定位按钮
                      GestureDetector(
                        onTap: () {
                          // 地图定位点击事件
                        },
                        child: const Icon(
                          Icons.location_on_outlined,
                          color: AppColors.primary,
                          size: 24.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // 页面其余内容的容器
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // 轮播图
                  Container(
                    width: double.infinity,
                    color: Colors.white,
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Column(
                      children: [
                        // 轮播图
                        CarouselSlider(
                          options: CarouselOptions(
                            height: 200.0,
                            aspectRatio: 16/9,
                            viewportFraction: 0.9,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            reverse: false,
                            autoPlay: true,
                            autoPlayInterval: const Duration(seconds: 3),
                            autoPlayAnimationDuration: const Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeCenterPage: true,
                            scrollDirection: Axis.horizontal,
                          ),
                          items: imageList.map((item) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    image: DecorationImage(
                                      image: NetworkImage(item),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              },
                            );
                          }).toList(),
                        ),
                        
                        // 指示器
                        Container(
                          margin: const EdgeInsets.only(top: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: imageList.asMap().entries.map((entry) {
                              return Container(
                                width: 8.0,
                                height: 8.0,
                                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.primary.withOpacity(entry.key == 0 ? 0.9 : 0.4),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // 其他内容可以在这里添加
                  Container(
                    color: AppColors.background,
                    height: 1000, // 临时高度，实际开发中可以替换为实际内容
                    child: const Center(
                      child: Text('页面其他内容'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}