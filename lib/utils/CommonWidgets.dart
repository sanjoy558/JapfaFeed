
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japfa_feed_application/responses/GraphDataResponse.dart';
import 'package:japfa_feed_application/responses/GraphDataResponse1.dart';
import 'package:japfa_feed_application/utils/Constants.dart';
import 'package:japfa_feed_application/utils/Constants.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'Constants.dart';


/*Widget stackDisplay(GraphData1 graphData,List<GraphData1> graplist){
  return Container(
    child:SfCartesianChart(
      primaryXAxis: CategoryAxis(
        interval: 1
      ),
     *//* primaryXAxis: NumericAxis(
        //Hide the gridlines of x-axis
        majorGridLines: MajorGridLines(width: 0),
        //Hide the axis line of x-axis
        axisLine: AxisLine(width: 0),
      ),
*//*
      primaryYAxis: NumericAxis(
        isVisible: false,
        //Hide the gridlines of y-axis
          majorGridLines: MajorGridLines(width: 0),
          //Hide the axis line of y-axis
          axisLine: AxisLine(width: 0)
      ),
      legend: Legend(isVisible: true,
      position: LegendPosition.bottom),
      enableAxisAnimation: true,
      zoomPanBehavior: ZoomPanBehavior(enablePinching: true),
      series: <ChartSeries>[

        StackedColumnSeries<GraphData1, String>(
          name: "Achived",
          dataLabelSettings: DataLabelSettings(
              isVisible: true,
              useSeriesColor: true,
              textStyle: TextStyle(color: Colors.white)
          ),
          *//*dataLabelSettings: DataLabelSettings(isVisible:true, showCumulativeValues: true,textStyle: TextStyle(color: Colors.black)),*//*
          color: Colors.green,
          borderRadius: BorderRadius.circular(7), // Set corner radius
          width: 0.2, // Set the width of the bar chart
          dataSource: graplist,
          xValueMapper: (GraphData1 ch, _) => ch.month.toString(),
          yValueMapper: (GraphData1 ch, _) => ch.achived,
        ),

        StackedColumnSeries<GraphData1, String>(
          name: "OverAchived",
          dataLabelSettings: DataLabelSettings(
              isVisible: true,
              useSeriesColor: true,
              textStyle: TextStyle(color: Colors.black)
          ),
          *//*dataLabelSettings: DataLabelSettings(isVisible:true, showCumulativeValues: true,textStyle: TextStyle(color: Colors.black)),*//*
          color: Colors.yellow,
          borderRadius: BorderRadius.circular(7), // Set corner radius
          width: 0.2, // Set the width of the bar chart
          dataSource: graplist,
          xValueMapper: (GraphData1 ch, _) => ch.month.toString(),
          yValueMapper: (GraphData1 ch, _) => ch.overachived,
        ),
        StackedColumnSeries<GraphData1, String>(
          name: "Pending",
          dataLabelSettings: DataLabelSettings(
              isVisible: true,
              useSeriesColor: true,
  textStyle: TextStyle(color: Colors.white)
          ),
          color: Colors.grey,
          *//*dataLabelSettings:DataLabelSettings(isVisible:true, showCumulativeValues: true,textStyle: TextStyle(color: Colors.black)),*//*
          borderRadius: BorderRadius.circular(7),

          width: 0.2,
          dataSource: graplist,
          xValueMapper: (GraphData1 ch, _) => ch.month.toString(),
          yValueMapper: (GraphData1 ch, _) => ch.pending,
        ),


      ],
    ) ,
  );
}*/

Widget noData(){
  return Container(
    /*decoration: BoxDecoration(
      gradient: LinearGradient(colors: [noDatacolor1, noDatacolor2],begin: Alignment.topRight,end: Alignment.topLeft)
    ),*/
    margin: EdgeInsets.all(10.0),
    padding: EdgeInsets.all(10.0),
    alignment: Alignment.center,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
     children: [
       Container(
         child:
         Icon(Icons.insert_page_break_outlined, color: Colors.grey,size: 40.0,)
         /*Image.asset(
           'assets/images/shipped.png',
           width: 40.0,
           height: 40.0,
           color: Colors.black,
         )*/,
       ),
       SizedBox(height: 10.0,),
       const Text(
         "No Data",
         textAlign: TextAlign.center,
         style: TextStyle(
             color: Colors.black,
             fontSize: 14.0,
             fontFamily: 'Popins',
             fontWeight: FontWeight.w600),
       ),

       SizedBox(height: 10.0,),
       const Text(
         "No Data Available",
         textAlign: TextAlign.center,
         style: TextStyle(
             color: Colors.black,
             fontSize: 14.0,
             fontFamily: 'Popins',
             fontWeight: FontWeight.w500),
       ),
       SizedBox(height: 10.0,),

     ],
    ),
  );
}

Widget progressBarCommon1(){
  return LoadingAnimationWidget.fourRotatingDots(color: Colors.redAccent, size: 80.0);
}

Widget progressBarCommon(){
  return Stack(
    children: [
      ModalBarrier(
        dismissible: false,
        color: Colors.black.withOpacity(0.1),
      ),
      Center(
      child: LoadingAnimationWidget.fourRotatingDots(color: Colors.redAccent, size: 80.0),
      )

    ],
  );
}

Widget noDataPurchaseOrder(){
  return Container(
    /*decoration: BoxDecoration(
        gradient: LinearGradient(colors: [noDatacolor1, noDatacolor2],begin: Alignment.topRight,end: Alignment.topLeft)
    ),*/
    margin: EdgeInsets.all(10.0),
    padding: EdgeInsets.all(10.0),
    alignment: Alignment.center,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          child:
          Icon(Icons.insert_page_break_outlined, color: Colors.grey,size: 40.0,)
          /*Image.asset(
           'assets/images/shipped.png',
           width: 40.0,
           height: 40.0,
           color: Colors.black,
         )*/,
        ),
        SizedBox(height: 10.0,),
        const Text(
          "No Data",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.black,
              fontSize: 14.0,
              fontFamily: 'Popins',
              fontWeight: FontWeight.w600),
        ),

        SizedBox(height: 10.0,),
        const Text(
          "No Data Available",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.black,
              fontSize: 14.0,
              fontFamily: 'Popins',
              fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 10.0,),

        Container(
          margin: EdgeInsets.only(right: 10.0,left: 10.0),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Today’s Order Not Available. For More Order Kindly Please Click On"
                  ,style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.0,
                    fontFamily: 'Popins',
                    fontWeight: FontWeight.w500),
                ),
                WidgetSpan(
                  child: Icon(Icons.filter_alt_rounded, size: 20,color: Colors.black,),
                ),
              ],
            ),
          ),
        ),
       /* const Text(
          "To see old data please select filter option.",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.black,
              fontSize: 14.0,
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.w500),
        ),
*/
      ],
    ),
  );
}


