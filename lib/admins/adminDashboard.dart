// import 'dart:async';
// import 'dart:convert';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:health/api_connection/api_connetion.dart';

// class AdminDashboard extends StatefulWidget {
//   @override
//   _AdminDashboardState createState() => _AdminDashboardState();
// }

// class _AdminDashboardState extends State<AdminDashboard> {
//   int totalUsers = 0;
//   List<Map<String, dynamic>> healthData = [];
//   Timer? _timer;

//   @override
//   void initState() {
//     super.initState();
//     fetchDashboardData();
//     _startAutoRefresh();
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     super.dispose();
//   }

//   void _startAutoRefresh() {
//     _timer = Timer.periodic(Duration(seconds: 5), (timer) {
//       fetchDashboardData();
//     });
//   }

//   Future<void> fetchDashboardData() async {
//     try {
//       var usersResponse = await http.get(Uri.parse(API.count_user));
//       var healthResponse = await http.get(Uri.parse(API.dashboard));

//       if (usersResponse.statusCode == 200) {
//         var usersData = jsonDecode(usersResponse.body);
//         totalUsers = usersData.length;
//       }

//       if (healthResponse.statusCode == 200) {
//         healthData = List<Map<String, dynamic>>.from(jsonDecode(healthResponse.body));
//       }

//       setState(() {});
//     } catch (e) {
//       print("Error fetching data: $e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Container(
//                 padding: const EdgeInsets.only(top: 40.0, left: 16.0, right: 16.0, bottom: 16.0),
//                 color: Colors.blue,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       'Admin Dashboard',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 8),
//               if (healthData.isNotEmpty)
//                 Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         _buildSummaryCard("Total Users", "$totalUsers", Colors.green),
//                         _buildSummaryCard("Pressure", "${healthData.last['sys']}/${healthData.last['dia']}", Colors.orange),
//                         _buildSummaryCard("BMI", _formatValueAsDouble(healthData.last['bmi']), Colors.lightBlue),
//                         _buildSummaryCard("Diabetes", _formatValueAsDouble(healthData.last['fpg']), Colors.purple)
                        
//                       ],
//                     ),
//                     SizedBox(height: 20),
//                     _buildLineChartCard("Pressure", Colors.green, Colors.orange),
//                     SizedBox(height: 20),
//                     _buildBarChartCard("BMI", Colors.lightBlue),
//                     SizedBox(height: 20),
//                     _buildBarChartCard("Diabetes", Colors.purple),
//                     SizedBox(height: 20),
//                   ],
//                 )
//               else
//                 Center(
//                   child: Text('No data available'),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   String _formatValueAsDouble(dynamic value) {
//     try {
//       double parsedValue = double.tryParse(value.toString()) ?? 0.0;
//       return parsedValue.toStringAsFixed(2);
//     } catch (e) {
//       return "0.00";
//     }
//   }

//   Widget _buildSummaryCard(String label, String value, Color color) {
//     return Container(
//       width: 100,
//       height: 80,
//       decoration: BoxDecoration(
//         color: color,
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               label,
//               style: TextStyle(color: Colors.white, fontSize: 16),
//             ),
//             SizedBox(height: 5),
//             Text(
//               value,
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildBarChartCard(String label, Color color) {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//       child: Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               label,
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 10),
//             Container(
//               height: 150,
//               child: BarChart(
//                 BarChartData(
//                   barGroups: _getBarGroups(color, label),
//                   borderData: FlBorderData(show: false),
//                   gridData: FlGridData(show: false),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildLineChartCard(String label, Color sysColor, Color diaColor) {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//       child: Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               label,
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 10),
//             Container(
//               height: 150,
//               child: LineChart(
//                 LineChartData(
//                   // lineBarsData: [
//                   //   _getLineData(healthData, 'sys', sysColor),
//                   //   _getLineData(healthData, 'dia', diaColor),
//                   // ],
//                   lineBarsData: [
//                   // SYS Line
//                   LineChartBarData(
//                     spots: List.generate(healthData.length, (index) {
//                       final sysValue = healthData[index]['sys'] is double
//                           ? healthData[index]['sys']
//                           : double.tryParse(healthData[index]['sys'].toString()) ?? 0.0;
//                       return FlSpot(index.toDouble(), sysValue);
//                     }),
//                     isCurved: true,
//                     color: Colors.red, // Color for SYS line
//                     barWidth: 2,
//                     belowBarData: BarAreaData(show: false),
//                   ),
//                   // DIA Line
//                   LineChartBarData(
//                     spots: List.generate(healthData.length, (index) {
//                       final diaValue = healthData[index]['dia'] is double
//                           ? healthData[index]['dia']
//                           : double.tryParse(healthData[index]['dia'].toString()) ?? 0.0;
//                       return FlSpot(index.toDouble(), diaValue);
//                     }),
//                     isCurved: true,
//                     color: Colors.blue, // Color for DIA line
//                     barWidth: 2,
//                     belowBarData: BarAreaData(show: false),
//                   ),
//                 ],
//                   borderData: FlBorderData(show: false),
//                   gridData: FlGridData(show: false),
//                   titlesData: FlTitlesData(show: true),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   LineChartBarData _getLineData(List<Map<String, dynamic>> healthData, String type, Color color,) {
//     List<FlSpot> spots = [];
    
//     for (int i = 0; i < healthData.length; i++) {
//       double value = healthData[i][type] is double 
//           ? healthData[i][type] 
//           : double.tryParse(healthData[i][type].toString()) ?? 0.0;
//       spots.add(FlSpot(i.toDouble(), value));
//     }
    
//     return LineChartBarData(
//       spots: spots,
//       isCurved: true,
//       color: Colors.orange,
//       dotData: FlDotData(show: false),
//       barWidth: 3,
//     );
//   }

//   List<BarChartGroupData> _getBarGroups(Color color, String label) {
//     List<double> dataPoints = [];

//     for (var data in healthData) {
//       if (label == "BMI") {
//         dataPoints.add(data['bmi'] is double ? data['bmi'] : double.tryParse(data['bmi'].toString()) ?? 0.0);
//       } else if (label == "Diabetes") {
//         dataPoints.add(data['fpg'] is double ? data['fpg'] : double.tryParse(data['fpg'].toString()) ?? 0.0);
//       }
//     }

//     return List.generate(dataPoints.length, (index) {
//       return BarChartGroupData(
//         x: index,
//         barRods: [
//           BarChartRodData(
//             toY: dataPoints[index],
//             color: color,
//             width: 15,
//             borderRadius: BorderRadius.circular(5),
//           ),
//         ],
//       );
//     });
//   }
  
// }

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:health/api_connection/api_connetion.dart';
import 'package:share_plus/share_plus.dart';

class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int totalUsers = 0;
  List<Map<String, dynamic>> healthData = [];
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    fetchDashboardData();
    _startAutoRefresh();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startAutoRefresh() {
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      fetchDashboardData();
    });
  }

  Future<void> fetchDashboardData() async {
    try {
      var usersResponse = await http.get(Uri.parse(API.count_user));
      var healthResponse = await http.get(Uri.parse(API.dashboard));

      if (usersResponse.statusCode == 200) {
        var usersData = jsonDecode(usersResponse.body);
        totalUsers = usersData.length;
      }

      if (healthResponse.statusCode == 200) {
        healthData = List<Map<String, dynamic>>.from(jsonDecode(healthResponse.body));
      }

      setState(() {});
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  // Function to format data for sharing
  String _formatDataForSharing() {
    StringBuffer buffer = StringBuffer();
    buffer.writeln("Total Users: $totalUsers\n");
    buffer.writeln("Health Data:");
    for (var data in healthData) {
      buffer.writeln("Sys: ${data['sys']}, Dia: ${data['dia']}, BMI: ${data['bmi']}, Diabetes: ${data['fpg']}");
    }
    return buffer.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Dashboard"),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              Share.share(_formatDataForSharing());
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (healthData.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: DataTable(
                    columns: [
                      DataColumn(label: Text("Sys")),
                      DataColumn(label: Text("Dia")),
                      DataColumn(label: Text("BMI")),
                      DataColumn(label: Text("Diabetes")),
                    ],
                    rows: healthData.map((data) {
                      return DataRow(cells: [
                        DataCell(Text(data['sys'].toString())),
                        DataCell(Text(data['dia'].toString())),
                        DataCell(Text(data['bmi'].toString())),
                        DataCell(Text(data['fpg'].toString())),
                      ]);
                    }).toList(),
                  ),
                )
              else
                Center(child: Text('No data available')),
            ],
          ),
        ),
      ),
    );
  }
}
