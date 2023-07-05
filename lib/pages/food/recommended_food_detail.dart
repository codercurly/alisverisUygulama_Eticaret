import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_controller.dart';
import 'package:food_delivery/pages/cart/cart_page.dart';
import 'package:food_delivery/route/route_helper.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_icons.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/expandable_text_widget.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';

class RecommendedFoodDetail extends StatelessWidget {
  final int pageId;
  final String page;
 const RecommendedFoodDetail({Key? key, required this.pageId, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product = Get.find<RecommendedProductController>().recommendedProductList[pageId];
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());
    return Scaffold(
      body: CustomScrollView(

        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 50,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap:(){
                      if(page=='cartpage'){
                        Get.toNamed(RouteHelper.getCartPage());
                      }else{
                        Get.toNamed(RouteHelper.getInitial());
                      }
                    },

                    child: AppIcon(icon: Icons.clear,left: 3)),
               // AppIcon(icon: Icons.shopping_cart_outlined)
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
                            top: Dimensions.height10/5),
                        Get.find<PopularProductController>().totalItems >=
                            1
                            ? Positioned(
                            right: 0,
                            top:-10,
                            child: AppIcon(
                                icon: Icons.circle,
                                size: 25,
                                iconColor: Colors.transparent,
                                BgColor: AppColors.mainColor,
                              size1: Dimensions.iconSize24,
                            ))
                            :AppIcon(
                            icon: Icons.shopping_cart_outlined,
                            right: Dimensions.width15,
                            top: Dimensions.height10/5),
                        Get.find<PopularProductController>().totalItems >=
                            1
                            ? Positioned(
                            right: 7,
                            top: Dimensions.height10/10,
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
                            top: Dimensions.height10/5),
                      ],
                    ),
                  );
                })
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(15),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(Dimensions.radius20),
                    topLeft: Radius.circular(Dimensions.radius20)
                  )
                ),
                padding: EdgeInsets.all(Dimensions.width10),
                width: double.maxFinite,

                child: Center(child: BigText(text: product.name))
              ),
            ),
            pinned: true,
            backgroundColor: AppColors.yellowColor,
            expandedHeight: 200,
            flexibleSpace:   FlexibleSpaceBar(
            background: Image.network(AppConstants.BASE_URL +
                AppConstants.UPLOADS_URI +product.img!,
            width: double.maxFinite,
            fit: BoxFit.cover),
            ),
          ),
          SliverToBoxAdapter(

            child: Column(
              children: [
                Container(
                  padding:EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20),
                  child: ExpandableText(text: product.description
    ),
                ),
              ],
            ),
          )

        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(builder: (controller){
        return  Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.only(left: Dimensions.width20*2.4,right:Dimensions.width20*2.4,
                  top: Dimensions.height10,
                  bottom: Dimensions.height10
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  GestureDetector(
                      onTap:(){
                        controller.setQuantity(false);
                      },
                      child: AppIcon(BgColor: AppColors.mainColor,iconColor: Colors.white, icon: Icons.remove)),
                  BigText(text: "${product.price} TL  X  ${controller.inCartItems} ",color: AppColors.mainBlackColor,size: Dimensions.font26,),
                  GestureDetector(
                      onTap:(){
                        controller.setQuantity(true);
                      },
                      child: AppIcon(BgColor: AppColors.mainColor,iconColor: Colors.white, icon: Icons.add))
                ],
              ),
            ),
            Container(
              height: Dimensions.bottomNavHeight,
              padding: EdgeInsets.only(left: Dimensions.width30,right: Dimensions.width30,top: Dimensions.height30, bottom: Dimensions.height30),
              decoration: BoxDecoration(
                  color: AppColors.buttonBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular( Dimensions.radius20*2),
                    topLeft: Radius.circular( Dimensions.radius20*2),
                  )
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20,top: Dimensions.height20, bottom: Dimensions.height20),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0,3),
                              blurRadius:2,
                              color: Colors.black45)
                        ],
                        borderRadius: BorderRadius.circular(Dimensions.radius20),
                        color: Colors.white
                    ),
                    child: Icon(
                      Icons.favorite,
                      color: AppColors.mainColor,
                    ),
                  ),
                  SizedBox(width: Dimensions.width15),
                  GestureDetector(
                    onTap: (){
                      controller.addItem(product);
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20,top: Dimensions.height20, bottom: Dimensions.height20),
                      child: BigText(text: "${product.price} TL || Sepete Ekle",color: Colors.black45,),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radius20),
                          color: AppColors.mainColor
                      ),

                    ),
                  )
                ],

              ),
            )
          ],
        );
      })
    );
  }
}
