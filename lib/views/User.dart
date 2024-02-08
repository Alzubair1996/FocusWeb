class Recorda {
  int id;
  int job_no;
  String date;
  String datetime;
  String shift;

  Recorda({required this.id, required this.job_no,required this.date,required this.datetime,required this.shift});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'job_no': job_no,
      'date': date,
      'datetime': datetime,
      'shift': shift,
    };
  }
}