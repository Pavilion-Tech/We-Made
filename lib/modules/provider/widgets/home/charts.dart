import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Charts extends StatelessWidget {
  Charts({Key? key}) : super(key: key);
  List<_SalesData> data = [
    _SalesData('Jan', 35),
    _SalesData('Feb', 28),
    _SalesData('Mar', 34),
    _SalesData('Apr', 32),
    _SalesData('May', 40)
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tr('top_sales'),
          style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 118,
          child:  SfCartesianChart(
              primaryXAxis: CategoryAxis(),

              legend: Legend(isVisible: true),
              // Enable tooltip
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <ChartSeries<_SalesData, String>>[
                LineSeries<_SalesData, String>(
                    dataSource: data,
                    xValueMapper: (_SalesData sales, _) => sales.year,
                    yValueMapper: (_SalesData sales, _) => sales.sales,
                    name: tr('sales'),
                    // Enable data label
                    dataLabelSettings: DataLabelSettings(isVisible: true)
                )
              ]
          ),
        ),
      ],
    );
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
