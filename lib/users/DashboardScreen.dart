import "package:flutter/material.dart";

class DeshboardScreen extends StatefulWidget{
  @override
  State<DeshboardScreen> createState() => _DeshboardScreenState();
}

class _DeshboardScreenState extends State<DeshboardScreen> {

  

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            SizedBox(height: 20,),
            Center(child: Text('Deshboard Data', style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),)),
            SizedBox(height: 10,),
            DataTable(
              columns:const<DataColumn> [
                DataColumn(
                  label: Expanded(
                    child: Text('Name'),),),
                DataColumn(
                  label: Expanded(
                    child: Text('Date'),),),
                DataColumn(
                  label: Expanded(
                    child: Text('Value'),),),
              ], 
              rows: const<DataRow> [
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text('Presure'),),
                    DataCell(Text('12.12.2024'),),
                    DataCell(Text('ความดันปกติ'))
                  ],),
              ],
            ),
          ],
        ),
      ),
    );
  }
  //  @override
  //  Widget build(BuildContext context){
  //   return const Column(
  //     children: [
  //       const SizedBox(height: 18,),
  //       // const 
  //     ],
  //   );
  //  }

}