import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'controller/dashboard_controller.dart';

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
                    "Summary Attendance Sheet of ${DashboardController.selectedMonthIndex}  ${DashboardController.Years}",
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
              itemCount: DashboardController.days,
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
            height: DashboardController.locationsall.length*20,

            child:
            pw.ListView.builder(
                direction: pw.Axis.vertical,
                itemCount: DashboardController.locationsall.length,
                itemBuilder: (context, index) {
                  final name =
                  DashboardController.locationsall[index].name.toString();
                 final num= DashboardController.locationsall[index].tolal.toString();
                  final numer =
                  DashboardController.locationsall[index].id.toString();
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
                              child:pw.Align(
                  alignment: pw.Alignment.centerLeft,
                  child: pw.Text(" $name",style: pw.TextStyle(font: ttf), maxLines: 1))),
                        ),
                      ),
                    pw.ListView.builder(
                        direction: pw.Axis.horizontal,
                        itemCount: DashboardController.days,
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
      pw.SizedBox(width: 50, height: 50),
      //pw.Image(logo, width: 40, height: 40),
      pw.Container(
          width:  351.5+DashboardController.days*12.5-0.5,
          child: pw.Center(
            // style: pw.TextStyle(font: ttf, fontSize: 24)
              child: pw.Text(
                "Operation Department ",
                style: pw.TextStyle(
                    fontSize: 22,font: ttf,fontWeight: pw.FontWeight.bold
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
            width: 351.5+DashboardController.days*14.5,
            height: 17,
            child: pw.Center(child: pw.Text("${DashboardController.locationsall[indix1].name} Attendance ${DashboardController.months[DashboardController.selectedMonthIndex]} - ${DashboardController.Years} ",
                style: pw.TextStyle(font: ttf,fontWeight: pw.FontWeight.bold)))),
      ),
    ),
  ),
  ]),
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
                width: 25,
                height: 12,
                child: pw.Center(child: pw.Text("SI No",
                    style: pw.TextStyle(font: ttf,fontSize:9)))),
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
                width: 150,
                height: 12,
                child: pw.Center(child: pw.Text("Location",
                    style: pw.TextStyle(font: ttf,fontSize:9)))),
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
                width: 25,
                height: 12,
                child: pw.Center(child: pw.Text("ID No",
                    style: pw.TextStyle(font: ttf,fontSize:9)))),
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
                width: 150,
                height: 12,
                child: pw.Center(child: pw.Text("Name",style: pw.TextStyle(font: ttf,fontSize:9)))),
          ),
        ),
      ),


      pw.ListView.builder(
          direction: pw.Axis.horizontal,
          itemCount: DashboardController.days,
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
                  width: 14,
                  height: 12,
                  // تحديد عرض العنصر حسب احتياجاتك
                  child: pw.Center(child: pw.Text(day,style: pw.TextStyle(font: ttf,fontSize:9))),
                ),
              ),
            );
          }),
    ]),


//27
   pw.Row(
     children: [

       pw.SizedBox(
         height: (idess.length.toInt())*12,

         child:
         pw.ListView.builder(
             direction: pw.Axis.vertical,
             itemCount: idess.length,
             itemBuilder: (context, index) {

               var si=index+1;

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
                         width: 25,
                         height: 12,
                         child: pw.Center(
                           child: pw.Text(
                               si.toString(),style: pw.TextStyle(font: ttf,fontSize:9)
                           ),
                         )),
                   ),
                 ),



               ]);
             }),
       ),
       pw.Container(
         decoration: pw.BoxDecoration(
           border: pw.Border(
             top: pw.BorderSide(width: 1.0, color: PdfColors.black),
             left: pw.BorderSide(width: 1.0, color: PdfColors.black),
             right: pw.BorderSide(width: 1.0, color: PdfColors.black),
             // Add borders for other sides as needed
           ),

         ),
         child: pw.Container(
             margin: pw.EdgeInsets.only(left: 0.5),
             child: pw.SizedBox(
               width: 150 ,
               height:idess.length*12,
               child: pw.Center(child:pw.Text(DashboardController.locationsall[indix1].name.toString(),style: pw.TextStyle(font: ttf,fontSize:9), maxLines: 1)),
             )  ),
       ),

       pw.SizedBox(
         height: (idess.length.toInt())*12,

         child:
         pw.ListView.builder(
             direction: pw.Axis.vertical,
             itemCount: idess.length,
             itemBuilder: (context, index) {
               var id= idess[index].toString();

               var name= DashboardController.Guard_Data[idess[index]].NAME_EN .toString();
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
                         width: 25,
                         height: 12,
                         child: pw.Center(
                             child: pw.Text(id,style: pw.TextStyle(font: ttf,fontSize:9), maxLines: 1))),
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
                         width: 150,
                         height: 12,
                         child: pw.Text(" $name",style: pw.TextStyle(font: ttf,fontSize:9), maxLines: 1)),
                   ),
                 ),

                 pw.ListView.builder(
                     direction: pw.Axis.horizontal,
                     itemCount: DashboardController.days,
                     itemBuilder: (context, dayIndex) {
                       var duty = 0;

                       try {
                         final record = DashboardController.record.firstWhere((record) {
                           return record.job_no == int.parse(locations) &&
                               int.parse(record.date.toString()) == (dayIndex + 1) &&
                               id == record.id.toString();
                         });

                         duty = 1;
                       } catch (e) {
                         // إذا لم يتم العثور على تطابق، duty سيبقى 0
                       }

                       try {
                         final record3 = DashboardController.record3.firstWhere((record3) {
                           return record3.job_no == int.parse(locations) &&
                               int.parse(record3.date.toString()) == (dayIndex + 1) &&
                               id == record3.id.toString();
                         });

                         duty = duty+1;
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

                           color: DashboardController.isChecked
                               ? duty == 0
                               ?PdfColor.fromHex("#f7fff6")
                               : PdfColors.white:PdfColors.white,

                           child: pw.SizedBox(
                             width: 14,
                             height: 12,
                             // تحديد عرض العنصر حسب احتياجاتك
                             child: pw.Center(
                                 child: pw.Text(duty==0?"":duty.toString(),style: pw.TextStyle(font: ttf,fontSize:9))),
                           ),
                         ),
                       );
                     }),

               ]);
             }),
       ),

     ]
   ),




    pw.SizedBox(
      height: 12,

      child:
      pw.ListView.builder(
          direction: pw.Axis.vertical,
          itemCount: idess.length,
          itemBuilder: (context, index) {

            var name="Grand Total";
            return pw.Row(children: [


              pw.Container(

                decoration: pw.BoxDecoration(
                  border: pw.Border.all(
                    color: PdfColors.black,
                    width: 1, // عرض الحدود
                  ),
                ),
                child: pw.Container(

                  color: PdfColors.yellow,
                  child: pw.Container(

                      width: 351.5,
                      height: 12,
                      margin: pw.EdgeInsets.only(left: 0.5),
                      child: pw.Center(

            child: pw.Text(name,style: pw.TextStyle(font: ttf,fontSize:9), maxLines: 1))),
                ),
              ),

              pw.ListView.builder(
                  direction: pw.Axis.horizontal,
                  itemCount: DashboardController.days,
                  itemBuilder: (context, dayIndex) {
                    final day1 =
                    (dayIndex + 1).toString().padLeft(2, '0');
                    final day = (dayIndex + 1).toString();
//smoothisis
                    final targetSiteNumber = int.parse(locations);
                    final num = DashboardController.locationsall[indix1].tolal.toString();
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
                    decoration: pw.BoxDecoration(
                    color: PdfColors.orangeAccent,
                    border: pw.Border.all(
                    color: PdfColors.black,
                    width: 1, // عرض الحدود
                    ),
                    ),
                    child:  pw.Container(
                        // تعيين Padding إلى صفر
                        margin: pw.EdgeInsets.only(left: 0.5),
                        color:  getGuardCountColor(guardCount, int.parse(num)),

                        child: pw.SizedBox(
                          width: 14,
                          height: 12,
                          // تحديد عرض العنصر حسب احتياجاتك
                          child: pw.Center(
                              child: pw.Text(guardCount.toString(),style: pw.TextStyle(font: ttf,fontSize:9))),
                        ),
                      ), ),
                    );
                  }),
            ]);
          }),
    ),

pw.SizedBox(
  width: 20,
  height: 20
),


   pw.Container(
     width:double.maxFinite,
     child: pw.Center(

       child:  pw.Row(
           children: [
          pw.Expanded(flex: 1,
            child:    pw.Column(

              children: [
                pw.Container(child: pw.Text("Operation Coordinator     ",style: pw.TextStyle(font: ttf)),),
                pw.SizedBox(
                    width: 25,
                    height: 25
                ),
                pw.Container(child:    pw.Text("Approved By : Mr. Abdul Jabbar     Sign : ______________",style: pw.TextStyle(font: ttf)),),
              ]
          ),),
             pw.Expanded(
               flex: 1,
               child:    pw.Column(
                 children: [
                   pw.Container(child: pw.Text("Operation Manager        ",style: pw.TextStyle(font: ttf)),),
                   pw.SizedBox(
                       width: 25,
                       height: 25
                   ),
                   pw.Container(child:  pw.Text("Approved By : Mr. Shukri Mahmood  Sign : ______________",style: pw.TextStyle(font: ttf)),),
                 ]
             ),),


           ]


       ),
     )
   )
  ]),
);


PrintAtendencsheet(ttf) => pw.Padding(
  padding: const pw.EdgeInsets.all(13.00),
  child: pw.Column(children: [
    pw.Row(children: [
      //pw.Image(logo, width: 40, height: 40),
      pw.Container(
          width: 800,
          child: pw.Center(
            // style: pw.TextStyle(font: ttf, fontSize: 24)
              child: pw.Text(
                "Summary Attendance Sheet of ${DashboardController.selectedMonthIndex}  ${DashboardController.Years}",
                style: pw.TextStyle(
                    fontSize: 16,font: ttf
                ),
              )))
    ]),


pw.Center(
  child: pw.Container(
    padding: pw.EdgeInsets.fromLTRB(40,0,40,0),
    child: pw.Column(
        children: [
          pw.Container(
              child: pw.Row(children: [


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
                          width: 70,
                          height: 30,
                          child: pw.Center(child: pw.Text("SI No",
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
                          width: 70,
                          height: 30,
                          child: pw.Center(child: pw.Text("ID No",
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
                          width: 200,
                          height: 30,
                          child: pw.Center(child: pw.Text("Name",style: pw.TextStyle(font: ttf)))),
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
                          width: 120,
                          height: 30,
                          child: pw.Center(child: pw.Text("signature",style: pw.TextStyle(font: ttf)))),
                    ),
                  ),
                ),

              ])
          ),



//27
          pw.Container(
            child: pw.SizedBox(
              height: 10*30,
              child: pw.ListView.builder(
                  direction: pw.Axis.vertical,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    var index1=index+1;
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
                              width: 70,
                              height: 30,
                              child: pw.Center(
                                child: pw.Text(
                                    index1.toString(),style: pw.TextStyle(font: ttf)
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
                              width: 70,
                              height: 30,
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
                              width: 200,
                              height: 30,
                              child:pw.Align(
                                  alignment: pw.Alignment.centerLeft,
                                  child: pw.Text("",style: pw.TextStyle(font: ttf), maxLines: 1))),
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
                              width: 120,
                              height: 30,
                              child: pw.Center(
                                child: pw.Text(
                                   "",style: pw.TextStyle(font: ttf)
                                ),
                              )),
                        ),
                      ),

                    ]);
                  }),
            ),
          ),
        ]
    ),
  )
)
  ]),
);



int getGuardCount(String day, int targetSiteNumber) {
  return DashboardController.attendanceData.values.where((attendance) {

    return  attendance.length > 1 ?attendance[1]['date'] == day &&
        attendance[1]['job_no'] == targetSiteNumber:false;



  }).length+ DashboardController.attendanceData.values.where((attendance) {

    return  attendance[0]['date'] == day &&
        attendance[0]['job_no'] == targetSiteNumber;



  }).length ;

}

PdfColor getGuardCountColor(int guardCount, int num) {
  if (DashboardController.isChecked) {
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
  return DashboardController.locationsall.indexWhere((location) => location.id == id);
}
