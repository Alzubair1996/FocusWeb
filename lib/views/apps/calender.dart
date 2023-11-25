
import 'dart:html';
import 'dart:ui_web';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:webkit/controller/apps/calender/calender_controller.dart';
import 'package:webkit/helpers/utils/my_shadow.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/helpers/widgets/my_card.dart';
import 'package:webkit/helpers/widgets/my_spacing.dart';
import 'package:webkit/helpers/widgets/my_text.dart';
import 'package:webkit/helpers/widgets/responsive.dart';
import 'package:webkit/views/layouts/layout.dart';

import '../../Event.dart';
import '../../Location_ofEvent.dart';

import '../../app_constant.dart';
import '../../helpers/theme/app_style.dart';
import '../../helpers/theme/app_theme.dart';
import '../../helpers/theme/theme_customizer.dart';
import '../../helpers/widgets/my_button.dart';
import '../../helpers/widgets/my_container.dart';
import '../../helpers/widgets/my_text_style.dart';

class Calender extends StatefulWidget {
  const Calender({Key? key}) : super(key: key);

  @override
  State<Calender> createState() => CalenderState();
}

class CalenderState extends State<Calender>
    with SingleTickerProviderStateMixin, UIMixin {
  void onInit() {

    fetchFootballMatches() ;
  }
  @override
  void initState() {

    super.initState();
    loadGoogleMaps();
    controller = Get.put(CalenderController());
  fetchFootballMatches() ;
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
  late String selectedDates;
  late DateTime selectedDateBefor;
  TextEditingController locationanother = TextEditingController();
  final GlobalKey buttonKey = GlobalKey();

  void _showMyDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
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
              insetPadding: MySpacing.y(namestad=="Another"?150:230),
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
                    keyboardType: TextInputType.text,
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
               Row(
                 children: [
                   Expanded(
                     flex: 1,
                  child :Column(
                     children: [
                       Align(
                         alignment: Alignment.centerLeft,
                         child: MyText.bodyMedium(
                           "Select Start Date ",
                           fontWeight: 600,
                           muted: true,
                         ),
                       ),
                       MySpacing.height(8),
                       MyContainer.bordered(
                         color: Colors.transparent,
                         paddingAll: 12,
                         onTap: () async {

                           final DateTime? picked = await showDatePicker(
                               context: Get.context!,
                               initialDate: controller.selectedStartDate ?? DateTime.now(),
                               firstDate: DateTime(2015, 8),
                               lastDate: DateTime(2101));
                           if (picked != null && picked != controller.selectedStartDate) {
                             setState(()  {
                               controller.selectedStartDate = picked;
                               controller.selectedStartDate2 = picked;
                               controller.update();
                             });

                           }

                         },
                         borderColor: theme.colorScheme.secondary,
                         child: Row(
                           mainAxisAlignment:
                           MainAxisAlignment.start,
                           crossAxisAlignment:
                           CrossAxisAlignment.start,
                           children: <Widget>[
                             Icon(
                               LucideIcons.calendar, color: theme.colorScheme.secondary,
                               size: 16,
                             ),
                             MySpacing.width(10),
                             MyText.bodyMedium(
                               controller.selectedStartDate != null ? dateFormatter.format(controller.selectedStartDate!) :  selectedDates,
                               fontWeight: 600,
                               color: theme
                                   .colorScheme.secondary,
                             ),
                           ],
                         ),
                       ),
                     ],
                   ),

                   ),
                   MySpacing.width(8),
                   Expanded(
                     flex: 1,
                  child: Column(
                     children: [

                  Align(
                  alignment: Alignment.centerLeft,
                         child: MyText.bodyMedium(
                           "Select End Date ",
                           fontWeight: 600,
                           muted: true,
                         ),
                       ),
                       MySpacing.height(8),
                       MyContainer.bordered(
                         color: Colors.transparent,
                         paddingAll: 12,
                         onTap: () async {

                           final DateTime? picked = await showDatePicker(
                               context: Get.context!,
                               initialDate: controller.selectedStartDate2 ?? DateTime.now(),
                               firstDate: DateTime(2015, 8),
                               lastDate: DateTime(2101));
                           if (picked != null && picked != controller.selectedStartDate2) {
                             setState(()  {
                               controller.selectedStartDate2 = picked;
                               controller.update();
                             });

                           }

                         },
                         borderColor: theme.colorScheme.secondary,
                         child: Row(
                           mainAxisAlignment:
                           MainAxisAlignment.start,
                           crossAxisAlignment:
                           CrossAxisAlignment.start,
                           children: <Widget>[
                             Icon(
                               LucideIcons.calendar, color: theme.colorScheme.secondary,
                               size: 16,
                             ),
                             MySpacing.width(10),
                             MyText.bodyMedium(
                               controller.selectedStartDate2 != null ? dateFormatter.format(controller.selectedStartDate2!) :  selectedDates,
                               fontWeight: 600,
                               color: theme
                                   .colorScheme.secondary,
                             ),
                           ],
                         ),
                       ),
                     ],
                   ),
                   ),
                 ],
               ),
                  MySpacing.height(16),
                  MyText.bodyMedium("Cont of Guard :"),
                  MySpacing.height(16),
                  TextFormField(
                    //  validator: controller.basicValidator.getValidation('address'),
                    // controller: controller.basicValidator.getController('address'),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Cont of Guard",
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
                      hintText: "Select Location",
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

                  namestad=="Another"?Container():MyText.labelMedium(
                      namestad),
                  namestad=="Another"?
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: [
                        MySpacing.height(16),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: MyText.bodyMedium("Name of location : ")),
                        MySpacing.height(16),
                        TextFormField(
                          controller: locationanother,
                          //  validator: controller.basicValidator.getValidation('address'),
                          // controller: controller.basicValidator.getController('address'),
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: "Name of location",
                            labelStyle:
                            MyTextStyle.bodySmall(xMuted: true),
                            border: outlineInputBorder,
                            contentPadding: MySpacing.all(16),
                            isCollapsed: true,
                            floatingLabelBehavior:
                            FloatingLabelBehavior.never,
                          ),
                        ),
                      ],
                    ),
                  ):Container(),
                  namestad=="Another"?
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: [
                        MySpacing.height(16),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: MyButton(child: Text("Select Location ",style: TextStyle(color:  Colors.white),),
                            onPressed: (){


                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return StatefulBuilder(
                                      builder: (BuildContext context, StateSetter setState) {
                                        return AlertDialog(

                                          clipBehavior: Clip.antiAliasWithSaveLayer,
                                          title: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              MyText.titleMedium(
                                                "Select Location ",
                                              ),
                                            ],
                                          ),
                                          titlePadding: MySpacing.xy(16, 12),
                                          insetPadding: MySpacing.y(230),
                                          actionsPadding: MySpacing.xy(200, 16),
                                          contentPadding: MySpacing.x(16),
                                          content:    SizedBox(
                                            width: 400,
                                            height: 400,
                                            child: HtmlElementView(
                                              viewType: 'google_maps',
                                            ),

                                          ),
                                          actions: [
                                            FilledButton(

                                              // onPressed: controller.onSubmit,
                                              onPressed: () {
                                                _showClickLocation(context);
                                         //       Navigator.pop(context);
                                              },
                                              key: buttonKey,
                                          //    elevation: 0,
                                             // backgroundColor: contentTheme.primary,
                                             // borderRadiusAll: AppStyle.buttonRadius.medium,
                                              child: MyText.bodyMedium(
                                                "Ok",
                                                color: contentTheme.onPrimary,
                                              ),
                                            ),
                                            MyButton(
                                              onPressed: () {
                                                Navigator.pop(context);

                                                namestad="";
                                                controller.selectedStartDate=  selectedDate;
                                                controller.selectedStartDate2=  selectedDate;



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


                            },)),
                      ],
                    ),
                  ):Container(),

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

                      namestad="";
                      controller.selectedStartDate=  selectedDate;
                      controller.selectedStartDate2=  selectedDate;



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
                        Expanded(
                          flex: 1,
                          child: TextButton(
                            onPressed: (){

                              setState(() {
                                _displayedMonth = DateTime(_displayedMonth.year, _displayedMonth.month - 1, 1);

                              });

                            },
                            child: Text('Previous Month'),
                          ),
                        ),
                        SizedBox(width: 20
                        ,height: 20,),
                        Expanded(
                          flex: 1,
                          child: TextButton(
                            onPressed: (){
                              setState(() {
                                _displayedMonth = DateTime(_displayedMonth.year, _displayedMonth.month + 1, 1);

                              });
                            },
                            child: Text('Next Month'),
                          ),
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
                            String formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);

                            selectedDate=date.date!;
                            if(date.date!=DateTime.now()&&selectedDate==null){

                            setState(() {
                              selectedDates=formattedDate;
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
                                    selectedDates=formattedDate;
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
                                    child:  MyCard(
                                      onTap: (){
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
                                          )
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

  void loadGoogleMaps() {
    const src = '''

<html>

<head>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
    <meta charset="utf-8">
    <style>
        html,
        body {
            height: 100%;
            margin: 0;
            padding: 0;
        }

        #map {
            height: 100%;
        }
        input[type=text], select {
  width: 100%;
  padding: 12px 20px;
  margin: 8px 0;
  display: inline-block;
  border: 1px solid #ccc;
  border-radius: 4px;
  box-sizing: border-box;
}

input[type=submit] {
  width: 100%;
  background-color: #4CAF50;
  color: white;
  padding: 14px 20px;
  margin: 8px 0;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}

input[type=submit]:hover {
  background-color: #45a049;
}
    </style>
</head>

<body>
    <input id="searchInput" type="text" placeholder="Search for a location">
    <div id="map"></div>

    <script>
        var map;
        var marker;

        function initMap() {
            map = new google.maps.Map(document.getElementById('map'), {
            
  

                center: {
                    lat: 25.35262399520326,
                    lng: 55.527496232968936
                },
                zoom: 12,
                mapTypeControl: false, // لإزالة خيارات Map و Satellite
                fullscreenControl: false // لإزالة خيار وضع الشاشة الكاملة
            });

            var searchInput = document.getElementById('searchInput');
            var searchBox = new google.maps.places.SearchBox(searchInput);

            map.controls[google.maps.ControlPosition.TOP_LEFT].push(searchInput);

            google.maps.event.addListener(map, 'click', function (event) {
                if (marker) {
                    marker.setMap(null);
                }

                var clickedLocation = event.latLng;

                marker = new google.maps.Marker({
                    position: clickedLocation,
                    map: map,
                    title: "Selected Location"
                });

                var infoWindow = new google.maps.InfoWindow({
                    content: 'Location: ' + clickedLocation.lat() + ', ' + clickedLocation.lng()
                });

                infoWindow.open(map, marker);
            });

            searchBox.addListener('places_changed', function () {
                var places = searchBox.getPlaces();

                if (places.length == 0) {
                    return;
                }

                if (marker) {
                    marker.setMap(null);
                }

                var bounds = new google.maps.LatLngBounds();
                places.forEach(function (place) {
                    if (!place.geometry) {
                        console.log("Returned place contains no geometry");
                        return;
                    }

                    marker = new google.maps.Marker({
                        map: map,
                        title: place.name,
                        position: place.geometry.location
                    });

                    if (place.geometry.viewport) {
                        bounds.union(place.geometry.viewport);
                    } else {
                        bounds.extend(place.geometry.location);
                    }
                });
                map.fitBounds(bounds);
            });
        }
    </script>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDU-F4ZT5wfF6tEzV68JuwsICP6kDkHvwg&libraries=places&callback=initMap"
        async defer></script>
</body>

</html>


''';

    final IFrameElement iframe = IFrameElement()
      ..width = '100%'
      ..height = '100%'
      ..srcdoc = src
      ..style.border = 'none';

    // Create a platform view and associate it with the iframe element
    platformViewRegistry.registerViewFactory(
      'google_maps',
          (int viewId) => iframe,
    );

    // Listen for postMessage events from the iframe
    window.onMessage.listen((message) {
      if (message.data == 'googleMapsLoaded') {
        // The Google Maps script has loaded
        // Perform any additional tasks here
      }
    });
  }

  void _showClickLocation(BuildContext context) {
    RenderBox renderBox = buttonKey.currentContext!.findRenderObject() as RenderBox;
    Offset localPosition = renderBox.localToGlobal(Offset.zero);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Click Location'),
          content: Text('X: ${localPosition.dx}, Y: ${localPosition.dy}'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
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
    List<Appointment> appointmentCollection = <Appointment>[];
    try {
      DatabaseEvent snapshot = await eventRef.once();

      Map<dynamic, dynamic>? values =
          snapshot.snapshot.value as Map<dynamic, dynamic>;

      values.forEach((key, value) {


        String dateString = value['Date'];
        List<String> dateParts = dateString.split('/');
        int day = int.parse(dateParts[0]);
        int month = int.parse(dateParts[1]);
        int year = int.parse(dateParts[2]);
        DateTime dateTime = DateTime(year, month, day);
        appointmentCollection.add(Appointment(
            startTime: dateTime,
            endTime: dateTime.add(const Duration(hours: 0)),
            subject:value['Emirates'],
            color: Colors.blue));

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
      controller.events=DataSource(appointmentCollection);
    });








  }
}
