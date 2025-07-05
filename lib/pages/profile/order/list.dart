import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_render/theme/app_colors.dart';
import 'package:flutter_render/theme/app_theme.dart';
import 'package:go_router/go_router.dart';

class OrderListPage extends StatefulWidget {
  final int initialTabIndex;

  const OrderListPage({super.key, this.initialTabIndex = 0});

  @override
  State<OrderListPage> createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _tabs = ['全部', '待付款', '待发货', '待收货', '已完成', '退货'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: _tabs.length,
      vsync: this,
      initialIndex: widget.initialTabIndex,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('我的订单'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(88.h),
          child: Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              padding: EdgeInsets.zero,
              labelPadding: EdgeInsets.symmetric(horizontal: 16.w),
              labelColor: AppColors.primary,
              unselectedLabelColor: AppColors.textSecondary,
              labelStyle: TextStyle(
                fontSize: 28.sp,
                fontWeight: FontWeight.w500,
              ),
              unselectedLabelStyle: TextStyle(
                fontSize: 28.sp,
                fontWeight: FontWeight.normal,
              ),
              indicatorColor: AppColors.primary,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: _tabs.map((tab) => Tab(text: tab)).toList(),
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _tabs.map((tab) => _buildOrderList(tab)).toList(),
      ),
    );
  }

  Widget _buildOrderList(String status) {
    // TODO: 根据状态加载对应的订单列表
    return ListView.builder(
      padding: EdgeInsets.all(24.w),
      itemCount: 10, // 临时数据
      itemBuilder: (context, index) {
        return _buildOrderItem();
      },
    );
  }

  Widget _buildOrderItem() {
    return GestureDetector(
      onTap: () {
        context.push('/order/detail/ORDER123456789');
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 20.h),
        decoration: AppTheme.cardDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 店铺信息
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Row(
                children: [
                  Image.asset(
                    'images/app/store.png',
                    width: 40.w,
                    height: 40.w,
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    '店铺名称',
                    style: TextStyle(
                      fontSize: 28.sp,
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '待付款',
                    style: TextStyle(fontSize: 28.sp, color: AppColors.primary),
                  ),
                ],
              ),
            ),
            Divider(height: 1.h, color: AppColors.borderSecondary),
            // 商品信息
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 160.w,
                    height: 160.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.w),
                      color: AppColors.background,
                    ),
                  ),
                  SizedBox(width: 20.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '商品名称商品名称商品名称商品名称',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 28.sp,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          '规格：默认',
                          style: TextStyle(
                            fontSize: 24.sp,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '¥99.00',
                              style: TextStyle(
                                fontSize: 28.sp,
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              'x1',
                              style: TextStyle(
                                fontSize: 24.sp,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // 底部操作栏
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: AppColors.border),
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 0,
                      ),
                      minimumSize: Size(120.w, 52.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.w),
                      ),
                    ),
                    child: Text(
                      '取消订单',
                      style: TextStyle(
                        fontSize: 22.sp,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  SizedBox(width: 20.w),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 0,
                      ),
                      minimumSize: Size(120.w, 52.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.w),
                      ),
                    ),
                    child: Text(
                      '立即付款',
                      style: TextStyle(fontSize: 22.sp, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
