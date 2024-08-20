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

import 'package:flutter/material.dart';

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
            color: Theme.of(context).primaryColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                _buildStatCard('Pressure', '391 K', Colors.green),
                _buildStatCard('BMI', '1.31 M', Colors.lightBlue),
                _buildStatCard('Diabetes', 'N/A', Colors.purple),
              ],
            ),
          ),
        ],
      ),
    ),
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

// class GraphModel {
//   final double x;
//   final double y;

//   const GraphModel({required this.x, required this.y});
// }

// class BarGraphModel{
//   final String label;
//   final Color color;
//   final List<GraphModel>graph;

//   const BarGraphModel({});
// }

// class BarGraphData{
//   final data = [
//     const BarGraphModel(
//       label : 'Pressure',
//       color: 
//       graph:[]
//     ),
//   ];
// }

