import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wee_made/layouts/provider_layout/provider_cubit/provider_cubit.dart';
import 'package:wee_made/layouts/provider_layout/provider_cubit/provider_states.dart';
import 'package:wee_made/models/provider/statistics_model.dart';

class Charts extends StatelessWidget {
  Charts({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProviderCubit, ProviderStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tr('top_sales'),
              style: TextStyle(color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 118,
              child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(),

                  legend: Legend(isVisible: true),
                  // Enable tooltip
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <ChartSeries<Data, String>>[
                    LineSeries<Data, String>(
                        dataSource: ProviderCubit.get(context).statisticsModel!.data!,
                        xValueMapper: (Data sales, _) => sales.month,
                        yValueMapper: (Data sales, _) => sales.value,
                        name: tr('sales'),
                        // Enable data label
                        dataLabelSettings: DataLabelSettings(isVisible: true)
                    )
                  ]
              ),
            ),
          ],
        );
      },
    );
  }
}
