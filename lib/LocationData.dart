

import 'package:flutter/material.dart';

class LocationData {
  final int id;
  late final int tolal;
  final String name;
  final String day_time;
  final String night_time;
  final int hors;
  final double  latitude;
  final double  longitude;
   late  Color  color=  Colors.white;


  LocationData(this.id,this.tolal,this.name,this.day_time,this.night_time,this.hors, this.latitude, this.longitude);
}