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
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: GridView.builder(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(), // Disable GridView's own scrolling
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 16.0,
//                 mainAxisSpacing: 16.0,
//               ),
//               itemCount: 6, // Number of items in the dashboard
//               itemBuilder: (context, index) {
//                 return DashboardCard(
//                   icon: Icons.category, // Replace with appropriate icons
//                   title: 'Feature ${index + 1}',
//                   onTap: () {
//                     // Handle navigation or action when tapped
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => FeatureScreen(index: index + 1)),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class DashboardCard extends StatelessWidget {
//   final IconData icon;
//   final String title;
//   final VoidCallback onTap;

//   const DashboardCard({
//     required this.icon,
//     required this.title,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Card(
//         elevation: 4,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(16),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(
//                 icon,
//                 size: 48,
//                 color: Theme.of(context).primaryColor,
//               ),
//               const SizedBox(height: 16),
//               Text(
//                 title,
//                 textAlign: TextAlign.center,
//                 style: const TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class FeatureScreen extends StatelessWidget {
//   final int index;

//   const FeatureScreen({super.key, required this.index});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Feature $index'),
//       ),
//       body: Center(
//         child: Text(
//           'Feature $index Details',
//           style: const TextStyle(fontSize: 24),
//         ),
//       ),
//     );
//   }
// }

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

