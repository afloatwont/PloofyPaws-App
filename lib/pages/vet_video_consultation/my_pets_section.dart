// import 'package:flutter/material.dart';

// class MyPetsSection extends StatelessWidget {
//   final List<String> petNames = ['Arlo', 'shiro', 'chomu', 'hamster'];
//   final List<String> petImages = [
//     'assets/arlo.jpg',
//     'assets/shiro.jpg',
//     'assets/chomu.jpg',
//     'assets/x_hamster.jpg'
//   ];

//   MyPetsSection({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text('My Pets', style: TextStyle()),
//         const SizedBox(height: 8),
//         SizedBox(
//           height: MediaQuery.sizeOf(context).height * 0.12,
//           width: MediaQuery.sizeOf(context).width *
//               MediaQuery.sizeOf(context).width,
//           child: SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 ...List.generate(petNames.length, (index) {
//                   return Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 4.0),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         CircleAvatar(
//                           backgroundColor: Colors.grey.shade300,
//                           radius: 30,
//                           // backgroundImage: AssetImage(petImages[index]),
//                         ),
//                         const SizedBox(height: 4),
//                         Text(petNames[index]),
//                       ],
//                     ),
//                   );
//                 }),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 4.0),
//                   child: CircleAvatar(
//                     backgroundColor: Colors.grey.shade100,
//                     radius: 30,
//                     child: const Icon(
//                       Icons.add,
//                       color: Colors.black,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
