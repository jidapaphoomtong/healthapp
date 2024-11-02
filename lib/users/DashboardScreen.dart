import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:health/users/card.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:health/api_connection/api_connetion.dart';
import 'dart:async'; // Add this for Timer

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<dynamic> dashboardData = [];
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    fetchDashboardData();
    _startAutoRefresh(); // Start the auto-refresh
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  // Fetch data every 30 seconds
  void _startAutoRefresh() {
    _timer = Timer.periodic(Duration(seconds: 30), (timer) {
      fetchDashboardData(); // Fetch latest data
    });
  }

 Future<void> fetchDashboardData() async {
  try {
    final response = await http.get(Uri.parse(API.dashboard)).timeout(Duration(seconds: 10));
    if (response.statusCode == 200) {
      setState(() {
        // Ensure proper handling of null or missing values
        dashboardData = json.decode(response.body).map((item) {
          return {
            'u_id': item['u_id'] ?? 0,
            'bmi': item['bmi'] ?? 0.0,
            'fpg': item['fpg'] ?? 0.0,
            'sys': item['sys'] ?? 0.0,
            'dia': item['dia'] ?? 0.0,
            'date': item['date'] ?? 'N/A',
          };
        }).toList();
      });
    } else {
      print('Failed to load data: ${response.statusCode}');
    }
  } catch (e) {
    print('Error fetching data: $e');
  }
}



@override
Widget build(BuildContext context) {
  return SingleChildScrollView(
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 40.0, left: 16.0, right: 16.0, bottom: 16.0),
          color: Colors.blue,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Dashboard',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8,),
        
        // Check if dashboardData is not empty and display the latest data
// Check if dashboardData is not empty and display the latest data
if (dashboardData.isNotEmpty)
  Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Display latest pressure data (sys/dia)
          _buildSummaryCard("Pressure", "${dashboardData.last['sys']}/${dashboardData.last['dia']}", Colors.green),
          
          // Display latest BMI data - ensure it's converted to double
          _buildSummaryCard("BMI", _formatValueAsDouble(dashboardData.last['bmi']), Colors.lightBlue),
          
          // Display latest diabetes (FPG) data - ensure it's converted to double
          _buildSummaryCard("Diabetes", _formatValueAsDouble(dashboardData.last['fpg']), Colors.purple),
        ],
      ),
      SizedBox(height: 20),
      _buildLineChartCard("Pressure", Colors.red, Colors.blue),
      SizedBox(height: 20),
      _buildBarChartCard("BMI", Colors.lightBlue),
      SizedBox(height: 20),
      _buildBarChartCard("Diabetes", Colors.purple),
    ],
  )
else
  // Show a message if no data is available
  Center(
    child: Text('No data available'),
  ),
      ],
    ),
  );
}

  String _formatValueAsDouble(dynamic value) {
    try {
      double parsedValue = double.tryParse(value.toString()) ?? 0.0;
      return parsedValue.toStringAsFixed(2);
    } catch (e) {
      return "0.00";
    }
  }

  Widget _buildSummaryCard(String label, String value, Color color) {
    return Container(
      width: 100,
      height: 80,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            SizedBox(height: 5),
            Text(
              value,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBarChartCard(String label, Color color) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Container(
              height: 150,
              child: BarChart(
                BarChartData(
                  barGroups: _getBarGroups(color, label),
                  borderData: FlBorderData(show: false),
                  gridData: FlGridData(show: false),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLineChartCard(String label, Color sysColor, Color diaColor) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Container(
              height: 150,
              child: LineChart(
                LineChartData(
                  lineBarsData: [
                  // SYS Line
                  LineChartBarData(
                    spots: List.generate(dashboardData.length, (index) {
                      final sysValue = dashboardData[index]['sys'] is double
                          ? dashboardData[index]['sys']
                          : double.tryParse(dashboardData[index]['sys'].toString()) ?? 0.0;
                      return FlSpot(index.toDouble(), sysValue);
                    }),
                    isCurved: true,
                    color: Colors.red, // Color for SYS line
                    barWidth: 2,
                    belowBarData: BarAreaData(show: false),
                  ),
                  // DIA Line
                  LineChartBarData(
                    spots: List.generate(dashboardData.length, (index) {
                      final diaValue = dashboardData[index]['dia'] is double
                          ? dashboardData[index]['dia']
                          : double.tryParse(dashboardData[index]['dia'].toString()) ?? 0.0;
                      return FlSpot(index.toDouble(), diaValue);
                    }),
                    isCurved: true,
                    color: Colors.blue, // Color for DIA line
                    barWidth: 2,
                    belowBarData: BarAreaData(show: false),
                  ),
                ],
                  borderData: FlBorderData(show: false),
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(show: true),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  LineChartBarData _getLineData(List<Map<String, dynamic>> healthData, String type, Color color,) {
    List<FlSpot> spots = [];
    
    for (int i = 0; i < healthData.length; i++) {
      double value = healthData[i][type] is double 
          ? healthData[i][type] 
          : double.tryParse(healthData[i][type].toString()) ?? 0.0;
      spots.add(FlSpot(i.toDouble(), value));
    }
    
    return LineChartBarData(
      spots: spots,
      isCurved: true,
      color: Colors.orange,
      dotData: FlDotData(show: false),
      barWidth: 3,
    );
  }

  List<BarChartGroupData> _getBarGroups(Color color, String label) {
    List<double> dataPoints = [];

    for (var data in dashboardData) {
      if (label == "BMI") {
        dataPoints.add(data['bmi'] is double ? data['bmi'] : double.tryParse(data['bmi'].toString()) ?? 0.0);
      } else if (label == "Diabetes") {
        dataPoints.add(data['fpg'] is double ? data['fpg'] : double.tryParse(data['fpg'].toString()) ?? 0.0);
      }
    }

    return List.generate(dataPoints.length, (index) {
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: dataPoints[index],
            color: color,
            width: 15,
            borderRadius: BorderRadius.circular(5),
          ),
        ],
      );
    });
  }
}