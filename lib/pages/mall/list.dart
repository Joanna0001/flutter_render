import 'package:flutter/material.dart';
import 'package:flutter_render/theme/app_colors.dart';
import 'components/search_filter_bar.dart';
import 'components/category_tabs.dart';
import 'components/product_grid.dart';
import 'components/filter_bottom_sheet.dart';
import 'components/cart_bottom_bar.dart';
import 'models/product_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MallListPage extends StatefulWidget {
  const MallListPage({super.key});

  @override
  State<MallListPage> createState() => _MallListPageState();
}

class _MallListPageState extends State<MallListPage> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _minPriceController = TextEditingController();
  final TextEditingController _maxPriceController = TextEditingController();
  
  String _selectedTab = '全部';
  final List<String> _tabList = ['全部', '饮料', '葡萄酒', '鸡尾酒', '白酒'];
  final List<String> _tabIcons = ['tab_all', 'tab_juice', 'tab_grape', 'tab_tail', 'tab_wine'];
  
  final List<ProductModel> _products = List.generate(
    6,
    (index) => ProductModel(
      id: index + 1,
      name: '商品名称 ${index + 1}',
      price: 99 + index * 20,
      imageUrl: 'images/mall/${index + 1}.png',
      quantity: 0,
    ),
  );
  
  @override
  void dispose() {
    _searchController.dispose();
    _minPriceController.dispose();
    _maxPriceController.dispose();
    super.dispose();
  }
  
  // 计算总价
  double get _totalPrice => _products
    .where((product) => product.quantity > 0)
    .fold(0, (sum, product) => sum + product.price * product.quantity);
    
  // 选中的商品数量
  int get _selectedCount => _products
    .where((product) => product.quantity > 0)
    .fold(0, (sum, product) => sum + product.quantity);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: const Text('商城'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(62.h),
          child: SearchFilterBar(
            searchController: _searchController,
            onFilterTap: _showFilterBottomSheet,
            useBorderForFilter: false,
          ),
        ),
      ),
      body: Column(
        children: [
          CategoryTabs(
            tabs: _tabList,
            icons: _tabIcons,
            selectedTab: _selectedTab,
            onTabSelected: (tab) {
              setState(() {
                _selectedTab = tab;
              });
            },
          ),
          Expanded(
            child: ProductGrid(
              products: _products,
              onQuantityChanged: (product, quantity) {
                setState(() {
                  final index = _products.indexWhere((p) => p.id == product.id);
                  if (index != -1) {
                    _products[index] = _products[index].copyWith(quantity: quantity);
                  }
                });
              },
            ),
          ),
          if (_selectedCount > 0)
            CartBottomBar(
              totalPrice: _totalPrice,
              itemCount: _selectedCount,
              onCheckout: () {
                // 处理下单逻辑
              },
            ),
        ],
      ),
    );
  }
  
  // 筛选弹窗
  void _showFilterBottomSheet() {
    FilterBottomSheet.show(
      context: context, 
      onApply: _applyFilter,
      minPriceController: _minPriceController,
      maxPriceController: _maxPriceController,
    );
  }
  
  // 应用筛选
  void _applyFilter() {
    // 这里实现筛选逻辑
    final minPrice = double.tryParse(_minPriceController.text);
    final maxPrice = double.tryParse(_maxPriceController.text);
    
    // 在实际应用中，这里可以根据价格筛选商品
    setState(() {
      // 更新商品列表
    });
  }
}