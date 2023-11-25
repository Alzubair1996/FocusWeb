import 'dart:html';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons/lucide_icons.dart';
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
import '../../Location_ofEvent.dart';

import '../../helpers/theme/app_style.dart';
import '../../helpers/theme/app_theme.dart';
import '../../helpers/theme/theme_customizer.dart';
import '../../helpers/widgets/my_button.dart';
import '../../helpers/widgets/my_text_style.dart';

class Calender extends StatefulWidget {
  const Calender({Key? key}) : super(key: key);

  @override
  State<Calender> createState() => CalenderState();
}

class CalenderState extends State<Calender>
    with SingleTickerProviderStateMixin, UIMixin {

  @override
  void initState() {
    super.initState();

    fetchFootballMatches();
  }

  late CalenderController controller;
  String selectedValue = "Value 1";
  DateTime _displayedMonth = DateTime.now();
  String namestad = "";
  static List<FootballMatch> football = [];
  static List<FootballMatch> footballday = [];
  final Location_ofEventall = <Location_ofEvents>[];
  bool isFirstOpen = true;
  bool ste = false;
  late DateTime selectedDate;
  late DateTime selectedDateBefor;



  void _showMyDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText.titleMedium(
                    "Add New Event",
                  ),
                ],
              ),
              titlePadding: MySpacing.xy(16, 12),
              insetPadding: MySpacing.y(200),
              actionsPadding: MySpacing.xy(150, 16),
              contentPadding: MySpacing.x(16),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText.bodyMedium("Name :"),
                  MySpacing.height(8),
                  TextFormField(
                    //   validator: controller.basicValidator.getValidation('name'),
                    //    controller: controller.basicValidator.getController('name'),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Name",
                      labelStyle:
                      MyTextStyle.bodySmall(xMuted: true),
                      border: outlineInputBorder,
                      contentPadding: MySpacing.all(16),
                      isCollapsed: true,
                      floatingLabelBehavior:
                      FloatingLabelBehavior.never,
                    ),
                  ),
                  MySpacing.height(16),
                  MyText.bodyMedium("Address :"),
                  MySpacing.height(16),
                  TextFormField(
                    //  validator: controller.basicValidator.getValidation('address'),
                    // controller: controller.basicValidator.getController('address'),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Address",
                      labelStyle:
                      MyTextStyle.bodySmall(xMuted: true),
                      border: outlineInputBorder,
                      contentPadding: MySpacing.all(16),
                      isCollapsed: true,
                      floatingLabelBehavior:
                      FloatingLabelBehavior.never,
                    ),
                  ),
                  MySpacing.height(16),
                  MyText.labelMedium(
                      "Stad of event"
                  ),
                  MySpacing.height(8),
                  DropdownButtonFormField<Location_ofEvents>(
                    dropdownColor: theme
                        .colorScheme.background,
                    menuMaxHeight: 200,
                    items: Location_ofEventall.map((gender) =>
                        DropdownMenuItem<Location_ofEvents>(
                            value:gender,
                            child:
                            MyText
                                .labelMedium(
                              gender.location,
                            )))
                        .toList(),
                    icon: const Icon(
                      LucideIcons.chevronDown,
                      size: 20,
                    ),
                    decoration: InputDecoration(
                      hintText: "Select gender",
                      hintStyle:
                      MyTextStyle.bodySmall(
                          xMuted: true),
                      border: outlineInputBorder,
                      enabledBorder:
                      outlineInputBorder,
                      focusedBorder:
                      focusedInputBorder,
                      contentPadding:
                      MySpacing.all(16),
                      isCollapsed: true,
                    ),
                    onChanged: (Location_ofEvents? value) {
                      setState(() {
                        namestad=value!.name.toString();
                      });

                    },

                  ),

                  MyText.labelMedium(
                      "$namestad"
                  ),
                ],
              ),
              actions: [
                MyButton(
                  // onPressed: controller.onSubmit,
                  onPressed: () {
                    Navigator.pop(context);
                  },

                  elevation: 0,
                  backgroundColor: contentTheme.primary,
                  borderRadiusAll: AppStyle.buttonRadius.medium,
                  child: MyText.bodyMedium(
                    "Ok",
                    color: contentTheme.onPrimary,
                  ),
                ),
                MyButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  elevation: 0,
                  backgroundColor: contentTheme.primary,
                  borderRadiusAll: AppStyle.buttonRadius.medium,
                  child: MyText.bodyMedium(
                    "Cancel",
                    color: contentTheme.onPrimary,
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

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
                  alignment: ThemeCustomizer
                      .instance.currentLanguage.locale.languageCode ==
                      "ar"
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: MyCard(
                    shadow: MyShadow(elevation: 0.5),
                    height: 420,
                    width: 400,
                    child:


                    Column(
                      children: [
                        Expanded(
                          flex: 0,
                          child: MyCard(
                            onTap: (){

                              _showMyDialog();



                              /*
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  title: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      MyText.titleMedium(
                                        "Add New Event",
                                      ),
                                    ],
                                  ),
                                  titlePadding: MySpacing.xy(16, 12),
                                  insetPadding: MySpacing.y(200),
                                  actionsPadding: MySpacing.xy(150, 16),
                                  contentPadding: MySpacing.x(16),
                                  content: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      MyText.bodyMedium("Name :"),
                                      MySpacing.height(8),
                                      TextFormField(
                                     //   validator: controller.basicValidator.getValidation('name'),
                                    //    controller: controller.basicValidator.getController('name'),
                                        keyboardType: TextInputType.emailAddress,
                                        decoration: InputDecoration(
                                          labelText: "Name",
                                          labelStyle:
                                          MyTextStyle.bodySmall(xMuted: true),
                                          border: outlineInputBorder,
                                          contentPadding: MySpacing.all(16),
                                          isCollapsed: true,
                                          floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                        ),
                                      ),
                                      MySpacing.height(16),
                                      MyText.bodyMedium("Address :"),
                                      MySpacing.height(16),
                                      TextFormField(
                                      //  validator: controller.basicValidator.getValidation('address'),
                                       // controller: controller.basicValidator.getController('address'),
                                        keyboardType: TextInputType.emailAddress,
                                        decoration: InputDecoration(
                                          labelText: "Address",
                                          labelStyle:
                                          MyTextStyle.bodySmall(xMuted: true),
                                          border: outlineInputBorder,
                                          contentPadding: MySpacing.all(16),
                                          isCollapsed: true,
                                          floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                        ),
                                      ),
                                      MyText.labelMedium(
                                      "Stad of event"
                                      ),
                                      MySpacing.height(8),
                                      DropdownButtonFormField<Location_ofEvents>(
                                          dropdownColor: theme
                                              .colorScheme.background,
                                          menuMaxHeight: 200,
                                          items: Location_ofEventall.map((gender) =>
                                              DropdownMenuItem<Location_ofEvents>(
                                                  value:gender,
                                                  child:
                                                  MyText
                                                      .labelMedium(
                                                    gender.location,
                                                  )))
                                              .toList(),
                                          icon: const Icon(
                                            LucideIcons.chevronDown,
                                            size: 20,
                                          ),
                                          decoration: InputDecoration(
                                              hintText: "Select gender",
                                              hintStyle:
                                              MyTextStyle.bodySmall(
                                                  xMuted: true),
                                              border: outlineInputBorder,
                                              enabledBorder:
                                              outlineInputBorder,
                                              focusedBorder:
                                              focusedInputBorder,
                                              contentPadding:
                                              MySpacing.all(16),
                                              isCollapsed: true,
                                          ),
                                        onChanged: (Location_ofEvents? value) {
                                            setState(() {
                                              namestad=value!.name.toString();
                                            });

                                        },

                                        //  onChanged: controller.basicValidator.onChanged<Object?>('gender'),
                                         // validator: controller.basicValidator.getValidation<Gender?>('gender')),
                                      ),

                                      MyText.labelMedium(
                                          "$namestad jjjjjjjjjj"
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    MyButton(
                                      // onPressed: controller.onSubmit,
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },

                                      elevation: 0,
                                      backgroundColor: contentTheme.primary,
                                      borderRadiusAll: AppStyle.buttonRadius.medium,
                                      child: MyText.bodyMedium(
                                        "Ok",
                                        color: contentTheme.onPrimary,
                                      ),
                                    ),
                                    MyButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      elevation: 0,
                                      backgroundColor: contentTheme.primary,
                                      borderRadiusAll: AppStyle.buttonRadius.medium,
                                      child: MyText.bodyMedium(
                                        "Cancel",
                                        color: contentTheme.onPrimary,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                              */
                            },
                            height:60 ,

                              color:Colors.deepOrange,
                              child: Align(
                                alignment: ThemeCustomizer
                                    .instance.currentLanguage.locale.languageCode ==
                                    "ar"
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                child: Padding(
                                    padding: const EdgeInsets.all(0.0),
                                    child: Row(
                                      children: const [
                                        Expanded(
                                          flex: 0,
                                          child: Text(
                                            "Add New Event",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight:
                                                FontWeight.bold,color: Colors.white),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                          height: 10,
                                        ),
                                       Expanded(
                                         flex: 0,
                                         child: Icon(
                                            Icons.add,
                                            color: Colors.white,
                                          ),
                                       ),

                                      ],
                                    )),
                              )),
                        ),

                        Expanded(
                          flex: 1,
                          child: ListView.builder(
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
                                            alignment: ThemeCustomizer
                                                .instance.currentLanguage.locale.languageCode ==
                                                "ar"
                                                ? Alignment.centerRight
                                                : Alignment.centerLeft,
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
                      ],
                    ),

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
    DatabaseReference eventReflocaton = FirebaseDatabase.instance.ref("Focus/Location_ofEvents");

    final Location_ofEvent = <Location_ofEvents>[];
    try {
      DatabaseEvent snapshot = await eventReflocaton.once();

      Map<dynamic, dynamic>? values1 =
      snapshot.snapshot.value as Map<dynamic, dynamic>;

      values1.forEach((key, value) {
        Location_ofEvents location = Location_ofEvents(
            value['name'],
            value['location'],
            value['Latitude'],
            value['longitude'],
            value['id'],
        );
        Location_ofEvent.add(location);
      });
    } catch (error) {
      print('Error: $error');
    }

    setState(() {
      Location_ofEventall.clear();
      Location_ofEventall.addAll(Location_ofEvent);

    });

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
