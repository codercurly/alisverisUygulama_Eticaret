import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/pages/cart/cart_page.dart';
import 'package:food_delivery/pages/home/main_food_page.dart';
import 'package:food_delivery/route/route_helper.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_column.dart';
import 'package:food_delivery/widgets/app_icons.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/expandable_text_widget.dart';
import 'package:food_delivery/widgets/icon_and_text.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';

class PopularFoodDetail extends StatelessWidget {
  final int pageId;
  final String page;
  const PopularFoodDetail({Key? key, required this.pageId, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());
    return Scaffold(
        body: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  toolbarHeight: 80,
                  bottom: PreferredSize(
                    preferredSize: Size.fromHeight(15),
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(Dimensions.radius20),
                                topLeft: Radius.circular(Dimensions.radius20))),
                        padding: EdgeInsets.all(Dimensions.width10),
                        width: double.maxFinite,
                        child: Container(
                          padding: EdgeInsets.all(Dimensions.width10 / 2),
                          child: Center(
                            child: AppColumn(text: product.name),
                          ),
                        )),
                  ),
                  pinned: true,
                  backgroundColor: AppColors.yellowColor,
                  expandedHeight: 100,
                  collapsedHeight: 330,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Image.network(
                        AppConstants.BASE_URL +
                            AppConstants.UPLOADS_URI +
                            product.img!,
                        width: double.maxFinite,
                        fit: BoxFit.cover),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Container(
                          color: Colors.white,
                          padding: EdgeInsets.only(
                              left: Dimensions.width30,
                              right: Dimensions.width30,
                              top: Dimensions.height10),
                          child: ExpandableText(text: product.description))
                    ],
                  ),
                )
              ],
            ),
            Align(
                alignment: Alignment.topCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          if(page=='cartpage'){
                            Get.toNamed(RouteHelper.getCartPage());
                          }else{
                            Get.toNamed(RouteHelper.getInitial());
                          }

                        },
                        child: AppIcon(

                            icon: Icons.arrow_back_ios,
                            left: Dimensions.width15,
                            top: Dimensions.height45)),

                    GetBuilder<PopularProductController>(builder: (controller) {
                      return GestureDetector(
                        onTap:(){
                          if( controller.totalItems >=1) {
                            Get.toNamed(RouteHelper.getCartPage());
                          }
                        },
                        child: Stack(
                          children: [

                            AppIcon(
                                icon: Icons.shopping_cart_outlined,
                                right: Dimensions.width15,
                                top: Dimensions.height45),
                          controller.totalItems >=
                                    1
                                ? Positioned(
                                    right: 1,
                                    top: 20,
                                    child: AppIcon(
                                        icon: Icons.circle,
                                        size: 23,
                                        iconColor: Colors.transparent,
                                        BgColor: AppColors.mainColor,size1: Dimensions.iconSize24,))
                                :AppIcon(
                                    icon: Icons.shopping_cart_outlined,
                                    right: Dimensions.width15,
                                    top: Dimensions.height45),
                         Get.find<PopularProductController>().totalItems >=
                                    1
                                ? Positioned(
                                    right: 7,
                                    top: Dimensions.height35,
                                    child: BigText(
                                      text:
                                          Get.find<PopularProductController>()
                                              .totalItems
                                              .toString(),
                                      size: 16,
                                      color: Colors.white,
                                    ))
                                :AppIcon(
                             icon: Icons.shopping_cart_outlined,
                             right: Dimensions.width15,
                             top: Dimensions.height45),
                          ],
                        ),
                      );
                    })
                  ],
                ))
          ],
        ),
        bottomNavigationBar:
            GetBuilder<PopularProductController>(builder: (popularProduct) {
          return Container(
            height: Dimensions.bottomNavHeight,
            padding: EdgeInsets.only(
                left: Dimensions.width30,
                right: Dimensions.width30,
                top: Dimensions.height30,
                bottom: Dimensions.height30),
            decoration: BoxDecoration(
                color: AppColors.buttonBackgroundColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(Dimensions.radius20 * 2),
                  topLeft: Radius.circular(Dimensions.radius20 * 2),
                )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                      top: Dimensions.height20,
                      bottom: Dimensions.height20),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 3),
                            blurRadius: 2,
                            color: Colors.black45)
                      ],
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: Colors.white),
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            popularProduct.setQuantity(false);
                          },
                          child: Icon(
                            Icons.remove,
                            color: AppColors.signColor,
                          )),
                      SizedBox(width: Dimensions.height10 / 2),
                      BigText(text: popularProduct.inCartItems.toString()),
                      SizedBox(width: Dimensions.height10 / 2),
                      GestureDetector(
                          onTap: () {
                            popularProduct.setQuantity(true);
                          },
                          child: Icon(
                            Icons.add,
                            color: AppColors.signColor,
                          )),
                    ],
                  ),
                ),
                SizedBox(width: Dimensions.width15),
                GestureDetector(
                  onTap: () {
                    popularProduct.addItem(product);
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                        left: Dimensions.width10/2,
                        right: Dimensions.width10/2,
                        top: Dimensions.height15,
                        bottom: Dimensions.height20),
                    child: BigText(
                      text: "${product.price} TL || Sepete Ekle",
                      color: Colors.black45,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius20),
                        color: AppColors.mainColor),
                  ),
                )
              ],
            ),
          );
        }));
  }
}
