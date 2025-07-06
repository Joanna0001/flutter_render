import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_render/services/location_provider.dart';
import 'components/home_banner.dart';
import 'components/store_card.dart';
import 'components/nav_cards.dart';
import 'components/service_cards.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // 使用 addPostFrameCallback 确保在第一帧渲染完成后再调用位置更新
    // 这样可以避免在构建过程中触发状态更新
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // 在 Widget 初始化时调用一次获取位置的方法
      // 使用 context.read() 是因为我们不关心后续 LocationProvider 的变化，
      // 只是想触发一个动作。这在 initState 中是推荐的做法。
      context.read<LocationProvider>().fetchCurrentLocation();
    });
  }

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

                  // 服务卡片
                  const ServiceCards(),

                  // 领取优惠券
                  Container(
                    margin: EdgeInsets.fromLTRB(24.w, 0, 24.w, 24.h),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.asset(
                        'images/home/banner_cupon.png',
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
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
