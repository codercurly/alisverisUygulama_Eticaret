import 'package:flutter/material.dart';
import 'package:food_delivery/base/common_text_button.dart';
import 'package:food_delivery/base/no_data_page.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/location_controller.dart';
import 'package:food_delivery/controllers/order_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_controller.dart';
import 'package:food_delivery/controllers/user_controller.dart';
import 'package:food_delivery/models/place_order_model.dart';
import 'package:food_delivery/pages/home/main_food_page.dart';
import 'package:food_delivery/pages/order/delivery_option.dart';
import 'package:food_delivery/route/route_helper.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_icons.dart';
import 'package:food_delivery/widgets/app_text_field.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/payment_option_button.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _noteController = TextEditingController();
    return Scaffold(
        body: Stack(
          children: [
            Positioned(
                left: Dimensions.width20,
                right: Dimensions.width20,
                top: Dimensions.height20 * 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getInitial());
                      },
                      child: AppIcon(
                        icon: Icons.arrow_back_ios,
                        BgColor: AppColors.mainColor,
                        size: Dimensions.iconSize31,
                        iconColor: Colors.white,
                      ),
                    ),
                    SizedBox(width: Dimensions.width50),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getInitial());
                      },
                      child: AppIcon(
                        icon: Icons.home,
                        BgColor: AppColors.mainColor,
                        size: Dimensions.iconSize31,
                        iconColor: Colors.white,
                      ),
                    ),
                    AppIcon(
                      icon: Icons.shopping_cart,
                      BgColor: AppColors.mainColor,
                      size: Dimensions.iconSize31,
                      iconColor: Colors.white,
                    )
                  ],
                )),
            GetBuilder<CartController>(builder: (_cartController) {
              return _cartController.getItems.length > 0
                  ? Positioned(
                      top: Dimensions.height30 * 3.20,
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                      bottom: 0,
                      child: Container(
                        margin: EdgeInsets.only(top: Dimensions.height10),
                        child: MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child: GetBuilder<CartController>(
                                builder: (cartController) {
                              var _cartList = cartController.getItems;
                              return ListView.builder(
                                  itemCount: _cartList.length,
                                  itemBuilder: (_, index) {
                                    return Container(
                                      height: Dimensions.height20 * 5,
                                      width: double.maxFinite,
                                      child: Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              var popularIndex = Get.find<
                                                      PopularProductController>()
                                                  .popularProductList
                                                  .indexOf(
                                                      _cartList[index].product);
                                              if (popularIndex >= 0) {
                                                Get.toNamed(
                                                    RouteHelper.getPopularFood(
                                                        popularIndex,
                                                        'cartpage'));
                                              } else {
                                                var recommendedIndex = Get.find<
                                                        RecommendedProductController>()
                                                    .recommendedProductList
                                                    .indexOf(_cartList[index]
                                                        .product);
                                                if (recommendedIndex < 0) {
                                                  Get.snackbar(
                                                      "ürün geçmişi bulunamadı",
                                                      "Ürün geçmişte mevcut değil",
                                                      backgroundColor:
                                                          AppColors.mainColor,
                                                      colorText: Colors.white);
                                                } else {
                                                  Get.toNamed(RouteHelper
                                                      .getRecommendedFood(
                                                          recommendedIndex,
                                                          "cartpage"));
                                                }
                                              }
                                            },
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  bottom: Dimensions.height10 /
                                                      1.8),
                                              width: Dimensions.height20 * 5,
                                              height: Dimensions.height20 * 5,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                          AppConstants
                                                                  .BASE_URL +
                                                              AppConstants
                                                                  .UPLOADS_URI +
                                                              cartController
                                                                  .getItems[
                                                                      index]
                                                                  .img!)),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          Dimensions.radius20),
                                                  color: Colors.white),
                                            ),
                                          ),
                                          SizedBox(width: Dimensions.width15),
                                          Expanded(
                                              child: Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                BigText(
                                                    text: cartController
                                                        .getItems[index].name),
                                                SmallText(
                                                    text: cartController
                                                        .getItems[index].name),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    BigText(
                                                        text:
                                                            "${cartController.getItems[index].price.toString()} TL",
                                                        color:
                                                            Colors.redAccent),
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                          left: Dimensions
                                                              .width10,
                                                          right: Dimensions
                                                              .width10,
                                                          top: Dimensions
                                                              .height10,
                                                          bottom: Dimensions
                                                              .height10),
                                                      decoration: BoxDecoration(
                                                          boxShadow: [
                                                            BoxShadow(
                                                                offset: Offset(
                                                                    0, 3),
                                                                blurRadius: 2,
                                                                color: Colors
                                                                    .black45)
                                                          ],
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  Dimensions
                                                                      .radius20),
                                                          color: Colors.white),
                                                      child: Row(
                                                        children: [
                                                          GestureDetector(
                                                              onTap: () {
                                                                cartController.addItem(
                                                                    _cartList[
                                                                            index]
                                                                        .product!,
                                                                    -1);
                                                              },
                                                              child: Icon(
                                                                Icons.remove,
                                                                color: AppColors
                                                                    .signColor,
                                                              )),
                                                          SizedBox(
                                                              width: Dimensions
                                                                      .height10 /
                                                                  2),
                                                          BigText(
                                                              text: _cartList[
                                                                      index]
                                                                  .quantity
                                                                  .toString()),
                                                          SizedBox(
                                                              width: Dimensions
                                                                      .height10 /
                                                                  2),
                                                          GestureDetector(
                                                              onTap: () {
                                                                cartController.addItem(
                                                                    _cartList[
                                                                            index]
                                                                        .product!,
                                                                    1);
                                                              },
                                                              child: Icon(
                                                                Icons.add,
                                                                color: AppColors
                                                                    .signColor,
                                                              )),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                            height: Dimensions.height20 * 5,
                                          ))
                                        ],
                                      ),
                                    );
                                  });
                            })),
                      ))
                  : NoDataPage(
                      text: "sepet boş",
                    );
            })
          ],
        ),
        bottomNavigationBar:
            GetBuilder<OrderController>(builder: (orderController) {
              _noteController.text=orderController.foodnote;
          return GetBuilder<CartController>(builder: (cartController) {
            return Container(
              height: Dimensions.bottomNavHeight,
              padding: EdgeInsets.only(
                  left: Dimensions.width30,
                  right: Dimensions.width30,
                  top: 0,
                  bottom: 1),
              decoration: BoxDecoration(
                  color: AppColors.buttonBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(Dimensions.radius20 * 2),
                    topLeft: Radius.circular(Dimensions.radius20 * 2),
                  )),
              child: cartController.getItems.length > 0
                  ? Column(
                      children: [
                        InkWell(
                            onTap: () => showModalBottomSheet(
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (_) {
                                  return Column(
                                    children: [
                                      Expanded(
                                        child: SingleChildScrollView(
                                          child: Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.9,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(
                                                        Dimensions.radius20),
                                                    topRight: Radius.circular(
                                                        Dimensions.radius20))),
                                            child: Column(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.all(
                                                      Dimensions.height20),
                                                  height: 500,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      PaymentOptionButton(
                                                          icon: Icons.money,
                                                          title: "kapıda öde",
                                                          subTitle:
                                                              "teslimat aldıktan sonra ödersiniz",
                                                          index: 0),
                                                      SizedBox(
                                                          height: Dimensions
                                                              .height10),
                                                      PaymentOptionButton(
                                                          icon: Icons
                                                              .paypal_outlined,
                                                          title: "Dijital öde",
                                                          subTitle:
                                                              "güvenli ve hızlı ödeme",
                                                          index: 1),
                                                      SizedBox(
                                                          height: Dimensions
                                                              .height30),
                                                      Text(
                                                        "Teslimat Seçenekleri",
                                                        style: TextStyle(
                                                            fontSize: Dimensions
                                                                .iconSize24),
                                                      ),
                                                      SizedBox(
                                                          height: Dimensions
                                                              .height10),
                                                      DeliveryOption(
                                                          value: "delivery",
                                                          amount: double.parse(
                                                              Get.find<
                                                                      CartController>()
                                                                  .totalAmount
                                                                  .toString()),
                                                          title: "Kapıda öde",
                                                          isFree: false),
                                                      const DeliveryOption(
                                                          value: "gel al",
                                                          amount: 10.0,
                                                          title: "Gel al",
                                                          isFree: true),
                                                      SizedBox(
                                                          height: Dimensions
                                                              .height10),
                                                      Text("Not ",
                                                          style: TextStyle(
                                                              fontSize:
                                                                  Dimensions
                                                                      .font23)),
                                                      AppTextField(
                                                        textEditingController:
                                                            _noteController,
                                                        hintText: "not bırakın",
                                                        icon: Icons.note,
                                                        maxLines: true,
                                                      )
                                                    ],
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }).whenComplete(() => orderController.setFoodNote(_noteController.text.trim())),
                            child: Container(
                                width: double.maxFinite,
                                child: CommonTextButton(
                                    text: "ödeme seçenekleri"))),
                        SizedBox(height: 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.all(
                                Dimensions.width10
                                ),
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        offset: Offset(0, 3),
                                        blurRadius: 2,
                                        color: Colors.black45)
                                  ],
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radius20),
                                  color: Colors.white),
                              child: Row(
                                children: [
                                  SizedBox(width: Dimensions.height10 / 2),
                                  BigText(
                                      text: cartController.totalAmount
                                              .toString() +
                                          "  TL"),
                                  SizedBox(width: Dimensions.height10 / 2),
                                ],
                              ),
                            ),
                            SizedBox(width: Dimensions.width15),
                            GestureDetector(
                              onTap: () {
                                // popularProduct.addItem(product);
                                if (Get.find<AuthController>().userLoggedIn()) {
                                  //cartController.addToHistory();
                                  if (Get.find<LocationController>()
                                          .addressList
                                          .isEmpty &&
                                      Get.find<LocationController>()
                                              .getUserAddressFromlocalStroage() ==
                                          "") {
                                    Get.offNamed(RouteHelper.getAddressPage());
                                  } else {
                                    var location =
                                        Get.find<LocationController>()
                                            .getUserAddress();
                                    var cart =
                                        Get.find<CartController>().getItems;
                                    var user =
                                        Get.find<UserController>().userModel;
                                    PlaceOrderBody placeOrder = PlaceOrderBody(
                                      paymentMethod: orderController.paymentIndex==0?'cash_on_delivery':
                                        'digital_payment',
                                        orderType: orderController.orderType,
                                        cart: cart,
                                        orderAmount: 100.0,
                                        orderNote: orderController.foodnote,
                                        address: location.address,
                                        latitude: location.latitude,
                                        longitude: location.longitude,
                                        contactPersonName: user!.name!,
                                        scheduleAt: '',
                                        contactPersonNumber: user!.phone!,
                                        distance: 10.0);
                                    Get.find<OrderController>()
                                        .placeOrder(placeOrder, _callback);
                                  }
                                } else {
                                  Get.toNamed(RouteHelper.getSignInPage());
                                }
                              },
                              child: CommonTextButton(text: "Kontrol Et"),
                            )
                          ],
                        ),
                      ],
                    )
                  : Container(),
            );
          });
        }));
  }

  void _callback(bool isSuccess, String message, String orderID) {
    if (isSuccess) {
      Get.find<CartController>().clear();
      Get.find<CartController>().removeCartSharedPrefence();
      Get.find<CartController>().addToHistory();
      if(Get.find<OrderController>().paymentIndex==0){
 Get.offNamed(RouteHelper.getOrderSuccessPage(orderID, 'success'));
      }else{
        Get.offNamed(RouteHelper.getPaymentPage(
            orderID, Get.find<UserController>().userModel!.id));
      }

    } else {
      print(message);
    }
  }
}
