import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gestapp/models/expense_data.dart';

class LineChartSample2 extends StatefulWidget {
  final List<ExpenseData> expenses;
  const LineChartSample2({super.key, required this.expenses});

  @override
  State<LineChartSample2> createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
  List<Color> gradientColors = [
    const Color(0xFF50E4FF),
    const Color(0xFF2196F3),
  ];

  bool showAvg = false;

  List<FlSpot> generateFlSpots(List<ExpenseData> data) {
    return List<FlSpot>.generate(
      data.length,
      (index) => FlSpot(index.toDouble(), data[index].amount),
    );
  }

  @override
  Widget build(BuildContext context) {
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
              mainData(widget.expenses),
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
    double interval = (maxY / 5).ceilToDouble(); // Ajusta a 5 divisiones

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
