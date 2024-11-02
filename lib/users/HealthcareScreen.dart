// import 'package:flutter/material.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:health/users/menu_detail_screen.dart';
// import 'package:health/users/menu_items.dart';

// class HealthcareScreen extends StatefulWidget {
//   const HealthcareScreen({super.key});

//   @override
//   State<HealthcareScreen> createState() => _HealthcareScreenState();
// }

// class _HealthcareScreenState extends State<HealthcareScreen> {

//  @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//         child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Manually adding the AppBar as a widget
//           Container(
//             padding: const EdgeInsets.only(top: 40.0, left: 16.0, right: 16.0, bottom: 16.0),
//             color: Colors.blue,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   'Health Care',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//           ), 
//         Padding(
//           padding: const EdgeInsets.all(12.0),
//           child: 
//           Column(
//             children: menus.isNotEmpty
//                 ? menus.map((menu) {
//                     return GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => MenuDetailScreen(menu: menu),
//                           ),
//                         );
//                       },
//                       child: Card(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(15.0),
//                         ),
//                         elevation: 5,
//                         child: 
//                         Row(
//                           children: [
//                             ClipRRect(
//                               borderRadius: const BorderRadius.horizontal(
//                                 left: Radius.circular(15.0),
//                               ),
//                               child: SizedBox(
//                                 width: 150,
//                                 height: 150,
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: CachedNetworkImage(
//                                     imageUrl: menu.imageUrl,
//                                     placeholder: (context, url) =>
//                                         const Center(child: CircularProgressIndicator()),
//                                     errorWidget: (context, url, error) =>
//                                         const Icon(Icons.error),
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Expanded(
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       menu.title,
//                                       style: const TextStyle(
//                                         fontSize: 22,
//                                         color: Colors.blueAccent,
//                                       ),
//                                       maxLines: 2,
//                                       overflow: TextOverflow.ellipsis,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   }).toList()
//                 : [const Center(child: Text('No menus available'))],
//           ),
//         ),
//         ]
//         )
//       );
//   }
// }

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:health/api_connection/api_connetion.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HealthcareScreen extends StatefulWidget {
  const HealthcareScreen({super.key});

  @override
  State<HealthcareScreen> createState() => _HealthcareScreenState();
}

class _HealthcareScreenState extends State<HealthcareScreen> {
  List<dynamic> menus = [];

  @override
  void initState() {
    super.initState();
    fetchHealthcare().then((value) {
      setState(() {
        menus = value;
      });
    });
  }

  Future<List<dynamic>> fetchHealthcare() async {
    final response = await http.get(Uri.parse(API.get_health));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load healthcare data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 40.0, left: 16.0, right: 16.0, bottom: 16.0),
            color: Colors.blue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Health Care',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: menus.isNotEmpty
                  ? menus.map((menu) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailScreen(menu: menu),
                            ),
                          );
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          elevation: 5,
                          child: Row(
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
                                    child: CachedNetworkImage(
                                      imageUrl: menu['imageUrl'],
                                      placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                      errorWidget: (context, url, error) => const Icon(Icons.error),
                                      fit: BoxFit.cover,
                                    ),
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
                                        menu['title'],
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
        ],
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final dynamic menu;

  const DetailScreen({super.key, required this.menu});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(menu['title']),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                imageUrl: menu['imageUrl'],
                placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 16),
              Text(
                menu['description'], // ดึงข้อมูล description จาก JSON
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


