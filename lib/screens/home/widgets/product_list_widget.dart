// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../controllers/home_view_controller.dart';

// class ProductListWidgets extends StatelessWidget {
//   final int itemCount;
//   final List imageList;

//   const ProductListWidgets({
//     super.key,
//     required this.itemCount,
//     required this.imageList,
//   });

//   @override
//   Widget build(BuildContext context) {
//     HomeViewController homeViewController = Get.put(HomeViewController());

//     return SizedBox(
//       height: 320,
//       width: double.infinity,
//       child: ListView.builder(
//         itemCount: itemCount,
//         scrollDirection: Axis.horizontal,
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: const EdgeInsets.only(left: 20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 InkWell(
//                   onTap: () {},
//                   child: Container(
//                     width: 250,
//                     height: 250,
//                     padding: const EdgeInsets.all(8),
//                     decoration: BoxDecoration(
//                       color: Colors.grey[100],
//                       image: DecorationImage(
//                         image: AssetImage(imageList[index]),
//                         fit: BoxFit.contain,
//                       ),
//                       borderRadius: const BorderRadius.only(
//                         topLeft: Radius.circular(12),
//                         topRight: Radius.circular(12),
//                       ),
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Obx(
//                           () => IconButton(
//                             onPressed: null,
//                             style: ButtonStyle(
//                               backgroundColor: MaterialStateProperty.all<Color>(
//                                 Colors.white,
//                               ),
//                             ),
//                             icon: homeViewController
//                                         .sellingfastFavList.value[index] ==
//                                     true
//                                 ? const Icon(
//                                     Icons.favorite,
//                                     color: Colors.red,
//                                   )
//                                 : const Icon(
//                                     Icons.favorite_outline,
//                                     color: Colors.black,
//                                   ),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//                 // Sizebox
//                 const SizedBox(height: 5),
//                 const Text(
//                   "Basic High Dpstr",
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 18,
//                     fontFamily: "DMSans Bold",
//                   ),
//                 ),

//                 const Text(
//                   "\$25.90",
//                   style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 18,
//                       fontFamily: "DMSans Bold",
//                       color: Color(0xff059669)),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
