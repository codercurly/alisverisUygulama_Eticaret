import 'package:flutter/material.dart';
import 'package:food_delivery/base/custom_app_barr.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/controllers/order_controller.dart';
import 'package:food_delivery/pages/order/view_order.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:get/get.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();


}

class _OrderPageState extends State<OrderPage> with TickerProviderStateMixin{

    TabController? _tabController;
    late bool _isLoggedIn;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isLoggedIn=Get.find<AuthController>().userLoggedIn();
    if(_isLoggedIn){
      _tabController =TabController(length: 2, vsync: this);
    //  Get.find<OrderController>().getOrderList();
    }
  }
  @override
  Widget build(BuildContext context) {




    return Scaffold(
        appBar: CustomAppBar(title: "Sipariş Geçmişi"),
        body: Column(children: [
          Container(
            width: Dimensions.screenWidth,
            child: TabBar(
                controller: _tabController,
                indicatorColor: Theme.of(context).primaryColor,
                indicatorWeight: 2,
                labelColor: Theme.of(context).primaryColor,
                unselectedLabelColor: Theme.of(context).disabledColor,
                tabs: [Tab(text: "yeni"),Tab(text: "Geçmiş")]),
          ),
          Expanded(child: TabBarView(controller: _tabController,
          children: [
            ViewOrder(isCurrent: true),
            ViewOrder(isCurrent: false)
          ],
          ))
        ]));

  }
}
