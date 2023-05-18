import 'package:flutter/material.dart';
import 'package:money_fi/models/category/category_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../models/transaction/transaction_model.dart';
import '../overAll/graph_over_view.dart';

class IncomeChart extends StatefulWidget {
  const IncomeChart({super.key});

  @override
  State<IncomeChart> createState() => _IncomeChartState();
}

class _IncomeChartState extends State<IncomeChart> {
  late TooltipBehavior _tooltipBehavior;
  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(230, 72, 151, 148),
        body: ValueListenableBuilder(
          valueListenable: overViewGraphNotifier,
          builder: (BuildContext context, List<TransactionModel> newList,
              Widget? child) {
            var allIncome = newList
                .where((element) => element.type == CategoryType.income)
                .toList();
            return overViewGraphNotifier.value.isEmpty
                ? SizedBox(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Text(
                            'No Data Found!!',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.red,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                : SfCircularChart(
                    tooltipBehavior: _tooltipBehavior,
                    series: <CircularSeries>[
                      DoughnutSeries<TransactionModel, String>(
                        enableTooltip: true,
                        dataSource: allIncome,
                        xValueMapper: (TransactionModel incomeDate, _) =>
                            incomeDate.category.name,
                        yValueMapper: (TransactionModel incomeDate, _) =>
                            incomeDate.amount,
                        dataLabelSettings: const DataLabelSettings(
                          isVisible: true,
                          labelIntersectAction: LabelIntersectAction.none,
                          textStyle: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                    legend: Legend(
                      isVisible: true,
                      overflowMode: LegendItemOverflowMode.wrap,
                      alignment: ChartAlignment.center,
                    ),
                  );
          },
        ),
      ),
    );
  }
}
