import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:focusweb/controller/StringNames.dart';
import 'package:focusweb/controller/my_controller.dart';
import 'package:focusweb/helpers/utils/my_utils.dart';
import 'package:focusweb/helpers/utils/shopping_constants.dart';
import 'package:focusweb/models/shopping_cart_data.dart';
import 'package:focusweb/models/shopping_product_data.dart';

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
  /*
  getGuardDeitales2(String query) async {
    final guardDitales = FirebaseDatabase.instance.ref("Focus/Data");
    List<GuardData> guarddata = [];
    int i =0;
    try {

      DatabaseEvent snapshot = await guardDitales.once();

      List<dynamic>? values = snapshot.snapshot.value as List<dynamic>;

      for (var value in values) {
        if (value is Map<dynamic, dynamic>) {
          if(value['NAME_EN'].toString()!="Nill" && value['ID_NO'].toString()!=value['password'].toString()){

            if(query==""){
              GuardData location = GuardData(
                  value['BIRTHDAY'].toString(),
                  value['Contact'].toString(),
                  value['DATE_OF_JOINING'].toString(),
                  value['EMIRATES_ID'].toString(),
                  value['EMPLOYMENT_STATUS'].toString(),
                  int.parse(value['ID_NO'].toString()),
                  value['NAME_AR'].toString(),
                  value['NAME_EN'].toString(),
                  value['NATIONALITY'].toString(),
                  value['PASSPORT_EXPIRY_DATE']
                    ..toString(),
                  value['PASSPORT_NO'].toString(),
                  value['POSITION_AR'].toString(),
                  value['POSITION_EN'].toString(),
                  value['Place_of_residence'].toString(),
                  value['Pscod_Expiry'].toString(),
                  value['Pscod_ID'].toString(),
                  value['Shift'].toString(),
                  value['VIS_EXPIRY_DATE'].toString(),
                  value['password'].toString()
              );
              guarddata.add(location);
            }else{
              if((value["ID_NO"].toString().contains(query)||value["NAME_EN"].toString().toLowerCase().contains(query.toLowerCase())||value["NAME_AR"].toString().contains(query))) {
                GuardData location = GuardData(
                    value['BIRTHDAY'].toString(),
                    value['Contact'].toString(),
                    value['DATE_OF_JOINING'].toString(),
                    value['EMIRATES_ID'].toString(),
                    value['EMPLOYMENT_STATUS'].toString(),
                    int.parse(value['ID_NO'].toString()),
                    value['NAME_AR'].toString(),
                    value['NAME_EN'].toString(),
                    value['NATIONALITY'].toString(),
                    value['PASSPORT_EXPIRY_DATE']
                      ..toString(),
                    value['PASSPORT_NO'].toString(),
                    value['POSITION_AR'].toString(),
                    value['POSITION_EN'].toString(),
                    value['Place_of_residence'].toString(),
                    value['Pscod_Expiry'].toString(),
                    value['Pscod_ID'].toString(),
                    value['Shift'].toString(),
                    value['VIS_EXPIRY_DATE'].toString(),
                    value['password'].toString()
                );
                guarddata.add(location);
              }
            }
            i++;

          }
        }
      }


    } catch (error) {
      print('Error: $error');
    }

    setState(() {

      textaaaaa=i.toString();
      _Guard_Data.clear();
      _Guard_Data.addAll(guarddata);
      if(guarddata.isNotEmpty){
        _Guard_Data[0].co=Colors.orange;
        index1=0;
      }else{
        index1=-1;
      }




    });
/*
    int i=0;
    guardDitales.get().then((guarddata1) {

      final guarddata = <GuardData>[];
      if(query==""){
        for (var number=0;number<=1524;number++) {

          final guard = guarddata1.child("$number");
          if(guard.child("NAME_EN").value.toString()!="Nill" && guard.child("ID_NO").value.toString()!="password"){

            final guardata1 = GuardData(

                guard.child("BIRTHDAY").value.toString(),
                guard.child("Contact").value.toString(),
                guard.child("DATE_OF_JOINING").value.toString(),
                guard.child("EMIRATES_ID").value.toString(),
                guard.child("EMPLOYMENT_STATUS").value.toString(),
                int.parse( guard.child("ID_NO").value.toString()),
                guard.child("NAME_AR").value.toString(),
                guard.child("NAME_EN").value.toString(),
                guard.child("NATIONALITY").value.toString(),
                guard.child("PASSPORT_EXPIRY_DATE").value.toString(),
                guard.child("PASSPORT_NO").value.toString(),
                guard.child("POSITION_AR").value.toString(),
                guard.child("POSITION_EN").value.toString(),
                guard.child("Place_of_residence").value.toString(),
                guard.child("Pscod_Expiry").value.toString(),
                guard.child("Pscod_ID").value.toString(),
                guard.child("Shift").value.toString(),
                guard.child("VIS_EXPIRY_DATE").value.toString(),
                guard.child("password").value.toString()


            );
            guarddata.add(guardata1);
          }



        }
      }else{
        for (var number=0;number<=1442;number++) {
          final guard = guarddata1.child("$number");
          if(guard.child("NAME_EN").value.toString()!="Nill"&&(guard.child("ID_NO").value.toString().contains(query)||guard.child("NAME_EN").value.toString().toLowerCase().contains(query.toLowerCase())||guard.child("NAME_AR").value.toString().contains(query))){
            final guardata1 = GuardData(

                guard.child("BIRTHDAY").value.toString(),
                guard.child("Contact").value.toString(),
                guard.child("DATE_OF_JOINING").value.toString(),
                guard.child("EMIRATES_ID").value.toString(),
                guard.child("EMPLOYMENT_STATUS").value.toString(),
                int.parse( guard.child("ID_NO").value.toString()),
                guard.child("NAME_AR").value.toString(),
                guard.child("NAME_EN").value.toString(),
                guard.child("NATIONALITY").value.toString(),
                guard.child("PASSPORT_EXPIRY_DATE").value.toString(),
                guard.child("PASSPORT_NO").value.toString(),
                guard.child("POSITION_AR").value.toString(),
                guard.child("POSITION_EN").value.toString(),
                guard.child("Place_of_residence").value.toString(),
                guard.child("Pscod_Expiry").value.toString(),
                guard.child("Pscod_ID").value.toString(),
                guard.child("Shift").value.toString(),
                guard.child("VIS_EXPIRY_DATE").value.toString(),
                guard.child("password").value.toString()


            );
            guarddata.add(guardata1);
          }



        }
      }

      print('$i cont of guard');
 // التحقق من البيانات إذا كان ذلك مناسبًا
      setState(() {
        _Guard_Data.clear();
        _Guard_Data.addAll(guarddata);



      });
    });

    */
  }
*/

  getGuardDeitales(String query) async {

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
          /*
          LocationData location = LocationData(
              value['id'],
              value['tolal'],
              value['name'],
              value['day_time'],
              value['night_time'],
              value['hors'],
              double.parse(value['Latitude'].toString()),
              double.parse(value['longitude'].toString()));
*/
         // location1.add(location);
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
