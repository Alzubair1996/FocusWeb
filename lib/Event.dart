import 'package:flutter/material.dart'; // Required for using Colors

class FootballMatch {
  final String id;
  final String contG;
  final String date;
  final String emirates;
  final String name;
  final String status;
  late Color color; // Define the color property with late initialization

  FootballMatch(
     this.id,
     this.contG,
     this.date,
     this.emirates,
     this.name,
     this.status,
     Color color, // Require color in the constructor
  ) {
    this.color = color; // Assign the provided color to the field
  }

// Other methods or constructors if needed
}
