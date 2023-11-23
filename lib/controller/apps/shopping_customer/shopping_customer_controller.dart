import 'package:get/get.dart';
import 'package:webkit/controller/my_controller.dart';
import 'package:webkit/helpers/utils/my_utils.dart';
import 'package:webkit/helpers/utils/shopping_constants.dart';
import 'package:webkit/models/shopping_cart_data.dart';
import 'package:webkit/models/shopping_product_data.dart';

class ShoppingController extends MyController {
  List<ShoppingProduct> shopping = [];





  @override
  void onInit() {
    fetchData();
    ShoppingProduct.dummyList.then((value) {

      shopping = value;

      update();
    });


    super.onInit();
  }



  void onChangeProduct(ShoppingProduct product) {

    update();
  }

  bool increaseAble(ShoppingCart cart) {
    return cart.quantity < cart.product.id;
  }

  bool decreaseAble(ShoppingCart cart) {
    return cart.quantity > 1;
  }

  void increment(ShoppingCart cart) {
    if (!increaseAble(cart)) return;
    cart.quantity++;
    calculateBilling();
    update();
  }

  void decrement(ShoppingCart cart) {
    if (!decreaseAble(cart)) return;
    cart.quantity--;
    calculateBilling();
    update();
  }

  void fetchData() async {

    calculateBilling();
    update();
  }

  void calculateBilling() {

    update();
  }
}
