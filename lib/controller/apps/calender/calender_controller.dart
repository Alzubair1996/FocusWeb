import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:webkit/controller/my_controller.dart';

import '../../../views/apps/calender.dart';
import '../project/create_project_controller.dart';

class CalenderController extends MyController {
  late DataSource events;
  ProjectPrivacy selectProjectPrivacy = ProjectPrivacy.Private;
  DateTime? selectedStartDate;
  DateTime? selectedStartDate2;
  DateTime? selectedEndDate;
  String selectProperties = "Medium";
  String selectMembers = "";
  List<PlatformFile> files = [];
  @override

  void onInit() {
    super.onInit();
    events = addAppointments();
  }

  void dragEnd(AppointmentDragEndDetails appointmentDragEndDetails) {

    Appointment detail = appointmentDragEndDetails.appointment as Appointment;
    Duration duration = detail.endTime.difference(detail.startTime);

    DateTime start = DateTime(
        appointmentDragEndDetails.droppingTime!.year,
        appointmentDragEndDetails.droppingTime!.month,
        appointmentDragEndDetails.droppingTime!.day,

        0,
        0);

    final List<Appointment> appointment = <Appointment>[];
    events.appointments!.remove(appointmentDragEndDetails.appointment);

    events.notifyListeners(CalendarDataSourceAction.remove,
        <dynamic>[appointmentDragEndDetails.appointment]);

    Appointment app = Appointment(

      subject: detail.subject,
      color: detail.color,
      startTime: start,
      endTime: start.add(duration),
    );

    appointment.add(app);

    events.appointments!.add(appointment[0]);

    events.notifyListeners(CalendarDataSourceAction.add, appointment);
  }

  DataSource addAppointments()  {
    List<Appointment> appointmentCollection = <Appointment>[];


    return DataSource(appointmentCollection);
  }

  Future<void> pickStartDate() async {
    final DateTime? picked = await showDatePicker(
        context: Get.context!,
        initialDate: selectedStartDate ?? DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedStartDate) {

      selectedStartDate = picked;
      update();
    }
  }
}

class DataSource extends CalendarDataSource {
  DataSource(List<Appointment> source) {

    appointments = source;
  }
}
