import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:focusweb/helpers/theme/theme_customizer.dart';
import 'package:focusweb/views/User.dart';
import 'package:focusweb/views/dashboard.dart';

import 'package:get/get.dart';

import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:focusweb/controller/my_controller.dart';

import '../GuardDetails.dart';
import '../LocationData.dart';
import '../e_attendence.dart';
import '../models/dashboard.dart';

class ChartSampleData {
  ChartSampleData(
      {this.x,
      this.y,
      this.xValue,
      this.yValue,
      this.secondSeriesYValue,
      this.thirdSeriesYValue,
      this.pointColor,
      this.size,
      this.text,
      this.open,
      this.close,
      this.low,
      this.high,
      this.volume});

  final dynamic x;
  final num? y;
  final dynamic xValue;
  final num? yValue;
  final num? secondSeriesYValue;
  final num? thirdSeriesYValue;
  final Color? pointColor;
  final num? size;
  final String? text;
  final num? open;
  final num? close;
  final num? low;
  final num? high;
  final num? volume;
}

class DashboardController extends MyController {
  List<DashBoard> dashboard = [];
  String selectedTimeOnPage = "Year";
  String selectedTimeByLocation = "Year";
  String selectedTimeDesign = "Year";
  String selectedTimeLatency = "Year";

  static List<int> Yearslist = [2023, 2024, 2025, 2026, 2027, 2028, 2029, 2030];
  static  List<String> months = [
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
  static List<String> monthsar = [
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
  static List<List<String>> data = [];

  static int selectedMonthIndex = (DateTime.now().month - 1).toInt();
  static List<LocationData> locationsall = [];

  static List<GuardData> Guard_Data = [];
  late final List<e_attendence> E_Atendance = [];
  static Map<String, dynamic> attendanceData = {};
  static List<Recorda> record = [];
  static List<Recorda> record3 = [];



  String t = "";

  static List<dynamic> siteData = [];
  static List<dynamic> idess = [];
  static int days = 31;
  static int Years = DateTime.now().year;
  static bool isChecked = true;
  static bool isCheckedDubel = false;

  final List<ChartSampleData> revenueChart1 = <ChartSampleData>[
    ChartSampleData(x: 'Mon', y: 0),
    ChartSampleData(x: 'Tue', y: 30),
    ChartSampleData(x: 'Wed', y: 35),
    ChartSampleData(x: 'The', y: 30),
    ChartSampleData(x: 'Fri', y: 45),
    ChartSampleData(x: 'Sat', y: 40),
    ChartSampleData(x: 'Sun', y: 55)
  ];
  final List<ChartSampleData> revenueChart2 = <ChartSampleData>[
    ChartSampleData(x: 'Mon', y: 10),
    ChartSampleData(x: 'Tue', y: 50),
    ChartSampleData(x: 'Wed', y: 30),
    ChartSampleData(x: 'The', y: 20),
    ChartSampleData(x: 'Fri', y: 35),
    ChartSampleData(x: 'Sat', y: 30),
    ChartSampleData(x: 'Sun', y: 45)
  ];

  final TooltipBehavior revenue = TooltipBehavior(
    enable: true,
    tooltipPosition: TooltipPosition.pointer,
    format: 'point.x : point.y',
  );

  final List<ChartSampleData> chartData = [
    ChartSampleData(x: 'Jan', y: 10, yValue: 1000),
    ChartSampleData(x: 'Fab', y: 20, yValue: 2000),
    ChartSampleData(x: 'Mar', y: 15, yValue: 1500),
    ChartSampleData(x: 'Jun', y: 5, yValue: 500),
    ChartSampleData(x: 'Jul', y: 30, yValue: 3000),
    ChartSampleData(x: 'Aug', y: 20, yValue: 2000),
    ChartSampleData(x: 'Sep', y: 40, yValue: 4000),
    ChartSampleData(x: 'Oct', y: 60, yValue: 6000),
    ChartSampleData(x: 'Nov', y: 55, yValue: 5500),
    ChartSampleData(x: 'Dec', y: 38, yValue: 3000),
  ];
  final TooltipBehavior chart = TooltipBehavior(
    enable: true,
    format: 'point.x : point.yValue1 : point.yValue2',
  );

  final List<ChartSampleData> latencyChart = [
    ChartSampleData(x: 'Sun', y: 38),
    ChartSampleData(x: 'Mon', y: 20),
    ChartSampleData(x: 'Tue', y: 60),
    ChartSampleData(x: 'Wed', y: 50),
    ChartSampleData(x: 'The', y: 20),
    ChartSampleData(x: 'Fri', y: 60),
    ChartSampleData(x: 'Set', y: 50),
  ];
  final List<ChartSampleData> latencyChart1 = [
    ChartSampleData(x: 'Sun', y: 20),
    ChartSampleData(x: 'Mon', y: 25),
    ChartSampleData(x: 'Tue', y: 40),
    ChartSampleData(x: 'Wed', y: 10),
    ChartSampleData(x: 'The', y: 38),
    ChartSampleData(x: 'Fri', y: 45),
    ChartSampleData(x: 'Set', y: 60),
  ];

  final List<ChartSampleData> facebookChart = [
    ChartSampleData(x: 1, y: 35),
    ChartSampleData(x: 2, y: 23),
    ChartSampleData(x: 3, y: 34),
    ChartSampleData(x: 4, y: 25),
    ChartSampleData(x: 5, y: 40),
    ChartSampleData(x: 6, y: 35),
    ChartSampleData(x: 7, y: 30),
    ChartSampleData(x: 8, y: 25),
    ChartSampleData(x: 9, y: 30),
  ];
  final TooltipBehavior facebook = TooltipBehavior(
    enable: true,
    tooltipPosition: TooltipPosition.pointer,
    format: 'point.x : point.y',
  );

  final List<ChartSampleData> circleChart = [
    ChartSampleData(
        x: 'David', y: 25, pointColor: const Color.fromRGBO(9, 0, 136, 1)),
    ChartSampleData(
        x: 'Steve', y: 38, pointColor: const Color.fromRGBO(147, 0, 119, 1)),
    ChartSampleData(
        x: 'Jack', y: 34, pointColor: const Color.fromRGBO(228, 0, 124, 1)),
    ChartSampleData(
        x: 'Others', y: 52, pointColor: const Color.fromRGBO(255, 189, 57, 1))
  ];

  void onSelectedTime(String time) {
    selectedTimeOnPage = time;
    update();
  }

  void onSelectedTimeByLocation(String time) {
    selectedTimeByLocation = time;
    update();
  }

  void onSelectedTimeDesign(String time) {
    selectedTimeDesign = time;
    update();
  }


  void onSelectedTimeLatency(String time) {
    selectedTimeLatency = time;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    DashBoard.dummyList.then((value) {
      dashboard = value;
      update();
    });
  }



   onchangeYears(int years) {
     Years=years;
     DashboardPageState.currentPage_a=1;
     update();
     a();

  }
  onchangeMonth(int month) {
    selectedMonthIndex=month;
    DashboardPageState.currentPage_a=1;
    update();
    a();

  }
  changeisChecked(bool cheek) {
 DashboardPageState.isChecked=cheek;
    update();


  }
  setcurrentPage_a(int p,int a) {
    if(p==1){
      DashboardPageState.currentPage_a--;
    }else if(p==2){
      DashboardPageState.currentPage_a++;
    }else{
      DashboardPageState.currentPage_a=a;
    }


    update();


  }
  a() async {
//   .collection('Focus/Attendenc/2023/08/record')
    // الحصول على البيانات من قاعدة البيانات

    final reference1 = FirebaseDatabase.instance
        .ref('Focus/Attendenc/$Years/${selectedMonthIndex + 1}/record');

    // Fetch data from the database
    DatabaseEvent event = await reference1.once();

    if (event.snapshot.value != null) {
      final database = FirebaseDatabase.instance;

      // الحصول على البيانات من قاعدة البيانات
      final reference = database.ref(
        'Focus/Attendenc/$Years/${selectedMonthIndex + 1}/record',
      );

      reference.onValue.listen((event) {
        final data = event.snapshot.value as Map<String, dynamic>;

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


          attendanceData.clear();
          attendanceData = data;

          siteData.clear();
          idess.clear();
          siteData.addAll(uniqueItems);
          idess.addAll(ids);

      });

      final guardDitales = FirebaseDatabase.instance.ref("Focus/Data");

      guardDitales.get().then((guarddata1) {
        final guarddata = <GuardData>[];

        for (var number = 0; number <= 1524; number++) {
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


        Guard_Data.clear();
        Guard_Data.addAll(guarddata);

      });

      final List<Recorda> record2 = [];
      final List<Recorda> record4 = [];
      record2.clear();
      final reference1 = FirebaseDatabase.instance.ref(
          'Focus/Attendenc/${DateTime.now().year}/${selectedMonthIndex + 1}/record');
      reference1.onValue.listen((event) {
        int day = days;

        for (var i in idess) {
          for (var d = 1; d <= day; d++) {
            final jobNo = event.snapshot.child('$i|$d').child("0").child("job_no").value.toString();
            final jobNo2 = event.snapshot.child('$i|$d').child("1").child("job_no").value.toString();
            if (jobNo != "null") {
              final recordd = Recorda(
                id: int.parse(i.toString()),
                job_no: int.parse(jobNo),
                date: event.snapshot
                    .child('$i|$d').child("0")
                    .child("date")
                    .value
                    .toString(),
                datetime: event.snapshot
                    .child('$i|$d').child("0")
                    .child("datetime")
                    .value
                    .toString(),
                shift: event.snapshot
                    .child('$i|$d').child("0")
                    .child("shift")
                    .value
                    .toString(),
              );

              record2.add(recordd);
            }
            if (jobNo2 != "null") {
              final recordd = Recorda(
                id: int.parse(i.toString()),
                job_no: int.parse(event.snapshot
                    .child('$i|$d').child("1")
                    .child("job_no")
                    .value
                    .toString()),
                date: event.snapshot
                    .child('$i|$d').child("1")
                    .child("date")
                    .value
                    .toString(),
                datetime: event.snapshot
                    .child('$i|$d').child("1")
                    .child("datetime")
                    .value
                    .toString(),
                shift: event.snapshot
                    .child('$i|$d').child("1")
                    .child("shift")
                    .value
                    .toString(),
              );

              record4.add(recordd);
            }
          }
        }


        record.clear();
        record3.clear();
        record.addAll(record2);
        record3.addAll(record4);

        update();
      });
      final locationRef = FirebaseDatabase.instance.ref("Focus/Locatins");

      final locations2 = <LocationData>[];
      try {

        DatabaseEvent snapshot = await locationRef.once();

        Map<dynamic, dynamic>? values = snapshot.snapshot.value as Map<dynamic, dynamic>;

        values.forEach((key, value) {


          bool add=false;
          for (var number in siteData) {
            if(number==value['id'] ){
              add=true;
            }
          }
          if(add) {
            LocationData location = LocationData(
              value['id'],
              value['tolal'],
              value['name'].toString(),
              value['day_time'].toString(),
              value['night_time'].toString(),
              value['hors'],
              double.parse(value['Latitude'].toString()),
              double.parse(value['longitude'].toString()),
                getGuardCount('01',value['id']),
              getGuardCount('02',value['id']),
              getGuardCount('03',value['id']),
              getGuardCount('04',value['id']),
              getGuardCount('05',value['id']),
              getGuardCount('06',value['id']),
              getGuardCount('07',value['id']),
              getGuardCount('08',value['id']),
              getGuardCount('09',value['id']),
              getGuardCount('10',value['id']),
              getGuardCount('11',value['id']),
              getGuardCount('12',value['id']),
              getGuardCount('13',value['id']),
              getGuardCount('14',value['id']),
              getGuardCount('15',value['id']),
              getGuardCount('16',value['id']),
              getGuardCount('17',value['id']),
              getGuardCount('18',value['id']),
              getGuardCount('19',value['id']),
              getGuardCount('20',value['id']),
              getGuardCount('21',value['id']),
              getGuardCount('22',value['id']),
              getGuardCount('23',value['id']),
              getGuardCount('24',value['id']),
              getGuardCount('25',value['id']),
              getGuardCount('26',value['id']),
              getGuardCount('27',value['id']),
              getGuardCount('28',value['id']),
              getGuardCount('29',value['id']),
              getGuardCount('30',value['id']),
              getGuardCount('31',value['id']),




            );
            locations2.add(location);
          }
        });


      } catch (error) {
        print('Error: $error');
      }
      // Sort the list by 'id' in ascending order
      locations2.sort((a, b) => a.id.compareTo(b.id));

      // Now 'locations2' is sorted by 'id' in ascending order


      // If you want to create a new list with the sorted data, you can do:
      List<LocationData> locationsAll = List.from(locations2);
      // or: List<LocationData> locationsAll = [...locations2];

      // Now 'locationsAll' is a new list with the sorted data


        locationsall.clear();
        locationsall.addAll(locationsAll);


      // You can access the data using event.snapshot.value
    } else {

        attendanceData.clear();

        locationsall.clear();

        Guard_Data.clear();

        record.clear();
        record3.clear();

        siteData.clear();
        idess.clear();
        update();

    }
  }

  void goToProducts() {
    Get.toNamed('/apps/ecommerce/products');
  }

  void goToCustomers() {
    Get.toNamed('/apps/ecommerce/customers');
  }
  int getGuardCount(String day, int targetSiteNumber) {
    return attendanceData.values.where((attendance) {
      return attendance.length > 1
          ? attendance[1]['date'] == day &&
          attendance[1]['job_no'] == targetSiteNumber
          : false;
    }).length +
        attendanceData.values.where((attendance) {
          return attendance[0]['date'] == day &&
              attendance[0]['job_no'] == targetSiteNumber;
        }).length;
  }
}
