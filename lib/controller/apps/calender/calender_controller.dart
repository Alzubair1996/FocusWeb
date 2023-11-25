import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:webkit/controller/my_controller.dart';

import '../../../views/apps/calender.dart';

class CalenderController extends MyController {
  late DataSource events;

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



    for(int i =0; i<CalenderState.football.length;i++){

      String dateString = CalenderState.football[i].date;
      List<String> dateParts = dateString.split('/');
      int day = int.parse(dateParts[0]);
      int month = int.parse(dateParts[1]);
      int year = int.parse(dateParts[2]);
      DateTime dateTime = DateTime(year, month, day);
      appointmentCollection.add(Appointment(
          startTime: dateTime,
          endTime: dateTime.add(const Duration(hours: 0)),
          subject: CalenderState.football[i].name,
          color: Colors.blue));
    }
    return DataSource(appointmentCollection);
  }
}

class DataSource extends CalendarDataSource {
  DataSource(List<Appointment> source) {

    appointments = source;
  }
}
