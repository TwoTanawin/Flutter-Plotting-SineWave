import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController vController = TextEditingController();
  TextEditingController fController = TextEditingController();

  List<FlSpot> chartData = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sine Wave Chart App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildLineChart(),
            SizedBox(height: 20),
            _buildInputFields(),
            SizedBox(height: 20),
            _buildButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildLineChart() {
    return SizedBox(
      height: 300,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(show: false),
          borderData: FlBorderData(show: true),
          minX: 0,
          maxX: 0.02,
          minY: -(double.tryParse(fController.text) ?? 0.0),
          maxY: double.tryParse(fController.text) ?? 0.0,
          lineBarsData: [
            LineChartBarData(
              spots: chartData,
              isCurved: true,
              colors: [Colors.blue],
              dotData: FlDotData(show: false),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputFields() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: vController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'v'),
          ),
        ),
        SizedBox(width: 20),
        Expanded(
          child: TextField(
            controller: fController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'f'),
          ),
        ),
      ],
    );
  }

  Widget _buildButtons() {
    return Row(
      children: [
        ElevatedButton(
          onPressed: () {
            _addSineWaveData();
          },
          child: Text('Add Sine Wave'),
        ),
        SizedBox(width: 20),
        ElevatedButton(
          onPressed: () {
            _clearData();
          },
          child: Text('Clear Data'),
        ),
      ],
    );
  }

  void _addSineWaveData() {
    double v = double.tryParse(vController.text) ?? 1.0;
    double f = double.tryParse(fController.text) ?? 1.0;

    setState(() {
      chartData.clear();
      // for (double t = 0; t <= 2 * pi; t += 0.1) {
      //   double y = v * sin(2 * pi * f * t);
      //   chartData.add(FlSpot(t, y));
      // }
      double t = 0;
      double dt = ((1 / f) / 360);
      for (int i = 0; i <= 360; i++) {
        double y = v * sin(2 * pi * f * t);
        chartData.add(FlSpot(t, y));
        t = t + dt;
      }
    });
  }

  void _clearData() {
    setState(() {
      chartData.clear();
    });
  }
}
