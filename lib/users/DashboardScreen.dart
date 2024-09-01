// import "package:flutter/material.dart";

// class DeshboardScreen extends StatefulWidget{
//   @override
//   State<DeshboardScreen> createState() => _DeshboardScreenState();
// }

// class _DeshboardScreenState extends State<DeshboardScreen> {

  

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Padding(
//         padding: const EdgeInsets.all(30),
//         child: Column(
//           children: [
//             SizedBox(height: 20,),
//             Center(child: Text('Deshboard Data', style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),)),
//             SizedBox(height: 10,),
//             DataTable(
//               columns:const<DataColumn> [
//                 DataColumn(
//                   label: Expanded(
//                     child: Text('Name'),),),
//                 DataColumn(
//                   label: Expanded(
//                     child: Text('Date'),),),
//                 DataColumn(
//                   label: Expanded(
//                     child: Text('Value'),),),
//               ], 
//               rows: const<DataRow> [
//                 DataRow(
//                   cells: <DataCell>[
//                     DataCell(Text('Presure'),),
//                     DataCell(Text('12.12.2024'),),
//                     DataCell(Text('ความดันปกติ'))
//                   ],),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//   //  @override
//   //  Widget build(BuildContext context){
//   //   return const Column(
//   //     children: [
//   //       const SizedBox(height: 18,),
//   //       // const 
//   //     ],
//   //   );
//   //  }

// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:health/users/line_chart.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Manually adding the AppBar as a widget
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

 Container(
      height: MediaQuery.of(context).size.height * 0.11,
      child: Column(
        children: <Widget>[
          Flexible(
            child: Row(
              children: <Widget>[
                _buildStatCard('Pressure', '120/80', Colors.green),
                _buildStatCard('BMI', '18.0', Colors.lightBlue),
                _buildStatCard('Diabetes', '80 Mg/dl', Colors.purple),
              ],
            ),
          ),
        ],
      ),
    ),
    // SizedBox(height: 18,),
    // const LineChartCard(),
    // SizedBox(height: 18,),
    const BarGraphCard(),
        ]
      )
    );
  }

  Expanded _buildStatCard(String title, String count, MaterialColor color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              count,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GraphModel {
  final double x;
  final double y;

  const GraphModel({required this.x, required this.y});
}

class BarGraphModel {
  final String label;
  final Color color;
  final List<GraphModel> graph;

  const BarGraphModel(
      {required this.label, required this.color, required this.graph});
}

class BarGraphData {
  final data = [
    const BarGraphModel(
        label: "Pressure",
        color: Colors.green,
        graph: [
          GraphModel(x: 0, y: 8),
          GraphModel(x: 1, y: 10),
          GraphModel(x: 2, y: 7),
          GraphModel(x: 3, y: 4),
          GraphModel(x: 4, y: 4),
          GraphModel(x: 5, y: 6),
        ]),
    const BarGraphModel(label: "BMI", color: Colors.lightBlue, graph: [
      GraphModel(x: 0, y: 8),
      GraphModel(x: 1, y: 10),
      GraphModel(x: 2, y: 9),
      GraphModel(x: 3, y: 6),
      GraphModel(x: 4, y: 6),
      GraphModel(x: 5, y: 7),
    ]),
    const BarGraphModel(
        label: "Diabetes",
        color: Colors.purple,
        graph: [
          GraphModel(x: 0, y: 7),
          GraphModel(x: 1, y: 10),
          GraphModel(x: 2, y: 7),
          GraphModel(x: 3, y: 4),
          GraphModel(x: 4, y: 4),
          GraphModel(x: 5, y: 10),
        ]),
  ];

  final label = ['M', 'T', 'W', 'T', 'F', 'S'];
}

class CustomCard extends StatelessWidget {
  final Widget child;
  final Color? color;
  final EdgeInsetsGeometry? padding;

  const CustomCard({super.key, this.color, this.padding, required this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(8.0),
          ),
          color: CupertinoColors.lightBackgroundGray,
        ),
        child: Padding(
          padding: padding ?? const EdgeInsets.all(12.0),
          child: child,
        ));
  }
}

class BarGraphCard extends StatelessWidget {
  const BarGraphCard({super.key});

  @override
  Widget build(BuildContext context) {
    final barGraphData = BarGraphData();

    return ListView.builder(
      itemCount: barGraphData.data.length,
      shrinkWrap: true,
      // physics: const NeverScrollableScrollPhysics(), // ปิดการเลื่อนในแนวตั้ง
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: CustomCard(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    barGraphData.data[index].label,
                    style: const TextStyle(
                      fontSize: 16, // ขนาดตัวอักษรใหญ่ขึ้น
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  height: 95, // กำหนดความสูงของกราฟ
                  child: BarChart(
                    BarChartData(
                      barGroups: _chartGroups(
                        points: barGraphData.data[index].graph,
                        color: barGraphData.data[index].color,
                      ),
                      borderData: FlBorderData(border: const Border()),
                      gridData: FlGridData(show: false),
                      titlesData: FlTitlesData(
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Text(
                                  barGraphData.label[value.toInt()],
                                  style: const TextStyle(
                                      fontSize: 12, // ขนาดตัวอักษรใหญ่ขึ้น
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500),
                                ),
                              );
                            },
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}


  List<BarChartGroupData> _chartGroups(
      {required List<GraphModel> points, required Color color}) {
    return points
        .map((point) => BarChartGroupData(x: point.x.toInt(), barRods: [
              BarChartRodData(
                toY: point.y,
                width: 12,
                color: color.withOpacity(point.y.toInt() > 4 ? 1 : 0.4),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(3.0),
                  topRight: Radius.circular(3.0),
                ),
              )
            ]))
        .toList();
  }