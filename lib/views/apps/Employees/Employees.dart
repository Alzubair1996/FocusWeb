import 'package:feather_icons/feather_icons.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:focusweb/controller/apps/shopping_customer/shopping_customer_controller.dart';
import 'package:focusweb/helpers/utils/my_shadow.dart';
import 'package:focusweb/helpers/utils/ui_mixins.dart';
import 'package:focusweb/helpers/widgets/my_breadcrumb.dart';
import 'package:focusweb/helpers/widgets/my_breadcrumb_item.dart';

import 'package:focusweb/helpers/widgets/my_card.dart';
import 'package:focusweb/helpers/widgets/my_container.dart';

import 'package:focusweb/helpers/widgets/my_flex.dart';
import 'package:focusweb/helpers/widgets/my_flex_item.dart';
import 'package:focusweb/helpers/widgets/my_spacing.dart';
import 'package:focusweb/helpers/widgets/my_text.dart';
import 'package:focusweb/helpers/widgets/my_text_style.dart';
import 'package:focusweb/helpers/widgets/responsive.dart';
import 'package:focusweb/helpers/extensions/string.dart';

import 'package:focusweb/views/layouts/layout.dart';

import '../../../GuardDetails.dart';
import '../../../helpers/localizations/language.dart';
import '../../../helpers/theme/theme_customizer.dart';
import '../../../pdf_service.dart';

class Employees extends StatefulWidget {
  const Employees({super.key});

  @override
  State<Employees> createState() => _Employees();
}

class _Employees extends State<Employees>
    with SingleTickerProviderStateMixin, UIMixin {
  late ShoppingController controller;
  static List<GuardData> _Guard_Data = [];

String textaaaaa="";
int index1=-1;
  @override
  void initState() {
    getGuardDeitales("");
    controller = Get.put(ShoppingController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder<ShoppingController>(
        init: controller,
        builder: (controller) {
          return Column(
            children: [
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText.titleMedium(
                     "Number of people who registered $textaaaaa",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
FilledButton(onPressed: (){

}
  ,
  child: Text("get pdf"),
)

                    /*
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: "Apps"),
                        MyBreadcrumbItem(name: "Shopping", active: true),
                      ],
                    ),
                    */
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: MyFlex(
                  contentPadding: false,
                  children: [


                    MyFlexItem(
                      sizes: 'lg-4',
                      child: Column(
                        children: [





                          TextFormField(
                            onFieldSubmitted: (v){
                              String a="";
                              a=v;
                              getGuardDeitales(v);
                              v=a;
                            },
                            maxLines: 1,
                            style: MyTextStyle.bodyMedium(),
                            decoration: InputDecoration(
                                hintText: "search".tr(),
                                hintStyle:
                                MyTextStyle.bodySmall(xMuted: true),
                                border: outlineInputBorder,
                                enabledBorder: outlineInputBorder,
                                focusedBorder: focusedInputBorder,
                                prefixIcon: const Align(
                                    alignment: Alignment.center,
                                    child: Icon(
                                      FeatherIcons.search,
                                      size: 14,
                                    )),
                                prefixIconConstraints: const BoxConstraints(
                                    minWidth: 36,
                                    maxWidth: 36,
                                    minHeight: 32,
                                    maxHeight: 32),
                                contentPadding: MySpacing.xy(16, 16),
                                isCollapsed: false,
                                floatingLabelBehavior:
                                FloatingLabelBehavior.never),
                          ),

                          MyContainer(
                              height: 770,
                              child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                // التوجيه الأفقي
                                itemCount: _Guard_Data.length,

                                // عدد الأيام من 1 إلى 31
                                itemBuilder: (context, Index) {
                                  // تنسيق اليوم

                                  return Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: MyCard(
                                      onTap: (){
                                        setState(() {
                                          if(Index!=index1) {
                                            _Guard_Data[Index].co =
                                                Colors.orange;
                                            _Guard_Data[index1].co =
                                                Colors.white;
                                            index1 = Index;
                                          }
                                        });                                      },
                                      // تعيين Padding إلى صفر
                                      margin: EdgeInsets.only(left: 1),
                                      color: _Guard_Data[Index].co,

                                      child: SizedBox(
                                        width: 500,
                                        height: 100,
                                        // تحديد عرض العنصر حسب احتياجاتك
                                        child: Row(
                                          children: [
                                            Image.network("https://firebasestorage.googleapis.com/v0/b/focus-security.appspot.com/o/Images%2F${_Guard_Data[Index].ID_NO}.jpg?alt=media&token=36102f1a-cf5c-466d-b546-39cc9ed635f3",
                                            width: 100,
                                            height: 100,),
                                            SizedBox(
                                              width: double.maxFinite,
                                                child: Column(
                                              children: [

                                                Padding(
                                                  padding: const EdgeInsets.all(2.0),
                                                  child: Align(
                                                    alignment: Alignment.centerLeft,
                                                    child: Text(
                                                        "${_Guard_Data[Index].ID_NO}  ${ThemeCustomizer.instance.currentLanguage.locale.languageCode=='ar'
                                                            ?_Guard_Data[Index].NAME_AR:_Guard_Data[Index].NAME_EN}",
                                                      style: TextStyle(fontSize: 16,fontWeight: FontWeight.w900),),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(2.0),
                                                  child: Align(alignment:Alignment.centerLeft,child: Text(
                                                    "POSITION : ${_Guard_Data[Index].POSITION_EN}",
                                                    style: TextStyle(fontSize: 16,fontWeight: FontWeight.w900),)),
                                                ),
                                                 Padding(
                                                   padding: const EdgeInsets.all(2.0),
                                                   child: Align(alignment:Alignment.centerLeft,child: Text(
                                                      "Pscod_ID : ${_Guard_Data[Index].Pscod_ID}",
                                                      style: TextStyle(fontSize: 16,fontWeight: FontWeight.w900),)),
                                                 ),

                                             Padding(
                                               padding: const EdgeInsets.all(2.0),
                                               child: Align(alignment:Alignment.centerLeft,child: Text(
                                                      "Pscod_Expiry : ${_Guard_Data[Index].Pscod_Expiry}",
                                                      style: TextStyle(fontSize: 16,fontWeight: FontWeight.w900),)),
                                             ),

                                              ],
                                            )),



                                          ],
                                        ),
                                      ),

                                    ),
                                  );
                                },
                              )

                          ),
                        ],
                      ),
                    ),

                    MyFlexItem(
                      sizes: 'lg-4',
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: MyCard(child: SizedBox(
                              width: double.maxFinite,
                                child: Text("Guard of Details",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w900),))),
                          ),
                          Visibility(visible: true,
                            child: MyContainer(
                              child: index1==-1?Container():
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [


                                  MyCard(

                                    // تعيين Padding إلى صفر
                                    margin: EdgeInsets.only(left: 1),
                                    color: _Guard_Data[index1].co,

                                    child: SizedBox(
                                      width: 500,
                                      height: 100,
                                      // تحديد عرض العنصر حسب احتياجاتك
                                      child: Row(
                                        children: [
                                          Image.network("https://firebasestorage.googleapis.com/v0/b/focus-security.appspot.com/o/Images%2F${_Guard_Data[index1].ID_NO}.jpg?alt=media&token=36102f1a-cf5c-466d-b546-39cc9ed635f3",
                                            width: 100,
                                            height: 100,),
                                          SizedBox(
                                              width: double.maxFinite,
                                              child: Column(
                                                children: [

                                                  Padding(
                                                    padding: const EdgeInsets.all(2.0),
                                                    child: Align(
                                                      alignment: Alignment.centerLeft,
                                                      child: Text(
                                                        "${_Guard_Data[index1].ID_NO}  ${ThemeCustomizer.instance.currentLanguage.locale.languageCode=='ar'
                                                            ?_Guard_Data[index1].NAME_AR:_Guard_Data[index1].NAME_EN}",
                                                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.w900),),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(2.0),
                                                    child: Align(alignment:Alignment.centerLeft,child: Text(
                                                      "POSITION : ${_Guard_Data[index1].POSITION_EN}",
                                                      style: TextStyle(fontSize: 16,fontWeight: FontWeight.w900),)),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(2.0),
                                                    child: Align(alignment:Alignment.centerLeft,child: Text(
                                                      "Pscod_ID : ${_Guard_Data[index1].Pscod_ID}",
                                                      style: TextStyle(fontSize: 16,fontWeight: FontWeight.w900),)),
                                                  ),

                                                  Padding(
                                                    padding: const EdgeInsets.all(2.0),
                                                    child: Align(alignment:Alignment.centerLeft,child: Text(
                                                      "Pscod_Expiry : ${_Guard_Data[index1].Pscod_Expiry}",
                                                      style: TextStyle(fontSize: 16,fontWeight: FontWeight.w900),)),
                                                  ),

                                                ],
                                              )),



                                        ],
                                      ),
                                    ),

                                  ),

                            MyCard(
                              child: Align(alignment:Alignment.centerLeft,child: Text(
                                   "NATIONALITY : ${_Guard_Data[index1].NATIONALITY}",
                                    style: TextStyle(fontSize: 16,fontWeight: FontWeight.w900),)),
                              ),
                            MyCard(

                                child: Align(alignment:Alignment.centerLeft,child: Text(
                                    "DATE_OF_JOINING : ${_Guard_Data[index1].DATE_OF_JOINING}",
                                    style: TextStyle(fontSize: 16,fontWeight: FontWeight.w900),)),
                              ),
                            MyCard(

                                child:  Align(alignment:Alignment.centerLeft,child: Text(
                                    "Contact : ${_Guard_Data[index1].Contact}",
                                    style: TextStyle(fontSize: 16,fontWeight: FontWeight.w900),)),
                              ),
                            MyCard(

                                child:   Align(alignment:Alignment.centerLeft,child: Text(
                                    "BIRTHDAY : ${_Guard_Data[index1].BIRTHDAY}",
                                    style: TextStyle(fontSize: 16,fontWeight: FontWeight.w900),)),
                              ),
                                  MyCard(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child:   Align(alignment:Alignment.centerLeft,child: Text(
                                    "EMIRATES_ID : ${_Guard_Data[index1].EMIRATES_ID}",
                                    style: TextStyle(fontSize: 16,fontWeight: FontWeight.w900),)),

                          )),
                            MyCard(

                                child: Align(alignment:Alignment.centerLeft,child: Text(
                                    "PASSPORT_NO : ${_Guard_Data[index1].PASSPORT_NO}",
                                    style: TextStyle(fontSize: 16,fontWeight: FontWeight.w900),)),
                              ),
                            MyCard(

                                child:  Align(alignment:Alignment.centerLeft,child: Text(
                                    "PASSPORT_EXPIRY_DATE : ${_Guard_Data[index1].PASSPORT_EXPIRY_DATE}",
                                    style: TextStyle(fontSize: 16,fontWeight: FontWeight.w900),)),
                              ),
                            MyCard(
                              child:
                                Align(alignment:Alignment.centerLeft,child: Text(
                                    "Place_of_residence : ${_Guard_Data[index1].Place_of_residence}",
                                    style: TextStyle(fontSize: 16,fontWeight: FontWeight.w900),)),
                              ),

                            MyCard(

                                child: Align(alignment:Alignment.centerLeft,child: Text(
                                    "VIS_EXPIRY_DATE : ${_Guard_Data[index1].VIS_EXPIRY_DATE}",
                                    style: TextStyle(fontSize: 16,fontWeight: FontWeight.w900),)),
                              ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    //Shopping Cart--------------------

                    MyFlexItem(
                      sizes: 'lg-4',
                      child: Column(
                        children: [
                          Text("data"),
                          Visibility(visible: true,
                            child: MyContainer(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyText.titleMedium(
                                    '',
                                    fontWeight: 600,
                                  ),
                                  MySpacing.height(12),
                                  ListView(
                                    shrinkWrap: true,
                                    children: [
                                      Text("data"),
                                      //  buildCartList(),
                                      MySpacing.height(32),
                                      //    billingWidget(),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),


                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }


  getGuardDeitales(String query) async {
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
}
