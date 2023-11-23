import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart' hide Trans;

import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:webkit/controller/dashboard_controller.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import '../GuardDetails.dart';
import '../helpers/theme/theme_customizer.dart';
import '../printable_data.dart';
import 'User.dart';
import 'package:pdf/pdf.dart';
import '../helpers/extensions/string.dart';
import 'package:webkit/views/layouts/layout.dart';
import '../LocationData.dart';
import '../e_attendence.dart';
import 'package:excel/excel.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:image/image.dart' as img;

import 'dart:html' if (dart.library.html) 'dart:html';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  DashboardPageState createState() => DashboardPageState();
}

class DashboardPageState extends State<DashboardPage>
    with SingleTickerProviderStateMixin, UIMixin {
  late DashboardController controller;
  final Color? customColor = null;
  final textEditingController = TextEditingController();

  String t = "";
  int _currentPage = 1;
  int _itemsPerPage = 16;
  static List<dynamic> siteData = [];
  static List<dynamic> idess = [];
  static int days = DateTime.now().day;
  static int Years = DateTime.now().year;
  static bool isChecked = true;
  static bool isCheckedDubel = false;

// Get the month name
  List<int> Yearslist = [2023, 2024, 2025, 2026, 2027, 2028, 2029, 2030];
  List<String> months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];
  List<String> monthsar = [
    "يناير",
    "فبراير",
    "مارس",
    "أبريل",
    "مايو",
    "يونيو",
    "يوليو",
    "أغسطس",
    "سبتمبر",
    "أكتوبر",
    "نوفمبر",
    "ديسمبر"
  ];
  List<List<String>> data = [];

  static int selectedMonthIndex = (DateTime.now().month - 1).toInt();
  static List<LocationData> locationsall = [];
  static List<LocationData> all_locations = [];
  static List<GuardData> _Guard_Data = [];
  late final List<e_attendence> E_Atendance = [];
  static Map<String, dynamic> attendanceData = {};
  static List<Record> record = [];
  static List<Record> record3 = [];

  @override
  void initState() {
    dubuesury();
    a();
    super.initState();
    controller = Get.put(DashboardController());
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Year".tr(),
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      Center(
                        child: Card(
                          child: DropdownButton<int>(
                            dropdownColor: Colors.white,
                            value: Years,
                            onChanged: (int? newValue) {
                              if (newValue != null) {
                                setState(() {
                                  Years = newValue;
                                  _currentPage = 1;

                                  a();
                                });
                              }
                            },
                            items: Yearslist.map((int option) {
                              return DropdownMenuItem<int>(
                                value: option,
                                child: Text(option.toString(),
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700)),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      Text(
                        "Month".tr(),
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      Center(
                        child: Card(
                          child: DropdownButton<String>(
                            dropdownColor: Colors.white,
                            value: ThemeCustomizer.instance.currentLanguage
                                        .locale.languageCode ==
                                    "ar"
                                ? monthsar[selectedMonthIndex]
                                : months[selectedMonthIndex],
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                setState(() {
                                  _currentPage = 1;
                                  selectedMonthIndex = ThemeCustomizer
                                              .instance
                                              .currentLanguage
                                              .locale
                                              .languageCode ==
                                          "ar"
                                      ? monthsar.indexOf(newValue)
                                      : months.indexOf(newValue);
                                  if (selectedMonthIndex + 1 <
                                      DateTime.now().month) {
                                    int year = Years;
                                    int month = selectedMonthIndex +
                                        1; // على سبيل المثال، ديسمبر

                                    int numberOfDays =
                                        getNumberOfDaysInMonth(year, month);

                                    days = numberOfDays;
                                  } else {
                                    if (selectedMonthIndex + 1 ==
                                            DateTime.now().month &&
                                        Years == DateTime.now().year) {
                                      days = DateTime.now().day;
                                    } else {
                                      days = 0;
                                    }
                                  }
                                  a();
                                });
                              }
                            },
                            items: ThemeCustomizer.instance.currentLanguage
                                        .locale.languageCode ==
                                    "ar"
                                ? monthsar.map((String option) {
                                    return DropdownMenuItem<String>(
                                      value: option,
                                      child: Text(option,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700)),
                                    );
                                  }).toList()
                                : months.map((String option) {
                                    return DropdownMenuItem<String>(
                                      value: option,
                                      child: Text(option,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700)),
                                    );
                                  }).toList(),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Checkbox(
                              fillColor:
                                  MaterialStateProperty.all(Colors.orange),
                              value: isChecked,
                              onChanged: (bool? newValue) {
                                setState(() {
                                  isChecked = newValue!;
                                });
                              },
                            ),
                            MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: () {
                                  //    var element = document.querySelector('#Column');
                                  //    var rect = element?.getBoundingClientRect();
                                  //    var bottom = window.innerHeight! - rect!.bottom;

                                  // Scroll to the bottom of the screen

                                  if (isChecked) {
                                    setState(() {
                                      isChecked = false;
                                    });
                                  } else {
                                    setState(() {
                                      isChecked = true;
                                    });
                                  }
                                },
                                child: Text("Show".tr()),
                              ),
                            ),
                            /*
                                return Colors.black12;
} else if (guardCount < num)
  return Colors.amberAccent;
} else if (guardCount > num)
  return Colors.red;
                               */
                            SizedBox(
                              width: 10,
                              height: 10,
                            ),
                            Card(
                              margin: EdgeInsets.only(left: 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(6.0),
                                    topRight: Radius.circular(6.0)),
                              ),
                              child: Container(
                                width: 80,
                                height: 35,
                                child: Center(child: Text("Complete".tr())),
                              ),
                            ),
                            Card(
                              margin: EdgeInsets.only(left: 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(6.0),
                                    topRight: Radius.circular(6.0)),
                              ),
                              child: Container(
                                width: 80,
                                height: 35,
                                color: Colors.black12,
                                child: Center(child: Text("Zero".tr())), //Short
                              ),
                            ),
                            Card(
                              margin: EdgeInsets.only(left: 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(6.0),
                                    topRight: Radius.circular(6.0)),
                              ),
                              child: Container(
                                width: 80,
                                height: 35,
                                color: Colors.amberAccent,
                                child:
                                    Center(child: Text("Short".tr())), //Short
                              ),
                            ),
                            Card(
                              margin: EdgeInsets.only(left: 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(6.0),
                                    topRight: Radius.circular(6.0)),
                              ),
                              child: Container(
                                width: 80,
                                height: 35,
                                color: Colors.red,
                                child: Center(child: Text("Extra".tr())),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextButton(
                          onPressed: () {
                            a();
                          },
                          child: Text(
                            "Refresh".tr(),
                            style: TextStyle(color: Colors.black),
                          ),
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.orangeAccent),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextButton(
                          onPressed: () async {
                            var excel = Excel.createExcel();
                            data.clear();
                            List<String> a1 = [];

                            a1.add("Job_No".tr());
                            a1.add("Location_Name".tr());
                            for (int i = 1; i <= days; i++) {
                              a1.add(i.toString());
                            }

                            data.add(a1);

                            // إنشاء ورقة Excel جديدة
                            var sheet = excel['Sheet1'];

                            for (var loca in locationsall) {
                              List<String> a12 = [];
                              a12.add("J" + loca.id.toString().padLeft(4, '0'));
                              a12.add(loca.name.toString());

                              for (int i = 1; i <= days; i++) {
                                if (i.toString().length == 1) {
                                  a12.add(
                                      getGuardCount("0$i", loca.id).toString());
                                } else {
                                  a12.add(getGuardCount(i.toString(), loca.id)
                                      .toString());
                                }
                              }
                              data.add(a12);

                              // a12.clear();
                            }

                            // كتابة البيانات إلى ورقة Excel
                            for (var row in data) {
                              sheet.appendRow(row);
                            }
                            if (kIsWeb) {
                              try {
                                var excelBytes = await excel.encode();
                                final blob =
                                    Blob([Uint8List.fromList(excelBytes!)]);
                                final url = Url.createObjectUrlFromBlob(blob);

                                AnchorElement(
                                  href: url,
                                )
                                  ..setAttribute("download",
                                      "Summary  ${selectedMonthIndex + 1}-$Years.xlsx")
                                  ..click();
                              } catch (d) {}
                            }

                            // حفظ ملف Excel في مسار معين
                          },
                          child: Text(
                            "Extract_Summary".tr(),
                            style: TextStyle(color: Colors.black),
                          ),
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.orangeAccent),
                        ),
                      ),



                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextButton(
                          onPressed: () async {
                            var excel1 = Excel.createExcel();

                            data.clear();
                            List<String> a1 = [];

                            a1.add("Job_No".tr());
                            a1.add("Location_Name".tr());

                            data.add(a1);

                            // إنشاء ورقة Excel جديدة
                            var sheet = excel1['Sheet1'];

                            for (var loca in locationsall) {
                              List<String> a13 = [];
                              a13.add("J" + loca.id.toString().padLeft(4, '0'));
                              a13.add(loca.name.toString());
                              data.add(a13);
                              final idess = DashboardPageState.record
                                  .where((record) =>
                                      record.job_no ==
                                      int.parse(loca.id.toString()))
                                  .map((record) => record.id)
                                  .toList()
                                ..sort();
                              final ids = idess.toSet().toList();
                              List<String> a20 = [];
                              a20.add("ID");
                              a20.add("Name");
                              for (int i = 1; i <= days; i++) {
                                a20.add(i.toString());
                              }
                              data.add(a20);
                              for (var i in ids) {
                                List<String> a5 = [];
                                a5.add(i.toString().padLeft(5, '0'));

                                a5.add(_Guard_Data[i].NAME_EN);

                                for (int i2 = 1; i2 <= days; i2++) {
                                  int duty = 0;
                                  try {
                                    final record = DashboardPageState.record
                                        .firstWhere((record) {
                                      return record.job_no == loca.id &&
                                          int.parse(record.date.toString()) ==
                                              i2 &&
                                          i.toString() == record.id.toString();
                                    });

                                    duty = 12;
                                  } catch (e) {
                                    // إذا لم يتم العثور على تطابق، duty سيبقى 0
                                  }
                                  a5.add(duty.toString());
                                }

                                data.add(a5);
                              }
                              List<String> a12 = [];
                              a12.add("");
                              a12.add("Total");
                              for (int i = 1; i <= days; i++) {
                                if (i.toString().length == 1) {
                                  a12.add(
                                      getGuardCount("0$i", loca.id).toString());
                                } else {
                                  a12.add(getGuardCount(i.toString(), loca.id)
                                      .toString());
                                }
                              }

                              data.add(a12);

                              // a12.clear();
                            }

                            // كتابة البيانات إلى ورقة Excel
                            for (var row in data) {
                              sheet.appendRow(row);
                            }

                            if (kIsWeb) {
                              try {
                                var excelBytes = excel1.encode();
                                final blob =
                                    Blob([Uint8List.fromList(excelBytes!)]);
                                final url = Url.createObjectUrlFromBlob(blob);

                                AnchorElement(
                                  href: url,
                                )
                                  ..setAttribute("download",
                                      "Details ${selectedMonthIndex + 1}-$Years.xlsx")
                                  ..click();
                              } catch (d) {}
                            }
                            // حفظ ملف Excel في مسار معين
                          },
                          child: Text("Extract_Details".tr(),
                              style: TextStyle(color: Colors.black)),
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.orangeAccent),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextButton(
                          onPressed: () async {
                            var excel1 = Excel.createExcel();
                            List<String> toall = [];
                            data.clear();
                            List<String> a1 = [];
                            int Numer = 0;
                            a1.add("ID");
                            a1.add("Name");
                            a1.add("From");
                            a1.add("To");
                            a1.add("Job No");

                            data.add(a1);

                            // إنشاء ورقة Excel جديدة
                            var sheet = excel1['Sheet1'];

                            for (var loca in locationsall) {
                              final idess = DashboardPageState.record
                                  .where((record) =>
                                      record.job_no ==
                                      int.parse(loca.id.toString()))
                                  .map((record) => record.id)
                                  .toList()
                                ..sort();
                              final ids = idess.toSet().toList();

                              for (var ID in ids) {
                                //_Guard_Data[ID].NAME_EN

                                bool have1 = false;

                                for (int day = 1; day <= days + 1; day++) {
                                  int duty = 0;
                                  List<String> a21 = [];

                                  try {
                                    final record = DashboardPageState.record
                                        .firstWhere((record) {
                                      return record.job_no == loca.id &&
                                          int.parse(record.date.toString()) ==
                                              day &&
                                          ID.toString() == record.id.toString();
                                    });

                                    duty = 12;
                                  } catch (e) {
                                    duty = 0;
                                    // إذا لم يتم العثور على تطابق، duty سيبقى 0
                                  }

                                  if (duty == 12 && !have1) {
                                    have1 = true;
                                  } else if (duty == 0 && have1) {
                                    a21.add((day - 1).toString());

                                    toall.add((day - 1).toString());
                                    have1 = false;
                                  }
                                }

                                bool have = false;

                                for (int day = 1; day <= days; day++) {
                                  int duty = 0;
                                  List<String> a21 = [];

                                  try {
                                    final record = DashboardPageState.record
                                        .firstWhere((record) {
                                      return record.job_no == loca.id &&
                                          int.parse(record.date.toString()) ==
                                              day &&
                                          ID.toString() == record.id.toString();
                                    });

                                    duty = 12;
                                  } catch (e) {
                                    duty = 0;
                                    // إذا لم يتم العثور على تطابق، duty سيبقى 0
                                  }

                                  if (duty == 12 && !have) {
                                    a21.add(ID.toString());
                                    a21.add(_Guard_Data[ID].NAME_EN);
                                    a21.add(day.toString());

                                    a21.add(toall[Numer].toString());
                                    a21.add(loca.id.toString());

                                    data.add(a21);
                                    Numer++;
                                    have = true;
                                  } else if (duty == 0 && have) {
                                    have = false;
                                  }
                                }
                              }

                              // a12.clear();
                            }

                            // كتابة البيانات إلى ورقة Excel
                            for (var row in data) {
                              sheet.appendRow(row);
                            }

                            if (kIsWeb) {
                              try {
                                var excelBytes = excel1.encode();
                                final blob =
                                    Blob([Uint8List.fromList(excelBytes!)]);
                                final url = Url.createObjectUrlFromBlob(blob);

                                AnchorElement(
                                  href: url,
                                )
                                  ..setAttribute("download",
                                      "Data To HRMS  ${selectedMonthIndex + 1}-$Years.xlsx")
                                  ..click();
                              } catch (d) {}
                            }
                            // حفظ ملف Excel في مسار معين
                          },
                          child: Text("Extract_Data".tr(),
                              style: TextStyle(color: Colors.black)),
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.orangeAccent),
                        ),
                      ),
                      Checkbox(
                        fillColor:
                        MaterialStateProperty.all(Colors.orange),
                        value: isCheckedDubel,
                        onChanged: (bool? newValue) {
                          DatabaseReference databaseReference =
                        FirebaseDatabase.instance.reference().child('Focus');

                        databaseReference.update({
                          'Double_Duty': newValue,

                        });
                          setState(() {

                            isCheckedDubel = newValue!;

                          });
                        },
                      ),
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () {

                            if (isCheckedDubel) {
                              DatabaseReference databaseReference =
                              FirebaseDatabase.instance.reference().child('Focus');

                              databaseReference.update({
                                'Double_Duty': !isCheckedDubel,

                              });
                              setState(() {
                                isCheckedDubel = false;
                              });
                            } else {
                              DatabaseReference databaseReference =
                              FirebaseDatabase.instance.reference().child('Focus');

                              databaseReference.update({
                                'Double_Duty': !isCheckedDubel,

                              });
                              setState(() {
                                isCheckedDubel = true;
                              });
                            }
                          },
                          child: Text("Double_Duty".tr()),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 0,
                        child: Card(
                          margin: EdgeInsets.only(left: 1),
                          color: Color(0xfffcb75b),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(6.0),
                                topRight: Radius.circular(6.0)),
                          ),
                          child: SizedBox(
                              width: 70,
                              height: 40,
                              child: Center(child: Text("Job_No".tr()))),
                        ),
                      ),
                      Expanded(
                        flex: 0,
                        child: Card(
                          margin: EdgeInsets.only(left: 1),
                          color: Color(0xfffcb75b),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(6.0),
                                topRight: Radius.circular(6.0)),
                          ),
                          child: SizedBox(
                              width: 220,
                              height: 40,
                              child: Center(child: Text("Location_Name".tr()))),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          height: 40,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal, // التوجيه الأفقي
                            itemCount: days,

                            // عدد الأيام من 1 إلى 31
                            itemBuilder: (context, dayIndex) {
                              final day = (dayIndex + 1)
                                  .toString()
                                  .padLeft(2, '0'); // تنسيق اليوم

                              return Card(
                                // تعيين Padding إلى صفر
                                margin: EdgeInsets.only(left: 1),
                                color: Color(0xfffcb75b),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(6.0),
                                      topRight: Radius.circular(6.0)),
                                ),
                                child: SizedBox(
                                  width: 40,
                                  height: 40,
                                  // تحديد عرض العنصر حسب احتياجاتك
                                  child: Center(child: Text(day)),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 720,
                        child: ListView.builder(
                          scrollDirection: Axis.vertical, // التوجيه الأفقي
                          itemCount: locationsall.length,
                          itemBuilder: (context, locationIndex) {
                            //   final location =siteData[0].toString(); // تنسيق اليوم

                            final name =
                                locationsall[locationIndex].name.toString();
                            final numer =
                                locationsall[locationIndex].id.toString();
                            final numer1 = "J" + numer.padLeft(4, '0');
                            final total =
                                locationsall[locationIndex].tolal.toString();

                            // final id= record[0].id.toString();
                            // حساب عدد الحراس لهذا اليوم والموقع المعين

                            if (locationIndex >=
                                    (_currentPage - 1) * _itemsPerPage &&
                                locationIndex < _currentPage * _itemsPerPage) {
                              return Column(
                                children: [
                                  Row(
                                    children: [
                                      Card(
                                        margin: EdgeInsets.only(left: 1),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.zero,
                                        ),
                                        child: Container(
                                          alignment: ThemeCustomizer
                                                      .instance
                                                      .currentLanguage
                                                      .locale
                                                      .languageCode ==
                                                  "ar"
                                              ? Alignment.centerRight
                                              : Alignment.centerLeft,
                                          height: 40,
                                          width: 70,
                                          child: Center(child: Text("$numer1")),
                                        ),
                                      ),
                                      Card(
                                        margin: EdgeInsets.only(left: 1),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.zero,
                                        ),
                                        child: Container(
                                          alignment: ThemeCustomizer
                                                      .instance
                                                      .currentLanguage
                                                      .locale
                                                      .languageCode ==
                                                  "ar"
                                              ? Alignment.centerRight
                                              : Alignment.centerLeft,
                                          height: 40,
                                          width: 220,
                                          child: Row(
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      final idess = DashboardPageState.record.where((record) => record.job_no == int.parse(numer)).map((record) => record.id).toList()..sort();
                                                      final ids = idess
                                                          .toSet()
                                                          .toList();
                                                      return CustomListViewDialog(
                                                        idess: ids,
                                                        locations: numer,
                                                        indix1: locationIndex,
                                                      );
                                                    },
                                                  );
                                                },
                                                icon: Icon(
                                                  Icons.view_list_outlined,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              Text(name),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: getData(numer, total, true),
                                      ),
                                    ],
                                  ),
                                  Align(
                                    alignment: ThemeCustomizer
                                                .instance
                                                .currentLanguage
                                                .locale
                                                .languageCode ==
                                            "ar"
                                        ? Alignment.centerRight
                                        : Alignment.centerLeft,
                                    child: Container(
                                      width: days * 41 + 290,
                                      height: 2,
                                      color: Colors.black,
                                    ),
                                  )
                                ],
                              );
                            } else {
                              return Container(
                                width: 0,
                                height: 0,
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: ThemeCustomizer
                                .instance.currentLanguage.locale.languageCode ==
                            "ar"
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Card(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextButton(onPressed: () async {

                                  printDoc();


                                }, style: TextButton.styleFrom(
                                    backgroundColor: Colors.orangeAccent), child: Text(
                                  "Print_Summary".tr(), style: TextStyle(
                                    color: Colors.black
                                ),)
                                  ,),
                              ),

                          SizedBox(
                            height: 40,
                            width: 250.0 + (43.0 * days),
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                // التوجيه الأفقي
                                itemCount:
                                    (locationsall.length / 16).ceil() + 2,
                                // عدد الأيام من 1 إلى 31
                                itemBuilder: (context, dayIndex) {
                                  int last =
                                      (locationsall.length / 16).ceil() + 1;
                                  return Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: TextButton(
                                      onPressed: () {
                                        if (dayIndex == 0 && _currentPage > 1) {
                                          setState(() {
                                            _currentPage--;
                                          });
                                        } else if (dayIndex == last &&
                                            (_currentPage * _itemsPerPage) <
                                                locationsall.length) {
                                          setState(() {
                                            _currentPage++;
                                          });
                                        } else if (dayIndex != 0 &&
                                            dayIndex != last) {
                                          setState(() {
                                            _currentPage = dayIndex;
                                          });
                                        }
                                      }, // عرض رقم الصفحة

                                      style: TextButton.styleFrom(
                                          // تخصيص النص
                                          // حجم النص
                                          backgroundColor:
                                              dayIndex == _currentPage
                                                  ? Colors.orangeAccent
                                                  : Colors.transparent),
                                      child: Text(
                                        dayIndex == 0
                                            ? "Previous_page".tr()
                                            : dayIndex == last
                                                ? "Next_page".tr()
                                                : (dayIndex).toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: dayIndex == _currentPage
                                                ? Colors.white
                                                : Colors.orangeAccent),
                                      ),
                                    ),
                                  );
                                }),
                          ),

                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  dubuesury(){

    final guardDitales = FirebaseDatabase.instance.ref("Focus/Double_Duty");

    guardDitales.get().then((guarddata1) {
setState(() {
  isCheckedDubel= bool.parse(guarddata1.value.toString());
});


    });


  }
  int getNumberOfDaysInMonth(int year, int month) {
    // Create a DateTime object for the first day of the next month
    DateTime firstDayOfNextMonth = DateTime(year, month + 1, 1);

    // Subtract one day to get the last day of the current month
    DateTime lastDayOfCurrentMonth =
        firstDayOfNextMonth.subtract(Duration(days: 1));

    // Return the day of the last day of the current month
    return lastDayOfCurrentMonth.day;
  }

  Future<void> printDoc() async {


    final fontData = await rootBundle.load("assets/font/font.ttf");
    final ttf = pw.Font.ttf(fontData.buffer.asByteData());
    final doc = pw.Document();
    doc.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4.copyWith(
          width: PdfPageFormat.a4.height,
          height: PdfPageFormat.a4.width,
          marginLeft: 0,
          marginRight: 0,
          marginTop: 0,
          marginBottom: 0,
        ),
        build: (pw.Context context) {
          return buildPrintableData(ttf);
        }));
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => doc.save());
  }

  Widget getData(String name, String total, bool v) {
    return Visibility(
      visible: v,
      child: SizedBox(
        height: 42,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: days,
          itemBuilder: (context, dayIndex) {
            final day = (dayIndex + 1).toString().padLeft(2, '0');
            final targetSiteNumber = int.parse(name);
            final num = int.parse(total);
            final guardCount = getGuardCount(day, targetSiteNumber);

            return Container(
              decoration: BoxDecoration(
                  /*
                border: Border(
                  bottom: BorderSide(
                    color: Colors.black,
                    width: 2.0,
                  ),
                ),
                */
                  ),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                margin: EdgeInsets.only(left: 1),
                child: SizedBox(
                  width: 40,
                  height: 42,
                  child: Container(
                    color: getGuardCountColor(guardCount, num),
                    child: Center(child: Text('$guardCount')),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  int getGuardCount(String day, int targetSiteNumber) {
    return attendanceData.values.where((attendance) {

        return  attendance.length > 1 ?attendance[1]['date'] == day &&
            attendance[1]['job_no'] == targetSiteNumber:false;



    }).length+ attendanceData.values.where((attendance) {

      return  attendance[0]['date'] == day &&
          attendance[0]['job_no'] == targetSiteNumber;



    }).length ;

  }

  Color getGuardCountColor(int guardCount, int num) {
    if (isChecked) {
      if (guardCount == 0) {
        return Colors.black12;
      } else if (guardCount < num) {
        return Colors.amberAccent;
      } else if (guardCount > num) {
        return Colors.red;
      } else {
        return Colors.transparent;
      }
    } else {
      return Colors.transparent;
    }
  }

  Widget getDataGuard(String name, String total, bool v) {
    return Visibility(
      visible: v,
      child: Container(
        height: 43,
        child: ListView.builder(
          scrollDirection: Axis.horizontal, // التوجيه الأفقي
          itemCount: days, // عدد الأيام من 1 إلى 31
          itemBuilder: (context, dayIndex) {
            return Container(
              decoration: BoxDecoration(
                  /*
                border: Border(
                  bottom: BorderSide(
                    color: Colors.black, // لون الحدود
                    width: 2.0, // عرض الحدود
                  ),


                ),
                 */
                  ),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius
                      .zero, // تعيين الزوايا إلى صفر للشكل المستطيلي
                ),
                margin: EdgeInsets.only(left: 1),
                child: Container(
                  width: 40,
                  height: 43, // تحديد عرض العنصر حسب احتياجاتك
                  child: Container(
                    child: Container(child: Center(child: Text('$total'))),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  a() async {
//   .collection('Focus/Attendenc/2023/08/record')
    // الحصول على البيانات من قاعدة البيانات

    final reference1 = FirebaseDatabase.instance
        .ref('Focus/Attendenc/${Years}/${selectedMonthIndex + 1}/record');

    // Fetch data from the database
    DatabaseEvent event = await reference1.once();

    if (event.snapshot.value != null) {
      final database = FirebaseDatabase.instance;

      // الحصول على البيانات من قاعدة البيانات
      final reference = database.ref(
        'Focus/Attendenc/${Years}/${selectedMonthIndex + 1}/record',
      );

      reference.onValue.listen((event) {
        final data = event.snapshot.value as Map<String, dynamic>;
        final Map<String, int> firstAttendanceJobNoMap = {};
        final items11 = <int>[];
        final items22 = <String>[];

        data.forEach((key, value) {


        items11.add(value[0]['job_no']);
        items22.add(value[0]['id'].toString());
        if (value.length > 1) {
          items11.add(value[1]['job_no']);
          items22.add(value[1]['id'].toString());
        }
        });

        items11.sort();
        items22.sort();

        final uniqueItems = items11.toSet().toList();
        items22.sort();
        final ids = items22.toSet().toList();

        setState(() {
          attendanceData.clear();
          attendanceData = data;

          siteData.clear();
          idess.clear();
          siteData.addAll(uniqueItems);
          idess.addAll(ids);
        });
      });

      final locationRef = FirebaseDatabase.instance.ref("Focus/Locatins");

      locationRef.get().then((locationData) {
        final locations2 = <LocationData>[];



        for (var number in siteData) {


          final location = locationData.child("$number");

          final locationData1 = LocationData(
            int.parse(location.child("id").value.toString()),
            int.parse(location.child("tolal").value.toString()),
            location.child("day_time").value.toString(),
            location.child("night_time").value.toString(),
            int.parse(location.child("hors").value.toString()),
            location.child("name").value.toString(),
            location.child("latitude").value.toString(),
            location.child("longitude").value.toString(),
          );

          locations2.add(locationData1);
        }

        setState(() {
          locationsall.clear();
          locationsall.addAll(locations2);
        });
      });
      final guardDitales = FirebaseDatabase.instance.ref("Focus/Data");

      guardDitales.get().then((guarddata1) {
        final guarddata = <GuardData>[];

        for (var number = 0; number <= 1476; number++) {
          final guard = guarddata1.child("$number");

          final guardata1 = GuardData(
              guard.child("BIRTHDAY").value.toString(),
              guard.child("Contact").value.toString(),
              guard.child("DATE_OF_JOINING").value.toString(),
              guard.child("EMIRATES_ID").value.toString(),
              guard.child("EMPLOYMENT_STATUS").value.toString(),
              int.parse(guard.child("ID_NO").value.toString()),
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
              guard.child("password").value.toString());

          guarddata.add(guardata1);
        }

        setState(() {
          _Guard_Data.clear();
          _Guard_Data.addAll(guarddata);
        });
      });

      final List<Record> record2 = [];
      final List<Record> record4 = [];
      record2.clear();
      final reference1 = FirebaseDatabase.instance.ref(
          'Focus/Attendenc/${DateTime.now().year}/${selectedMonthIndex + 1}/record');
      reference1.onValue.listen((event) {
        int day = days;

        for (var i in idess) {
          for (var d = 1; d <= day; d++) {
            final jobNo = event.snapshot.child('${i}|$d').child("0").child("job_no").value.toString();
            final jobNo2 = event.snapshot.child('${i}|$d').child("1").child("job_no").value.toString();
            if (jobNo != "null") {
              final recordd = Record(
                id: int.parse(i.toString()),
                job_no: int.parse(jobNo),
                date: event.snapshot
                    .child('${i}|$d').child("0")
                    .child("date")
                    .value
                    .toString(),
                datetime: event.snapshot
                    .child('${i}|$d').child("0")
                    .child("datetime")
                    .value
                    .toString(),
                shift: event.snapshot
                    .child('${i}|$d').child("0")
                    .child("shift")
                    .value
                    .toString(),
              );

              record2.add(recordd);
            }
            if (jobNo2 != "null") {
              final recordd = Record(
                id: int.parse(i.toString()),
                job_no: int.parse(event.snapshot
                    .child('${i}|$d').child("1")
                    .child("job_no")
                    .value
                    .toString()),
                date: event.snapshot
                    .child('${i}|$d').child("1")
                    .child("date")
                    .value
                    .toString(),
                datetime: event.snapshot
                    .child('${i}|$d').child("1")
                    .child("datetime")
                    .value
                    .toString(),
                shift: event.snapshot
                    .child('${i}|$d').child("1")
                    .child("shift")
                    .value
                    .toString(),
              );

              record4.add(recordd);
            }
          }
        }

        setState(() {
          record.clear();
          record3.clear();
          record.addAll(record2);
          record3.addAll(record4);
        });
      });
      // You can access the data using event.snapshot.value
    } else {
      setState(() {
        attendanceData.clear();

        locationsall.clear();

        _Guard_Data.clear();

        record.clear();
        record3.clear();

        siteData.clear();
        idess.clear();
      });
    }
  }

  String getMonthName() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('MMMM');
    return formatter.format(now);
  }
}

class CustomListViewDialog extends StatefulWidget {
  List<dynamic> idess = [];

  String locations = "";
  int indix1 = 0;
  int _currentPage1 = 1;
  int _itemsPerPage1 = 15;

  CustomListViewDialog(
      {required this.idess, required this.locations, required this.indix1});

  @override
  State<CustomListViewDialog> createState() => _CustomListViewDialogState();
}

class _CustomListViewDialogState extends State<CustomListViewDialog> {
  // إضافة constructor للتلقي القيمة
  @override
  Widget build(BuildContext context) {
// التفاصيل

    return AlertDialog(
      content: Container(
        width: 250 + (DashboardPageState.days * 44),
        child: Column(
          // تعيين MainAxisSize إلى MainAxisSize.max
          crossAxisAlignment: CrossAxisAlignment.start,
          // تعيين التوجيه إلى اليسار
          children: [
            Expanded(
                flex: 0,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${"Location".tr()}${DashboardPageState.locationsall[widget.indix1].name.toString()}',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 22),
                      ),
                    ),
                    Align(
                      alignment: ThemeCustomizer.instance.currentLanguage.locale
                                  .languageCode ==
                              "ar"
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '                    ${"Month_Year".tr()}  ${DashboardPageState.selectedMonthIndex + 1}/${DashboardPageState.Years}',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 22),
                        ),
                      ),
                    ),
                  ],
                )),
            SizedBox(
              width: 20,
              height: 20,
            ),
            Expanded(
              flex: 0,
              child: Row(
                children: [
                  Expanded(
                    flex: 0,
                    child: Card(
                      margin: EdgeInsets.only(left: 1),
                      color: Color(0xfffcb75b),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(6.0),
                            topRight: Radius.circular(6.0)),
                      ),
                      child: SizedBox(
                          width: 249,
                          height: 40,
                          child: Center(child: Text("ID_Name".tr()))),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal, // التوجيه الأفقي
                        itemCount: DashboardPageState.days,

                        // عدد الأيام من 1 إلى 31
                        itemBuilder: (context, dayIndex) {
                          final day = (dayIndex + 1)
                              .toString()
                              .padLeft(2, '0'); // تنسيق اليوم

                          return Card(
                            // تعيين Padding إلى صفر
                            margin: EdgeInsets.only(left: 1),
                            color: Color(0xfffcb75b),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(6.0),
                                  topRight: Radius.circular(6.0)),
                            ),
                            child: SizedBox(
                              width: 40,
                              height: 40,
                              // تحديد عرض العنصر حسب احتياجاتك
                              child: Center(child: Text(day)),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 0,
              child: SizedBox(
                height: 15 * 44,
                width: double.maxFinite,
                // Set a desired height التفاصيل
                child: ListView.builder(
                  itemCount: widget.idess.length, // Number of items in the list
                  itemBuilder: (context, index) {
                    if (index >=
                            (widget._currentPage1 - 1) *
                                widget._itemsPerPage1 &&
                        index < widget._currentPage1 * widget._itemsPerPage1) {
                      return Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 0,
                                child: Container(
                                  height: 42,
                                  width: 250,
                                  decoration: BoxDecoration(
                                      /*
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Colors.black,
                                              // لون الحدود
                                              width: 2.0, // عرض الحدود
                                            ),
                                          ),
                                          */
                                      ),
                                  child: Card(
                                      margin: EdgeInsets.only(left: 1),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius
                                            .zero, // تعيين الزوايا إلى صفر للشكل المستطيلي
                                      ),
                                      child: Container(
                                          alignment: ThemeCustomizer
                                                      .instance
                                                      .currentLanguage
                                                      .locale
                                                      .languageCode ==
                                                  "ar"
                                              ? Alignment.centerRight
                                              : Alignment.centerLeft,
                                          height: 40,
                                          width: 250,
                                          child: Text(ThemeCustomizer
                                                      .instance
                                                      .currentLanguage
                                                      .locale
                                                      .languageCode ==
                                                  "ar"
                                              ? "  ${widget.idess[index]} -  ${DashboardPageState._Guard_Data[widget.idess[index]].NAME_AR}"
                                              : "  ${widget.idess[index]} -  ${DashboardPageState._Guard_Data[widget.idess[index]].NAME_EN}"))),
                                ),
                              ),
                              Expanded(
                                child: getDataGuard(
                                    widget.idess[index].toString(),
                                    widget.locations,
                                    true,
                                    ThemeCustomizer.instance.currentLanguage
                                                .locale.languageCode ==
                                            "ar"
                                        ? "  ${widget.idess[index]} -  ${DashboardPageState._Guard_Data[widget.idess[index]].NAME_AR}"
                                        : "  ${widget.idess[index]} -  ${DashboardPageState._Guard_Data[widget.idess[index]].NAME_EN}",DashboardPageState.locationsall[widget.indix1].name.toString()),
                              ),
                            ],
                          ),
                          Align(
                            alignment: ThemeCustomizer.instance.currentLanguage
                                        .locale.languageCode ==
                                    "ar"
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Container(
                              width: DashboardPageState.days * 41 + 250,
                              height: 2,
                              color: Colors.black,
                            ),
                          )
                        ],
                      );
                    } else {
                      return Container(
                        width: 0,
                        height: 0,
                      );
                    }
                  },
                ),
              ),
            ),
            Expanded(
                flex: 0,
                child: Row(
                  children: [
                    Expanded(
                      flex: 0,
                      child: Container(
                        height: 40,
                        width: 250,
                        decoration: BoxDecoration(
                            /*
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.black,
                              // لون الحدود
                              width: 2.0, // عرض الحدود
                            ),
                          ),
                          */
                            ),
                        child: Card(
                            margin: EdgeInsets.only(left: 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius
                                  .zero, // تعيين الزوايا إلى صفر للشكل المستطيلي
                            ),
                            child: Container(
                                alignment: ThemeCustomizer
                                            .instance
                                            .currentLanguage
                                            .locale
                                            .languageCode ==
                                        "ar"
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                height: 40,
                                width: 250,
                                child: Text("Total".tr()))),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                          width: double.maxFinite,
                          height: 40,
                          child: getData(
                              widget.locations,
                              DashboardPageState
                                  .locationsall[widget.indix1].tolal
                                  .toString(),
                              true)),
                    ),
                  ],
                )),
            Expanded(
              flex: 0,
              child: Align(
                alignment: ThemeCustomizer
                            .instance.currentLanguage.locale.languageCode ==
                        "ar"
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: Card(
                  child: Column(
                    children: [
                      Row(
                        children: [

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextButton(onPressed: () async {

                              printDoc();


                            }, style: TextButton.styleFrom(
                                backgroundColor: Colors.orangeAccent), child: Text(
                              "Print_Location".tr(), style: TextStyle(
                                color: Colors.black
                            ),)
                              ,),
                          ),
                      SizedBox(
                        height: 40,
                        width: 250.0 + (43.0 * DashboardPageState.days),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: (widget.idess.length / 15).ceil() + 2,
                          // عدد الصفحات الكلي
                          itemBuilder: (context, page) {
                            int last = (widget.idess.length / 15).ceil() + 1;
                            // إعادة بناء كل عنصر في الـ ListView
                            return Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: TextButton(
                                onPressed: () {
                                  if (page == 0 && widget._currentPage1 > 1) {
                                    setState(() {
                                      widget._currentPage1--;
                                    });
                                  } else if (page == last &&
                                      (widget._currentPage1 *
                                              widget._itemsPerPage1) <
                                          widget.idess.length) {
                                    setState(() {
                                      widget._currentPage1++;
                                    });
                                  } else if (page != 0 && page != last) {
                                    setState(() {
                                      widget._currentPage1 = page;
                                    });
                                  }
                                }, // عرض رقم الصفحة

                                style: TextButton.styleFrom(
                                    // تخصيص النص
                                    // حجم النص
                                    backgroundColor:
                                        page == widget._currentPage1
                                            ? Colors.orangeAccent
                                            : Colors.transparent),
                                child: Text(
                                  page == 0
                                      ? "Previous_page".tr()
                                      : page == last
                                          ? "Next_page".tr()
                                          : (page).toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: page == widget._currentPage1
                                          ? Colors.white
                                          : Colors.orangeAccent),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                        ],
                  )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      /*
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text('Close'),
        ),
      ],
      */
    );
  }

  Future<void> printDoc() async {


    final fontData = await rootBundle.load("assets/font/font.ttf");
    final ttf = pw.Font.ttf(fontData.buffer.asByteData());
    final doc = pw.Document();
    doc.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4.copyWith(
          width: PdfPageFormat.a4.height,
          height: PdfPageFormat.a4.width,
          marginLeft: 0,
          marginRight: 0,
          marginTop: 0,
          marginBottom: 0,
        ),
        build: (pw.Context context) {
          return buildPrintableDataDetales(ttf);
        }));
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => doc.save());
  }
  Widget getData(String name, String total, bool v) {
    return Visibility(
      visible: v,
      child: SizedBox(
        height: 41,
        child: ListView.builder(
          scrollDirection: Axis.horizontal, // التوجيه الأفقي
          itemCount: DashboardPageState.days, // عدد الأيام من 1 إلى 31
          itemBuilder: (context, dayIndex) {
            final day =
                (dayIndex + 1).toString().padLeft(2, '0'); // تنسيق اليوم
            final int targetSiteNumber = int.parse(name);
            int num = int.parse(total);
            // حساب عدد الحراس لهذا اليوم والموقع المعين
            final guardCount =
             DashboardPageState.attendanceData.values.where((attendance) {

              return  attendance.length > 1 ?attendance[1]['date'] == day &&
                  attendance[1]['job_no'] == targetSiteNumber:false;



            }).length+   DashboardPageState.attendanceData.values.where((attendance) {
              return attendance[0]['date'] == day &&
                  attendance[0]['job_no'] == targetSiteNumber;
            }).length;

            return Container(
              height: 41,
              width: 41,
              decoration: BoxDecoration(
                  /*
                border: Border(
                  bottom: BorderSide(
                    color: Colors.black, // لون الحدود
                    width: 2.0, // عرض الحدود
                  ),
                ),

                 */
                  ),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius
                      .zero, // تعيين الزوايا إلى صفر للشكل المستطيلي
                ),
                margin: EdgeInsets.only(left: 1),
                child: Container(
                  width: 41,
                  height: 41, // تحديد عرض العنصر حسب احتياجاتك
                  child: Container(
                    child: Container(
                        color: DashboardPageState.isChecked
                            ? guardCount == 0
                                ? Colors.black12
                                : guardCount < num
                                    ? Colors.amberAccent
                                    : guardCount > num
                                        ? Colors.red
                                        : Colors.transparent
                            : Colors.transparent,
                        child: Center(child: Text('$guardCount'))),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  a() async {
//   .collection('Focus/Attendenc/2023/08/record')
    // الحصول على البيانات من قاعدة البيانات

    final reference1 = FirebaseDatabase.instance.ref(
        'Focus/Attendenc/${DashboardPageState.Years}/${DashboardPageState.selectedMonthIndex + 1}/record');

    // Fetch data from the database
    DatabaseEvent event = await reference1.once();

    if (event.snapshot.value != null) {
      final database = FirebaseDatabase.instance;

      // الحصول على البيانات من قاعدة البيانات
      final reference = database.ref(
        'Focus/Attendenc/${DashboardPageState.Years}/${DashboardPageState.selectedMonthIndex + 1}/record',
      );

      reference.onValue.listen((event) {
        final data = event.snapshot.value as Map<String, dynamic>;

        final items11 = <int>[];
        final items22 = <String>[];

        data.forEach((key, value) {

          items11.add(value[0]['job_no']);
          items22.add('${value[0]['id']}');
          if (value.length > 1) {
            items11.add(value[1]['job_no']);
            items22.add('${value[1]['id']}');
          }
        });

        items11.sort();
        items22.sort();

        final uniqueItems = items11.toSet().toList();
        items22.sort();
        final ids = items22.toSet().toList();

        setState(() {
          DashboardPageState.attendanceData.clear();
          DashboardPageState.attendanceData = data;

          DashboardPageState.siteData.clear();
          DashboardPageState.idess.clear();
          DashboardPageState.siteData.addAll(uniqueItems);
          DashboardPageState.idess.addAll(ids);
        });
      });

      final locationRef = FirebaseDatabase.instance.ref("Focus/Locatins");

      locationRef.get().then((locationData) {
        final locations2 = <LocationData>[];

        for (var number in DashboardPageState.siteData) {
          //    DatabaseEvent event = await _database.child('Focus/Locatins').once();

          final location = locationData.child("$number");

          final locationData1 = LocationData(
            int.parse(location.child("id").value.toString()),
            int.parse(location.child("tolal").value.toString()),
            location.child("day_time").value.toString(),
            location.child("night_time").value.toString(),
            int.parse(location.child("hors").value.toString()),
            location.child("name").value.toString(),
            location.child("latitude").value.toString(),
            location.child("longitude").value.toString(),
          );

          locations2.add(locationData1);
        }

        setState(() {
          DashboardPageState.locationsall.clear();
          DashboardPageState.locationsall.addAll(locations2);
        });
      });
      final guardDitales = FirebaseDatabase.instance.ref("Focus/Data");

      guardDitales.get().then((guarddata1) {
        final guarddata = <GuardData>[];

        for (var number = 0; number <= 1476; number++) {
          final guard = guarddata1.child("$number");

          final guardata1 = GuardData(
              guard.child("BIRTHDAY").value.toString(),
              guard.child("Contact").value.toString(),
              guard.child("DATE_OF_JOINING").value.toString(),
              guard.child("EMIRATES_ID").value.toString(),
              guard.child("EMPLOYMENT_STATUS").value.toString(),
              int.parse(guard.child("ID_NO").value.toString()),
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
              guard.child("password").value.toString());

          guarddata.add(guardata1);
        }

        setState(() {
          DashboardPageState._Guard_Data.clear();
          DashboardPageState._Guard_Data.addAll(guarddata);
        });
      });

      final List<Record> record2 = [];
      final List<Record> record4 = [];
      record2.clear();
      final reference1 = FirebaseDatabase.instance.ref(
          'Focus/Attendenc/${DashboardPageState.Years}/${DashboardPageState.selectedMonthIndex + 1}/record');
      reference1.onValue.listen((event) {
        int day = DashboardPageState.days;

        for (var i in DashboardPageState.idess) {
          for (var d = 1; d <= day; d++) {
            final jobNo = event.snapshot
                .child('${i}|$d').child("0")
                .child("job_no")
                .value
                .toString();
            final jobNo2 = event.snapshot
                .child('${i}|$d').child("1")
                .child("job_no")
                .value
                .toString();
            if (jobNo != "null") {
              final recordd = Record(
                id: int.parse(i.toString()),
                job_no: int.parse(jobNo),
                date: event.snapshot
                    .child('${i}|$d').child("0")
                    .child("date")
                    .value
                    .toString(),
                datetime: event.snapshot
                    .child('${i}|$d').child("0")
                    .child("datetime")
                    .value
                    .toString(),
                shift: event.snapshot
                    .child('${i}|$d').child("0")
                    .child("shift")
                    .value
                    .toString(),
              );

              record2.add(recordd);
            }
            if (jobNo2 != "null") {
              final recordd = Record(
                id: int.parse(i.toString()),
                job_no: int.parse( event.snapshot
                    .child('${i}|$d').child("1")
                    .child("job_no")
                    .value
                    .toString()),
                date: event.snapshot
                    .child('${i}|$d').child("1")
                    .child("date")
                    .value
                    .toString(),
                datetime: event.snapshot
                    .child('${i}|$d').child("1")
                    .child("datetime")
                    .value
                    .toString(),
                shift: event.snapshot
                    .child('${i}|$d').child("1")
                    .child("shift")
                    .value
                    .toString(),
              );

              record4.add(recordd);
            }
          }
        }

        setState(() {
          DashboardPageState.record.clear();
          DashboardPageState.record3.clear();
          DashboardPageState.record.addAll(record2);
          DashboardPageState.record3.addAll(record4);
        });
      });
      // You can access the data using event.snapshot.value
    } else {
      setState(() {
        DashboardPageState.attendanceData.clear();

        DashboardPageState.locationsall.clear();

        DashboardPageState._Guard_Data.clear();

        DashboardPageState.record.clear();
        DashboardPageState.record3.clear();

        DashboardPageState.siteData.clear();
        DashboardPageState.idess.clear();
      });
    }
  }

  Widget getDataGuard(String id, String locaton, bool v, String ID_Name,String name) {
    return Visibility(
      visible: v,
      child: SizedBox(
        height: 42,
        child: ListView.builder(
          scrollDirection: Axis.horizontal, // التوجيه الأفقي
          itemCount: DashboardPageState.days, // عدد الأيام من 1 إلى 31
          itemBuilder: (context, dayIndex) {
            var duty = 0;

            try {
              final record = DashboardPageState.record.firstWhere((record) {
                return record.job_no == int.parse(locaton) &&
                    int.parse(record.date.toString()) == (dayIndex + 1) &&
                    id == record.id.toString();
              });

              duty = 12;
            } catch (e) {
              // إذا لم يتم العثور على تطابق، duty سيبقى 0
            }

            try {
              final record3 = DashboardPageState.record3.firstWhere((record3) {
                return record3.job_no == int.parse(locaton) &&
                    int.parse(record3.date.toString()) == (dayIndex + 1) &&
                    id == record3.id.toString();
              });

              duty = duty+12;
            } catch (e) {
              // إذا لم يتم العثور على تطابق، duty سيبقى 0
            }

            return Container(
              decoration: BoxDecoration(
                  /*
                border: Border(
                  bottom: BorderSide(
                    color: Colors.black, // لون الحدود
                    width: 2.0, // عرض الحدود
                  ),
                ),

                 */
                  ),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius
                      .zero, // تعيين الزوايا إلى صفر للشكل المستطيلي
                ),
                margin: EdgeInsets.only(left: 1),
                       child: GestureDetector(
                  onTap: () async {


            showDialog(
            context: context,
            builder: (context) {
            return AlertDialog(
            title: Text(duty == 12
            ? 'Confirm delete duty'
                : 'Confirm adding duty'),
            content: Text("are you sure you want to" +
            "${duty == 12 ? " delete  " : " add "} duty for $ID_Name  In day ${dayIndex + 1}/${DashboardPageState.selectedMonthIndex + 1}/${DashboardPageState.Years}"),
            actions: [
            TextButton(
            onPressed: () {
            Navigator.of(context)
                .pop(); // This is correct because we are not trying to use the result of the pop method.
            },
            child: Text('No'),
            ),
            TextButton(
            onPressed: () async {
            try {
            if (duty == 12) {
            DatabaseReference databaseReference =
            FirebaseDatabase.instance
                .reference();

            // تحديد المسار وحذف العنصر
            databaseReference
                .child(
            "Focus/Attendenc/${DashboardPageState.Years}/${DashboardPageState.selectedMonthIndex + 1}/record/$id|${dayIndex + 1}")
                .remove()
                .then((_) {
            a();
            }).catchError((onError) {
            a();
            });
            } else {
            try {
            final dateFormat =
            DateFormat('HH:mm');
            final formattedDateTime = dateFormat
                .format(DateTime.now());
            final database = FirebaseDatabase
                .instance
                .ref()
                .child(
            "Focus/Attendenc/${DashboardPageState.Years}/${DashboardPageState.selectedMonthIndex + 1}");
            final record = Record(
            id: int.parse(id),
            job_no: int.parse(locaton),
            date: (dayIndex + 1)
                .toString()
                .length ==
            1
            ? "0${(dayIndex + 1).toString()}"
                : (dayIndex + 1).toString(),
            datetime: formattedDateTime,
            shift: "Day");

            await database
                .child('record')
                .child(id +
            "|" +
            (dayIndex + 1).toString())
                .set(record.toJson());
            a();
            } catch (e) {}
            }

/*


*/
            } catch (e) {}
            Navigator.of(context)
                .pop(); // This is correct because we are not trying to use the result of the pop method.
            },
            child: Text('Yes'),
            ),
            /*
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pop();
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text('Confirm Change Location of duty'),
                                            content:Container(
                                              height:200 ,
                                              width: 100,
                                              child: Column(
                                                children: [

                                                  Text("are you sure you want to Change Location of duty for $ID_Name  In day ${dayIndex + 1}/${DashboardPageState.selectedMonthIndex + 1}/${DashboardPageState.Years}"),
                                            SizedBox(
                                              width: 10,
                                              height: 10,
                                            ),
                                              Card(

                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text("From Location : $name",
                                                  style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700),),
                                                ),
                                              ),

                                                  Card(

                                                    child: Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Column(
                                                        children: [
                                                          Text("To Location : $name",
                                                            style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700),),

                                                        ],
                                                      ),
                                                    ),
                                                  ),

                                                ],
                                              ),
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pop(); // This is correct because we are not trying to use the result of the pop method.
                                                },
                                                child: Text('No'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pop(); // This is correct because we are not trying to use the result of the pop method.
                                                },
                                                child: Text('No'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                      // This is correct because we are not trying to use the result of the pop method.
                                    },
                                    child: Text('Change Location'),
                                  ),
                                  */
            ],
            );
            },
            );
            },child:SizedBox(
                  width: 40,
                  height: 42, // تحديد عرض العنصر حسب احتياجاتك
                  child: Container(
                      color: DashboardPageState.isChecked
                          ? duty == 12
                              ? Colors.green
                              : duty==24?Colors.deepOrange:Colors.transparent
                          : Colors.transparent,

                        child: Center(child: Text('$duty')),
                      )),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
