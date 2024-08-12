import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:health/users/menu_detail_screen.dart';
import 'package:health/users/menu_items.dart';

class HealthcareScreen extends StatefulWidget {
  const HealthcareScreen({super.key});

  @override
  State<HealthcareScreen> createState() => _HealthcareScreenState();
}

class _HealthcareScreenState extends State<HealthcareScreen> {
 @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: 
          Column(
            children: menus.isNotEmpty
                ? menus.map((menu) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MenuDetailScreen(menu: menu),
                          ),
                        );
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        elevation: 5,
                        child: 
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.horizontal(
                                left: Radius.circular(15.0),
                              ),
                              child: SizedBox(
                                width: 150,
                                height: 150,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  // child: CachedNetworkImage(
                                  //   imageUrl: menu.imageUrl,
                                  //   placeholder: (context, url) =>
                                  //       const Center(child: CircularProgressIndicator()),
                                  //   errorWidget: (context, url, error) =>
                                  //       const Icon(Icons.error),
                                  //   fit: BoxFit.cover,
                                  // ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      menu.title,
                                      style: const TextStyle(
                                        fontSize: 22,
                                        color: Colors.blueAccent,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList()
                : [const Center(child: Text('No menus available'))],
          ),
        ),
      );
  }
  // List icon =[Icons.medical_information,Icons.health_and_safety,Icons.local_hospital, Icons.bloodtype,Icons.group,Icons.support_agent];
  // List title = ['Medical','Health and safe','Hospital','Bloodtype','Group','Support'];

  // @override
  // Widget build(BuildContext context){
  //   return 
    // InkWell(
    //       onTap: (){
    //       // Navigator.push(
    //       //   context, 
    //       //     MaterialPageRoute(
    //       //     settings: RouteSettings(name: "/DetailScreen"),
    //       //     builder: (_)=>Detail()));
    //         },
    //   //     child: Card(
    //   //       margin: EdgeInsets.all(10),
    //   //       child: Padding(
    //   //         padding: const EdgeInsets.all(8.0),
    //   //         child: Row(
    //   //         children: [
    //   //           Expanded(
    //   //           child: Image.asset("health_check.jpg")),
    //   //           SizedBox(width: 10,),
    //   //           Expanded(child: Text("data"))
    //   //       ],
    //   //     ),
    //   //   ),
    //   // ),
    // );
    // SingleChildScrollView(
    //   child: Column(
    //     children: [
    //       SizedBox(height: 50,),
    //       Center(child: Text('Health Care',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),)),
    //       GridView.builder(
    //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //         crossAxisCount: 3),
    //         itemCount: icon.length,
    //         shrinkWrap: true,
    //         physics: NeverScrollableScrollPhysics(), 
    //         itemBuilder: (context, index){
    //           return InkWell(
    //             onTap: (){},
    //             child: Container(
    //               margin: EdgeInsets.all(10),
    //               padding: EdgeInsets.symmetric(vertical: 15),
    //               decoration: BoxDecoration(
    //                 boxShadow: [
    //                   BoxShadow(
    //                     color:Colors.black12,
    //                     blurRadius: 4,
    //                     spreadRadius: 2, 
    //                   ),
    //                 ],
    //               ),
    //               child: Column(
    //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                 children: [
    //                   Icon(icon[index]),
    //                   Text(title[index],
    //                   // style:TextStyle(
    //                   //   fontSize: 18),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           );
    //         },
    //       ),],
    //   ),
    // );
  // child :  
  //   Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
  //     child: 
  //     Card(
  //     elevation: 12,
  //     shape: RoundedRectangleBorder(
  //     borderRadius: BorderRadius.circular(20.0),
  //     ),
  //       color: Colors.blue,
  //       child: 
  //       Column(
  //     children: [
  //       ClipRRect(
  //         borderRadius: const BorderRadius.only(
  //           topRight: Radius.circular(20),
  //           topLeft: Radius.circular(20),
  //         ),
  //         // child: 
  //         // Image.asset(
  //         //   'assets/health.jpg',
  //         //   height: 200,
  //         //   fit: BoxFit.cover,
  //         //   width: double.infinity,
  //         // ),
  //       ),
  //       const ListTile(
  //         title: Text(
  //           'Health Care',
  //           style: TextStyle(
  //             color: Colors.white,
  //           ),
  //         ),
  //         subtitle: Text(
  //           'Thailand',
  //           style: TextStyle(
  //             color: Color.fromARGB(255, 255, 255, 255),
  //           ),
  //         ),
  //       ),
  //       Padding(
  //           padding:
  //               EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  //           child: Row(
  //             children: [
  //               Expanded(
  //                 child: TextButton(
  //                   style: TextButton.styleFrom(
  //                       backgroundColor: Colors.white),
  //                   onPressed: () {},
  //                   child: const Text(
  //                     "Detail",
  //                     style: TextStyle(
  //                       color: Colors.black,
  //                       fontSize: 20,
  //                       fontWeight: FontWeight.bold,
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               SizedBox(
  //                 width: 20,
  //               ),],
  //           ))
  //           ],
  //         ),
  //       ),
  //   ),
  //   );
  // }
}