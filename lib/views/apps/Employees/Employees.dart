import 'package:feather_icons/feather_icons.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:webkit/controller/apps/shopping_customer/shopping_customer_controller.dart';
import 'package:webkit/helpers/utils/my_shadow.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/helpers/widgets/my_breadcrumb.dart';
import 'package:webkit/helpers/widgets/my_breadcrumb_item.dart';

import 'package:webkit/helpers/widgets/my_card.dart';
import 'package:webkit/helpers/widgets/my_container.dart';

import 'package:webkit/helpers/widgets/my_flex.dart';
import 'package:webkit/helpers/widgets/my_flex_item.dart';
import 'package:webkit/helpers/widgets/my_spacing.dart';
import 'package:webkit/helpers/widgets/my_text.dart';
import 'package:webkit/helpers/widgets/my_text_style.dart';
import 'package:webkit/helpers/widgets/responsive.dart';
import 'package:webkit/helpers/extensions/string.dart';

import 'package:webkit/views/layouts/layout.dart';

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


  final Reference storageReference = FirebaseStorage.instance.ref().child('Images/1406.jpg');
  String imageUrl="https://firebasestorage.googleapis.com/v0/b/focusdata/o/1414.jpg?alt=media&token=8f4a8c63-732b-46c8-b95d-8c6a0e5ec70b";
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
                      "DataOFEmployees".tr(),
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

                                  return Card(
                                    // تعيين Padding إلى صفر
                                    margin: EdgeInsets.only(left: 1),
                                    color: Color(0xffffffff),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(6.0),
                                          topRight: Radius.circular(6.0)),
                                    ),
                                    child: SizedBox(
                                      width: 500,
                                      height: 100,
                                      // تحديد عرض العنصر حسب احتياجاتك
                                      child: Row(
                                        children: [
                                          Image.network("https://firebasestorage.googleapis.com/v0/b/focus-security.appspot.com/o/Images%2F"+_Guard_Data[Index].ID_NO.toString()+".jpg?alt=media&token=36102f1a-cf5c-466d-b546-39cc9ed635f3",
                                          width: 100,
                                          height: 100,),
                                          Center(child: Text(
                                              ThemeCustomizer.instance.currentLanguage.locale.languageCode =='ar'?_Guard_Data[Index].NAME_AR:_Guard_Data[Index].NAME_EN)),



                                        ],
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
                        child: Text("]") //buildCart(),
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


  getGuardDeitales(String query){
    final guardDitales = FirebaseDatabase.instance.ref("Focus/Data");

    guardDitales.get().then((guarddata1) {
      final guarddata = <GuardData>[];
      if(query==""){
        for (var number=0;number<=1442;number++) {
          final guard = guarddata1.child("$number");
          if(guard.child("NAME_EN").value.toString()!="Nill"){
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

 // التحقق من البيانات إذا كان ذلك مناسبًا
      setState(() {
        _Guard_Data.clear();
        _Guard_Data.addAll(guarddata);



      });
    });
  }
}
