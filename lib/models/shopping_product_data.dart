import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';
import 'package:webkit/helpers/extensions/extensions.dart';
import 'package:webkit/helpers/services/json_decoder.dart';
import 'package:webkit/models/identifier_model.dart';

class ShoppingProduct extends IdentifierModel {
  String Contact, DATE_OF_JOINING, EMIRATES_ID,EMPLOYMENT_STATUS,
  ID_NO
  ,NAME_AR
  ,NAME_EN
  ,NATIONALITY
  ,PASSPORT_EXPIRY_DATE
  ,PASSPORT_NO
  ,POSITION_AR
  ,POSITION_EN
  ,Pscod_Expiry
  ,Pscod_ID
  ,Shift
  ,VIS_EXPIRY_DATE;





  ShoppingProduct(
     super.id,
      this.Contact,
      this.ID_NO,
      this.DATE_OF_JOINING,
      this.EMIRATES_ID,
      this.EMPLOYMENT_STATUS,
      this.NAME_AR,
      this.NAME_EN,
      this.NATIONALITY,
      this.PASSPORT_EXPIRY_DATE,
      this.PASSPORT_NO,
      this.POSITION_AR,
      this.POSITION_EN,
      this.Pscod_Expiry,
      this.Pscod_ID,
      this.Shift,
      this.VIS_EXPIRY_DATE);
  static ShoppingProduct fromJSON(Map<String, dynamic> json) {
    JSONDecoder decoder = JSONDecoder(json);

    String ID_NO = decoder.getString('ID_NO');
    String Contact = decoder.getString('Contact');
    String DATE_OF_JOINING = decoder.getString('DATE_OF_JOINING');
    String EMIRATES_ID = decoder.getString('EMIRATES_ID');
    String EMPLOYMENT_STATUS = decoder.getString('EMPLOYMENT_STATUS');
    String NAME_AR = decoder.getString('NAME_AR');
    String NAME_EN = decoder.getString('NAME_EN');
    String NATIONALITY = decoder.getString('NATIONALITY');
    String PASSPORT_EXPIRY_DATE = decoder.getString('PASSPORT_EXPIRY_DATE');
    String PASSPORT_NO = decoder.getString('PASSPORT_NO');
    String POSITION_AR = decoder.getString('POSITION_AR');
    String POSITION_EN = decoder.getString('POSITION_EN');
    String Pscod_Expiry = decoder.getString('Pscod_Expiry');
    String Pscod_ID = decoder.getString('Pscod_ID');
    String Shift = decoder.getString('Shift');
    String VIS_EXPIRY_DATE = decoder.getString('VIS_EXPIRY_DATE');



    return ShoppingProduct(
      decoder.getId,
  Contact,
  ID_NO,
  DATE_OF_JOINING,
  EMIRATES_ID,
  EMPLOYMENT_STATUS,
  NAME_AR,
  NAME_EN,
  NATIONALITY,
  PASSPORT_EXPIRY_DATE,
  PASSPORT_NO,
  POSITION_AR,
  POSITION_EN,
  Pscod_Expiry,
  Pscod_ID,
  Shift,
  VIS_EXPIRY_DATE
    );
  }

  static List<ShoppingProduct> listFromJSON(List<dynamic> list) {
    return list.map((e) => ShoppingProduct.fromJSON(e)).toList();
  }

  static List<ShoppingProduct>? _dummyList;

  static Future<List<ShoppingProduct>> get dummyList async {
    if (_dummyList == null) {
      dynamic data = json.decode(await getData());
      _dummyList = listFromJSON(data);
    }

    return _dummyList!.sublist(0, 10);
  }


  static Future<String> getData() async {

    DatabaseReference _databaseReference;


      _databaseReference = FirebaseDatabase.instance.reference();


      // احصل على البيانات من قاعدة البيانات
      DataSnapshot snapshot = await _databaseReference.child("Focus/Data").get();


      // تحويل البيانات إلى شكل JSON

      String dataAsJson = jsonEncode(snapshot.value);

      // إرجاع البيانات كنص
      return dataAsJson;


/*
    final DatabaseReference databaseReference = FirebaseDatabase.instance.reference();


    Query query = databaseReference.child('users');

    // احتفظ بـ DataSnapshot كمتغير مناسب
    DataSnapshot dataSnapshot;

    // استخدم Query.once() للحصول على البيانات
    try {
      dataSnapshot = await query.once();
    } catch (error) {
      print("حدث خطأ: $error");

    }

    // الآن يمكنك استخدام dataSnapshot كمتغير من نوع DataSnapshot
    Map<dynamic, dynamic> data = dataSnapshot.value;
   // final locationRef = FirebaseDatabase.instance.ref("Focus/Data");
    /*
    DataSnapshot snapshot = await databaseReference.child('users').once();
    Map<dynamic, dynamic> data = snapshot.value;
    locationRef.get().then((locationData) {

    });

     */
    return await rootBundle.loadString('assets/datas/shopping_product.json');

    */
  }
}
