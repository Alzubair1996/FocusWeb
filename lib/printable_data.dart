import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:webkit/helpers/extensions/string.dart';
import 'package:webkit/views/dashboard.dart';

buildPrintableData(ttf) => pw.Padding(
      padding: const pw.EdgeInsets.all(13.00),
      child: pw.Column(children: [
        pw.Row(children: [
          //pw.Image(logo, width: 40, height: 40),
          pw.Container(
              width: 800,
              child: pw.Center(
                // style: pw.TextStyle(font: ttf, fontSize: 24)
                  child: pw.Text(
                    "Summary Attendance Sheet of ${DashboardPageState.selectedMonthIndex}  ${DashboardPageState.Years}",
                    style: pw.TextStyle(
                      fontSize: 16,font: ttf
                    ),
                  )))
        ]),
        pw.SizedBox(width: 5, height: 5),
        pw.Row(children: [
          pw.Expanded(
            flex: 0,
            child: pw.Container(
              decoration: pw.BoxDecoration(
                color: PdfColors.orangeAccent,
                border: pw.Border.all(
                  color: PdfColors.black,
                  width: 1, // عرض الحدود
                ),
              ),
              child: pw.Container(
                margin: pw.EdgeInsets.only(left: 0.5),
                child: pw.SizedBox(
                    width: 44,
                    height: 20,
                    child: pw.Center(child: pw.Text("Job No.",
                    style: pw.TextStyle(font: ttf)))),
              ),
            ),
          ),
          pw.Expanded(
            flex: 0,
            child: pw.Container(
              decoration: pw.BoxDecoration(
                color: PdfColors.orangeAccent,
                border: pw.Border.all(
                  color: PdfColors.black,
                  width: 1, // عرض الحدود
                ),
              ),
              child: pw.Container(
                margin: pw.EdgeInsets.only(left: 0.5),
                child: pw.SizedBox(
                    width: 130,
                    height: 20,
                    child: pw.Center(child: pw.Text("Name",style: pw.TextStyle(font: ttf)))),
              ),
            ),
          ),
          pw.ListView.builder(
              direction: pw.Axis.horizontal,
              itemCount: DashboardPageState.days,
              itemBuilder: (context, dayIndex) {
                final day = (dayIndex + 1).toString();

                return pw.Container(
                  decoration: pw.BoxDecoration(
                    color: PdfColors.orangeAccent,
                    border: pw.Border.all(
                      color: PdfColors.black,
                      width: 1, // عرض الحدود
                    ),
                  ),
                  child: pw.Container(
                    // تعيين Padding إلى صفر
                    margin: pw.EdgeInsets.only(left: 0.5),

                    child: pw.SizedBox(
                      width: 20,
                      height: 20,
                      // تحديد عرض العنصر حسب احتياجاتك
                      child: pw.Center(child: pw.Text(day,style: pw.TextStyle(font: ttf))),
                    ),
                  ),
                );
              }),
        ]),


//27
        pw.SizedBox(
            height: DashboardPageState.locationsall.length*20,

            child:
            pw.ListView.builder(
                direction: pw.Axis.vertical,
                itemCount: DashboardPageState.locationsall.length,
                itemBuilder: (context, index) {
                  final name =
                  DashboardPageState.locationsall[index].name.toString();
                 final num= DashboardPageState.locationsall[index].tolal.toString();
                  final numer =
                  DashboardPageState.locationsall[index].id.toString();
                  final numer1 = "J${numer.padLeft(4, '0')}";
                  return pw.Row(children: [
                   pw.Container(
                        decoration: pw.BoxDecoration(
                          border: pw.Border.all(
                            color: PdfColors.black,
                            width: 1, // عرض الحدود
                          ),
                        ),
                        child: pw.Container(
                          margin: pw.EdgeInsets.only(left: 0.5),
                          child: pw.SizedBox(
                              width: 44,
                              height: 20,
                              child: pw.Center(
                                child: pw.Text(
                                  numer1,style: pw.TextStyle(font: ttf)
                                ),
                              )),
                        ),
                      ),

                   pw.Container(
                        decoration: pw.BoxDecoration(
                          border: pw.Border.all(
                            color: PdfColors.black,
                            width: 1, // عرض الحدود
                          ),
                        ),
                        child: pw.Container(
                          margin: pw.EdgeInsets.only(left: 0.5),
                          child: pw.SizedBox(
                              width: 130,
                              height: 20,
                              child: pw.Text(name,style: pw.TextStyle(font: ttf), maxLines: 1)),
                        ),
                      ),
                    pw.ListView.builder(
                        direction: pw.Axis.horizontal,
                        itemCount: DashboardPageState.days,
                        itemBuilder: (context, dayIndex) {
                          final day1 =
                          (dayIndex + 1).toString().padLeft(2, '0');
                          final day = (dayIndex + 1).toString();
//smoothisis
                          final targetSiteNumber = int.parse(numer);
                          //  final num = int.parse(total);
                          final guardCount =
                          getGuardCount(day1, targetSiteNumber);

                          return pw.Container(
                            decoration: pw.BoxDecoration(
                              border: pw.Border.all(
                                color: PdfColors.black,
                                width: 1, // عرض الحدود
                              ),
                            ),
                            child: pw.Container(
                              color:  getGuardCountColor(guardCount, int.parse(num)),
                              // تعيين Padding إلى صفر
                              margin: pw.EdgeInsets.only(left: 0.5),

                              child: pw.SizedBox(
                                width: 20,
                                height: 20,
                                // تحديد عرض العنصر حسب احتياجاتك
                                child: pw.Center(
                                    child: pw.Text(guardCount.toString(),style: pw.TextStyle(font: ttf))),
                              ),
                            ),
                          );
                        }),
                  ]);
                }),
          ),

      ]),
    );


buildPrintableDataDetales(ttf ,idess, locations, indix1)
=> pw.Padding(
  padding: const pw.EdgeInsets.all(13.00),
  child: pw.Column(children: [
    pw.Row(children: [
      //pw.Image(logo, width: 40, height: 40),
      pw.Container(
          width: 800,
          child: pw.Center(
            // style: pw.TextStyle(font: ttf, fontSize: 24)
              child: pw.Text(
                "details of  ${DashboardPageState.locationsall[indix1].name}   ${DashboardPageState.selectedMonthIndex}/ ${DashboardPageState.Years}",
                style: pw.TextStyle(
                    fontSize: 16,font: ttf
                ),
              )))
    ]),
    pw.SizedBox(width: 5, height: 5),
    pw.Row(children: [
      pw.Expanded(
        flex: 0,
        child: pw.Container(
          decoration: pw.BoxDecoration(
            color: PdfColors.orangeAccent,
            border: pw.Border.all(
              color: PdfColors.black,
              width: 1, // عرض الحدود
            ),
          ),
          child: pw.Container(
            margin: pw.EdgeInsets.only(left: 0.5),
            child: pw.SizedBox(
                width: 44,
                height: 20,
                child: pw.Center(child: pw.Text("ID",
                    style: pw.TextStyle(font: ttf)))),
          ),
        ),
      ),
      pw.Expanded(
        flex: 0,
        child: pw.Container(
          decoration: pw.BoxDecoration(
            color: PdfColors.orangeAccent,
            border: pw.Border.all(
              color: PdfColors.black,
              width: 1, // عرض الحدود
            ),
          ),
          child: pw.Container(
            margin: pw.EdgeInsets.only(left: 0.5),
            child: pw.SizedBox(
                width: 130,
                height: 20,
                child: pw.Center(child: pw.Text("Name",style: pw.TextStyle(font: ttf)))),
          ),
        ),
      ),
      pw.ListView.builder(
          direction: pw.Axis.horizontal,
          itemCount: DashboardPageState.days,
          itemBuilder: (context, dayIndex) {
            final day = (dayIndex + 1).toString();

            return pw.Container(
              decoration: pw.BoxDecoration(
                color: PdfColors.orangeAccent,
                border: pw.Border.all(
                  color: PdfColors.black,
                  width: 1, // عرض الحدود
                ),
              ),
              child: pw.Container(
                // تعيين Padding إلى صفر
                margin: pw.EdgeInsets.only(left: 0.5),

                child: pw.SizedBox(
                  width: 20,
                  height: 20,
                  // تحديد عرض العنصر حسب احتياجاتك
                  child: pw.Center(child: pw.Text(day,style: pw.TextStyle(font: ttf))),
                ),
              ),
            );
          }),
    ]),


//27
    pw.SizedBox(
      height: (idess.length.toInt())*20,

      child:
      pw.ListView.builder(
          direction: pw.Axis.vertical,
          itemCount: idess.length,
          itemBuilder: (context, index) {
      var id= idess[index].toString();


final List<int> dyas1aa=[];
for(int day =1;day<DashboardPageState.days;day++){
  int idhave=0;
 // print(day.toString()+"ttttttt");
  try{
final record3 = DashboardPageState.record3.firstWhere((record3) {
return record3.job_no == int.parse(locations) &&
int.parse(record3.date.toString()) == (day ) &&
id == record3.id.toString();
});

idhave=day;
print(idhave.toString()+"ttttttt");

}catch(e){

//  print(idhave.toString()+"ttttttt");
}
if(idhave!=0){
  dyas1aa.add(idhave);
}


}
int day2=0;

  if(dyas1aa.length!=0){
    for(var a in idess){

      for(int day  in dyas1aa){

        try{

        final record = DashboardPageState.record.firstWhere((record) {
          return record.job_no == int.parse(locations) &&
              int.parse(record.date.toString()) == (day ) &&
              a == record.id.toString();
        });
      //oooooooooooo
}catch(e){
if(a!=0){
  print(a.toString()+"$day FFFFFF");
}




}
      }
            }
            }

          var name= DashboardPageState.Guard_Data[idess[index]].NAME_EN .toString();
            return pw.Row(children: [
              pw.Container(
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(
                    color: PdfColors.black,
                    width: 1, // عرض الحدود
                  ),
                ),
                child: pw.Container(
                  margin: pw.EdgeInsets.only(left: 0.5),
                  child: pw.SizedBox(
                      width: 44,
                      height: 20,
                      child: pw.Center(
                        child: pw.Text(
                            id,style: pw.TextStyle(font: ttf)
                        ),
                      )),
                ),
              ),

              pw.Container(
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(
                    color: PdfColors.black,
                    width: 1, // عرض الحدود
                  ),
                ),
                child: pw.Container(
                  margin: pw.EdgeInsets.only(left: 0.5),
                  child: pw.SizedBox(
                      width: 130,
                      height: 20,
                      child: pw.Text(name,style: pw.TextStyle(font: ttf,), maxLines: 1)),
                ),
              ),

              pw.ListView.builder(
                  direction: pw.Axis.horizontal,
                  itemCount: DashboardPageState.days,
                  itemBuilder: (context, dayIndex) {
                    var duty = 0;

                    try {
                      final record = DashboardPageState.record.firstWhere((record) {
                        return record.job_no == int.parse(locations) &&
                            int.parse(record.date.toString()) == (dayIndex + 1) &&
                            id == record.id.toString();
                      });

                      duty = 12;
                    } catch (e) {
                      // إذا لم يتم العثور على تطابق، duty سيبقى 0
                    }

                    try {
                      final record3 = DashboardPageState.record3.firstWhere((record3) {
                        return record3.job_no == int.parse(locations) &&
                            int.parse(record3.date.toString()) == (dayIndex + 1) &&
                            id == record3.id.toString();
                      });

                      duty = duty+12;
                    } catch (e) {
                      // إذا لم يتم العثور على تطابق، duty سيبقى 0
                    }
                    return pw.Container(
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(
                          color: PdfColors.black,
                          width: 1, // عرض الحدود
                        ),
                      ),
                      child: pw.Container(
                        // تعيين Padding إلى صفر
                        margin: pw.EdgeInsets.only(left: 0.5),
                        color: DashboardPageState.isChecked
                            ? duty == 12
                            ? PdfColors.green
                            : duty==24?PdfColors.deepOrange:PdfColors.white
                            : PdfColors.white,
                        child: pw.SizedBox(
                          width: 20,
                          height: 20,
                          // تحديد عرض العنصر حسب احتياجاتك
                          child: pw.Center(
                              child: pw.Text(duty.toString(),style: pw.TextStyle(font: ttf))),
                        ),
                      ),
                    );
                  }),

            ]);
          }),
          ),




    pw.SizedBox(
      height: 20,

      child:
      pw.ListView.builder(
          direction: pw.Axis.vertical,
          itemCount: idess.length,
          itemBuilder: (context, index) {

            var name="Total";
            return pw.Row(children: [
              pw.Container(
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(
                    color: PdfColors.black,
                    width: 1, // عرض الحدود
                  ),
                ),
                child: pw.Container(
                  margin: pw.EdgeInsets.only(left: 0.5),
                  child: pw.SizedBox(
                      width: 44,
                      height: 20,
                      child: pw.Center(
                        child: pw.Text(
                            "",style: pw.TextStyle(font: ttf)
                        ),
                      )),
                ),
              ),

              pw.Container(
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(
                    color: PdfColors.black,
                    width: 1, // عرض الحدود
                  ),
                ),
                child: pw.Container(
                  margin: pw.EdgeInsets.only(left: 0.5),
                  child: pw.SizedBox(
                      width: 130,
                      height: 20,
                      child: pw.Text(name,style: pw.TextStyle(font: ttf,), maxLines: 1)),
                ),
              ),

              pw.ListView.builder(
                  direction: pw.Axis.horizontal,
                  itemCount: DashboardPageState.days,
                  itemBuilder: (context, dayIndex) {
                    final day1 =
                    (dayIndex + 1).toString().padLeft(2, '0');
                    final day = (dayIndex + 1).toString();
//smoothisis
                    final targetSiteNumber = int.parse(locations);
                    final num = DashboardPageState.locationsall[indix1].tolal.toString();
                    //  final num = int.parse(total);
                    final guardCount =
                    getGuardCount(day1, targetSiteNumber);

                    return pw.Container(
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(
                          color: PdfColors.black,
                          width: 1, // عرض الحدود
                        ),
                      ),
                      child: pw.Container(
                        // تعيين Padding إلى صفر
                        margin: pw.EdgeInsets.only(left: 0.5),
                        color:  getGuardCountColor(guardCount, int.parse(num)),

                        child: pw.SizedBox(
                          width: 20,
                          height: 20,
                          // تحديد عرض العنصر حسب احتياجاتك
                          child: pw.Center(
                              child: pw.Text(guardCount.toString(),style: pw.TextStyle(font: ttf))),
                        ),
                      ),
                    );
                  }),
            ]);
          }),
    ),


  ]),
);



int getGuardCount(String day, int targetSiteNumber) {
  return DashboardPageState.attendanceData.values.where((attendance) {

    return  attendance.length > 1 ?attendance[1]['date'] == day &&
        attendance[1]['job_no'] == targetSiteNumber:false;



  }).length+ DashboardPageState.attendanceData.values.where((attendance) {

    return  attendance[0]['date'] == day &&
        attendance[0]['job_no'] == targetSiteNumber;



  }).length ;

}

PdfColor getGuardCountColor(int guardCount, int num) {
  if (DashboardPageState.isChecked) {
    if (guardCount == 0) {
      return PdfColors.white;
    } else if (guardCount < num) {
      return PdfColors.amberAccent;
    } else if (guardCount > num) {
      return PdfColors.red;
    } else {
      return PdfColors.white;
    }
  } else {
    return PdfColors.white;
  }
}
int getIndexById(int id) {
  return DashboardPageState.locationsall.indexWhere((location) => location.id == id);
}
