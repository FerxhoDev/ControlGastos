import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gestapp/models/expense_data.dart';
import 'package:gestapp/provider/transaction_provider.dart';
import 'package:provider/provider.dart';


class LineChartSample2 extends StatelessWidget {

  LineChartSample2({super.key,});

  List<Color> gradientColors = [
    const Color(0xFF50E4FF),
    const Color(0xFF2196F3),
  ];

  List<FlSpot> generateFlSpots(List<ExpenseData> data) {
    return List<FlSpot>.generate(
      data.length,
      (index) => FlSpot(index.toDouble(), data[index].amount),
    );
  }

  @override
  
  Widget build(BuildContext context) {

    return Consumer<TransactionProvider>(
      builder: (context, transactionProvider, child) {
        final expenses = transactionProvider.getExpenseData();
        return _buildChart(expenses);
      },
    );
  }

  Widget _buildChart(List<ExpenseData> expenses) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.70,
          child: Padding(
            padding: const EdgeInsets.only(
              right: 18,
              left: 12,
              top: 24,
              bottom: 12,
            ),
            child: LineChart(
              mainData(expenses),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData mainData(List<ExpenseData> data) {
    double maxExpense = data.isNotEmpty
        ? data.map((e) => e.amount).reduce((a, b) => a > b ? a : b)
        : 0;
    double maxY = maxExpense + (maxExpense * 0.1); // Añade un 10% como margen
    // Asegúrate de que maxY nunca sea cero
    maxY = maxY > 0 ? maxY : 100;
  
    // Calcula el intervalo y asegúrate de que nunca sea cero
    double interval = (maxY / 5).ceilToDouble();
    interval = interval > 0 ? interval : 20;

    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: interval,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Colors.white10,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Colors.white10,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: (value, meta) {
              if (value.toInt() >= 0 && value.toInt() < data.length) {
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  child: Text(
                    data[value.toInt()].category,
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: interval,
            getTitlesWidget: (value, meta) {
              String formattedValue;
              if (value >= 1000) {
                formattedValue = (value / 1000).toStringAsFixed(1) + 'k';
              } else {
                formattedValue = value.toStringAsFixed(0);
              }
              return Text(
                formattedValue,
                style: const TextStyle(color: Colors.white),
              );
            },
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: data.length.toDouble() - 1,
      minY: 0,
      maxY: maxY,
      lineBarsData: [
        LineChartBarData(
          spots: generateFlSpots(data),
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
