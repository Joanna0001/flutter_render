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
    _initLocation();
  }

  void _initLocation() {
    final provider = context.read<LocationProvider>();
    Future.delayed(Duration.zero, () {
      if (mounted &&
          provider.currentLocation == null &&
          provider.errorMessage == null) {
        provider.fetchCurrentLocation();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final locationProvider = context.watch<LocationProvider>();
    debugPrint(
      'locationProvider------------: ${locationProvider.currentLocation?.address}',
    );

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
                  locationProvider.currentLocation?.address != null
                      ? StoreCard()
                      : const SizedBox.shrink(),

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
