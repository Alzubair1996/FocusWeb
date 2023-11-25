import 'dart:html';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:webkit/controller/apps/calender/calender_controller.dart';
import 'package:webkit/helpers/utils/my_shadow.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/helpers/widgets/my_breadcrumb.dart';
import 'package:webkit/helpers/widgets/my_breadcrumb_item.dart';
import 'package:webkit/helpers/widgets/my_card.dart';
import 'package:webkit/helpers/widgets/my_spacing.dart';
import 'package:webkit/helpers/widgets/my_text.dart';
import 'package:webkit/helpers/widgets/responsive.dart';
import 'package:webkit/views/layouts/layout.dart';

import '../../Event.dart';
import '../../controller/dashboard_controller.dart';
import '../../helpers/theme/theme_customizer.dart';

class Calender extends StatefulWidget {
  const Calender({Key? key}) : super(key: key);

  @override
  State<Calender> createState() => CalenderState();
}

class CalenderState extends State<Calender>
    with SingleTickerProviderStateMixin, UIMixin {
  late CalenderController controller;

   DateTime _displayedMonth = DateTime.now();

  @override
  void initState() {
    super.initState();

    fetchFootballMatches();

  }

  static List<FootballMatch> football = [];
  static List<FootballMatch> footballday = [];
  bool isFirstOpen = true;
  bool ste = false;
  late DateTime selectedDate;
  late DateTime selectedDateBefor;
  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
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
                      "Event",
                      fontWeight: 600,
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: Align(
                  alignment: ThemeCustomizer
                              .instance.currentLanguage.locale.languageCode ==
                          "ar"
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: MyCard(
                    shadow: MyShadow(elevation: 0.5),
                    height: 400,
                    width: 400,
                    child: Column(
                      children: [
                      Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: (){

                            setState(() {
                              _displayedMonth = DateTime(_displayedMonth.year, _displayedMonth.month - 1, 1);

                            });

                          },
                          child: Text('Previous Month'),
                        ),
                        SizedBox(width: 20
                        ,height: 20,),
                        TextButton(
                          onPressed: (){
                            setState(() {
                              _displayedMonth = DateTime(_displayedMonth.year, _displayedMonth.month + 1, 1);

                            });
                          },
                          child: Text('Next Month'),
                        ),
                      ],
                    ),
                    Expanded(
                      child:
                      SfCalendar(

                          view: CalendarView.month,
                         initialSelectedDate: isFirstOpen?DateTime.now():selectedDate,
                          dataSource: controller.events,
                        initialDisplayDate: _displayedMonth,
                          allowDragAndDrop: false,
                          onSelectionChanged: (date) {
                            String a = date.date.toString();
                            DateTime dateTime = DateTime.parse(a);
                            String formattedDate =
                            DateFormat('dd/MM/yyyy').format(dateTime);
                            print(formattedDate);
                            selectedDate=date.date!;
                            if(date.date!=DateTime.now()&&selectedDate==null){

                            setState(() {
                              selectedDate = date.date!;
                              isFirstOpen = false;
                            });


                            }else{


                                  if(football.isNotEmpty){
                                  try{
                                  List<FootballMatch> footballday1 = [];
                                  bool firest = true;
                                  for (int i = 0; i < football.length; i++) {
                                  if (football[i].date == formattedDate) {
                                  footballday1.add(FootballMatch(
                                  football[i].id,
                                  football[i].contG,
                                  football[i].date,
                                  football[i].emirates,
                                  football[i].name,
                                  football[i].status,
                                  firest ? Colors.orangeAccent : Colors.white));
                                  firest = false;
                                  }
                                  }
                                  setState(() {
                                  selectedDate=date.date!;
                                  isFirstOpen=false;
                                  if(footballday.isEmpty){
                                    footballday.clear();
                                    footballday.addAll(footballday1);
                                  }else {
                                    if (footballday[0].date != formattedDate) {
                                      footballday.clear();
                                      footballday.addAll(footballday1);
                                    }
                                  }

                                  });
                                  }catch(e){




                                  //


                                  }
                                  }
                            }







                           // fetchFootballMatches();
                        /*


                        */
                            // print();
                          },
                          onDragEnd: controller.dragEnd,

                        ),)
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: MyCard(
                    shadow: MyShadow(elevation: 0.5),
                    height: 400,
                    width: 400,
                    child:


                    ListView.builder(
                        scrollDirection: Axis.vertical,
                        // التوجيه الأفقي
                        itemCount: footballday.length,
                        itemBuilder: (context, dayIndex) {
                          return Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: GestureDetector(
                                onTap: () {
                                  try {
                                    for (int i = 0;
                                        i < footballday.length;
                                        i++) {
                                      setState(() {
                                        ste=true;
                                        footballday[i].color = Colors.white;
                                      });
                                    }
                                  } catch (e) {
                                    print("$e");
                                  }
                                  footballday[dayIndex].color =
                                      Colors.orangeAccent;

                                },
                                child: MyCard(
                                    color: footballday[dayIndex].color,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Text(
                                                footballday[dayIndex].name,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                "  ContG : " +
                                                    footballday[dayIndex].contG,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          )),
                                    )),
                              ));
                        }),

                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> fetchFootballMatches() async {
    DatabaseReference eventRef = FirebaseDatabase.instance.ref("Focus/Event");

    final locations2 = <FootballMatch>[];
    try {
      DatabaseEvent snapshot = await eventRef.once();

      Map<dynamic, dynamic>? values =
          snapshot.snapshot.value as Map<dynamic, dynamic>;

      values.forEach((key, value) {
        FootballMatch location = FootballMatch(
            value['ID'],
            value['Cont_G'],
            value['Date'],
            value['Emirates'],
            value['Name'],
            value['Status'],
            Colors.transparent);
        locations2.add(location);
      });
    } catch (error) {
      print('Error: $error');
    }

    setState(() {
      football.clear();
      football.addAll(locations2);
      controller = Get.put(CalenderController());
    });
  }
}
