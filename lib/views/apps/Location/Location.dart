import 'package:feather_icons/feather_icons.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
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
import '../../../LocationData.dart';
import '../../../controller/StringNames.dart';
import '../../../controller/apps/shopping_customer/shopping_customer_controller.dart';
import '../../../helpers/localizations/language.dart';
import '../../../helpers/theme/theme_customizer.dart';
import '../../../pdf_service.dart';

class Location extends StatefulWidget {
  const Location({super.key});

  @override
  State<Location> createState() => _Location();
}

class _Location extends State<Location> {
  late ShoppingController controller;

int select_index=-1;
  @override
  void initState() {



    super.initState();
 //   getGuardDeitales("");

    controller = Get.put(ShoppingController());
     controller.getGuardDeitales("");
  }

  @override
  Widget build(BuildContext context) {

    return Layout(
      child: GetBuilder<ShoppingController>(
        init: controller,
        builder: (controller) {
          return Align(
            alignment: Alignment.centerLeft,
            child: Column(
              children: [
                MyText.titleMedium(
                  "Location1".tr(),
                  fontSize: 18,
                  fontWeight: 600,
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
                              onFieldSubmitted: (v) {
                                String a = "";
                                a = v;
                             //   getGuardDeitales(v);
                                v = a;
                              },
                              maxLines: 1,
                              style: MyTextStyle.bodyMedium(),
                              decoration: InputDecoration(
                                  hintText: "search".tr(),
                                  hintStyle:
                                      MyTextStyle.bodySmall(xMuted: true),
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
                                  itemCount: controller.location1lla.length,

                                  // عدد الأيام من 1 إلى 31
                                  itemBuilder: (context, Index) {

                                    // تنسيق اليوم

                                    return Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: MyCard(
                                        onTap: (){
                                          controller.onChangeProduct(Index);
                                          StringNemes.locations_items=Index;

                                         // if(select_index)
                                        },
                                        // تعيين Padding إلى صفر
                                        margin: EdgeInsets.only(left: 1),
                                        color: controller.location1lla[Index].color,

                                        child: SizedBox(
                                          width: 500,
                                          height: 100,
                                          // تحديد عرض العنصر حسب احتياجاتك
                                          child: Column(
                                            children: [
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                      controller.location1lla[Index].name,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w900)),
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                      "Total Of guard ${controller.location1lla[Index].tolal}",
                                                  style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }


}
