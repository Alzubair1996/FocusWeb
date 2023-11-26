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
import '../../../LocationData.dart';
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
  final location1lla = <LocationData>[];

  @override
  void initState() {
    controller = Get.put(ShoppingController());
    super.initState();
    getGuardDeitales("");
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
                                getGuardDeitales(v);
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
                                  itemCount: location1lla.length,

                                  // عدد الأيام من 1 إلى 31
                                  itemBuilder: (context, Index) {
                                    // تنسيق اليوم

                                    return Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: MyCard(
                                        // تعيين Padding إلى صفر
                                        margin: EdgeInsets.only(left: 1),
                                        color
                                            : Color(0xffffffff),

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
                                                      location1lla[Index].name,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w900)),
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                      "Total Of guard ${location1lla[Index].tolal}",
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

    setState(() {
      location1lla.clear();
      location1lla.addAll(location1);
    });
  }
}
