import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webkit/controller/StringNames.dart';
import 'package:webkit/controller/my_controller.dart';
import 'package:webkit/helpers/utils/my_utils.dart';
import 'package:webkit/helpers/utils/shopping_constants.dart';
import 'package:webkit/models/shopping_cart_data.dart';
import 'package:webkit/models/shopping_product_data.dart';

import '../../../LocationData.dart';

class ShoppingController extends MyController {
  List<ShoppingProduct> shopping = [];

  final location1lla = <LocationData>[];



  @override
  void onInit() {
    fetchData();
    ShoppingProduct.dummyList.then((value) {

      shopping = value;

      update();
    });


    super.onInit();
  }



  void onChangeProduct(int indix ) {
    if (StringNemes.locations_items != indix) {
      location1lla[indix].color=Colors.orange;
      if(StringNemes.locations_items!=-1){
        location1lla[StringNemes.locations_items].color=Colors.white;
      }
      update();
    }
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
  getGuardDeitales(String query) async {

      print("ðdddddddd");
      DatabaseReference eventReflocaton =
      FirebaseDatabase.instance.ref("Focus/Locatins");

      final location1 = <LocationData>[];
      try {
        DatabaseEvent snapshot = await eventReflocaton.once();

        Map<dynamic, dynamic>? values1 =
        snapshot.snapshot.value as Map<dynamic, dynamic>;

        List<MapEntry> entries = values1.entries.toList();

// Sort the list based on the 'name' value
        entries.sort((a, b) => (a.value['id']).compareTo(b.value['id']));

// Create a new map with sorted entries
        Map<String, dynamic> sortedMap =
        Map.fromEntries(entries as Iterable<MapEntry<String, dynamic>>);

        sortedMap.forEach((key, value) {
          LocationData location = LocationData(
              value['id'],
              value['tolal'],
              value['name'],
              value['day_time'],
              value['night_time'],
              value['hors'],
              double.parse(value['Latitude'].toString()),
              double.parse(value['longitude'].toString()));

          location1.add(location);
        });
      } catch (error) {
        print('Error: $error');
      }


        location1lla.clear();
        location1lla.addAll(location1);


    }



  void calculateBilling() {

    update();
  }
}
