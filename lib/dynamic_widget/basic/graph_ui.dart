//
// import '../../dynamic_widget.dart';
// import 'package:flutter/widgets.dart';
// import '../../g.dart' as g;
// import 'package:flutter/material.dart';
// //import 'package:charts_flutter/flutter.dart' as charts;
//
// class graph_uiParser extends WidgetParser {
//
//   final List<String> dtag;
//   graph_uiParser(this.dtag);
//
//   @override
//   Widget parse(Map<String, dynamic> m, BuildContext buildContext,
//       ClickListener listener) {
//
//     m["skey"]= dtag[0];
//     return graph_uiex(buildContext,m);
//   }
//
//   @override
//   String get widgetName => "graphui";
// }
//
//
// class graph_uiex extends StatefulWidget {
//   final BuildContext _buildContext;
//   final  Map<String, dynamic> m;
//   graph_uiex( this._buildContext, this.m);
//   @override
//   graph_uiexState createState() => graph_uiexState();
//
// }
// class graph_uiexState  extends State<graph_uiex> {
//
//
//
//   graph_uiexState();
//
//
//
//
//    List<charts.Series> seriesList;
//    bool animate;
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     seriesList=_createSampleData();
//
//
//     return  new charts.LineChart(
//       seriesList,
//       animate: animate,
//      // barRendererDecorator: new charts.BarLabelDecorator<String>(),
//       /// Assign a custom style for the domain axis.
//       ///
//       /// This is an OrdinalAxisSpec to match up with BarChart's default
//       /// ordinal domain axis (use NumericAxisSpec or DateTimeAxisSpec for
//       /// other charts).
//       domainAxis: new charts.OrdinalAxisSpec(
//           renderSpec: new charts.SmallTickRendererSpec(
//
//             // Tick and Label styling here.
//               labelStyle: new charts.TextStyleSpec(
//                   fontSize: 18, // size in Pts.
//                   color: charts.MaterialPalette.black),
//
//               // Change the line colors to match text color.
//               lineStyle: new charts.LineStyleSpec(
//                   color: charts.MaterialPalette.black))),
//
//       /// Assign a custom style for the measure axis.
//       primaryMeasureAxis: new charts.NumericAxisSpec(
//           renderSpec: new charts.GridlineRendererSpec(
//
//             // Tick and Label styling here.
//               labelStyle: new charts.TextStyleSpec(
//                   fontSize: 18, // size in Pts.
//                   color: charts.MaterialPalette.black),
//
//               // Change the line colors to match text color.
//               lineStyle: new charts.LineStyleSpec(
//                   color: charts.MaterialPalette.black))),
//     );
//
//
//
//   }
//
//   /// Create one series with sample hard coded data.
//   static List<charts.Series<OrdinalSales, String>> _createSampleData() {
//     final globalSalesData = [
//       new OrdinalSales('A', 100),
//       new OrdinalSales('B', 200),
//       new OrdinalSales('C', 300),
//       new OrdinalSales('X', 400),
//     ];
//
//     return [
//       new charts.Series<OrdinalSales, String>(
//         id: 'Global Revenue',
//         domainFn: (OrdinalSales sales, _) => sales.year,
//         measureFn: (OrdinalSales sales, _) => sales.sales,
//         labelAccessorFn: (OrdinalSales sales, _) =>
//         '\$${sales.sales.toString()}',
//         data: globalSalesData,
//       ),
//     ];
//   }
//
//
// }
// class OrdinalSales {
//   final String year;
//   final int sales;
//
//   OrdinalSales(this.year, this.sales);
// }