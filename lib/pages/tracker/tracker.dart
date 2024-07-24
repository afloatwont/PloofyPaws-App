// import 'package:flutter/material.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
// import 'package:ploofypaws/components/adaptive_app_bar.dart';
// import 'package:ploofypaws/components/adaptive_page_scaffold.dart';
// import 'package:ploofypaws/components/button.dart';
// import 'package:ploofypaws/components/gradient_header.dart';
// import 'package:ploofypaws/components/gradient_text_icon.dart';
// import 'package:ploofypaws/config/theme/theme.dart';
// import 'package:ploofypaws/location/map_location.dart';
// import 'package:ploofypaws/pages/root/root.dart';
// import 'package:ploofypaws/pages/tracker/pairing.dart';
// import 'package:ploofypaws/services/repositories/auth/firebase/providers/user_provider.dart';
// import 'package:provider/provider.dart';

// class Tracker extends StatefulWidget {
//   const Tracker({super.key});

//   @override
//   State<Tracker> createState() => _TrackerState();
// }

// class _TrackerState extends State<Tracker> with SingleTickerProviderStateMixin {
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _checkAndShowAddressModal();
//     });
//   }

//   void _checkAndShowAddressModal() {
//     final userProvider = context.read<UserProvider>();
//     if (!userProvider.hasAddress()) {
//       _showAddressModal();
//     }
//   }

//   void _showAddressModal() {
//     showModalBottomSheet(
//       context: context,
//       builder: (BuildContext context) {
//         // Replace this with your actual modal content
//         return const AddAddressSheet();
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AdaptivePageScaffold(
//       appBar: AdaptiveAppBar(
//         materialAppBar: AppBar(
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back_ios),
//             onPressed: () {
//               Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => const Root(),
//                   ));
//             },
//           ),
//           title: const Text("Tracker"),
//           centerTitle: true,
//           actions: [
//             IconButton(
//               onPressed: () {},
//               icon: Container(
//                 width: 50, // Width and height of the Container
//                 height: 50,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   border: Border.all(
//                     color: Colors.black, // Border color
//                     width: 0.3, // Border width
//                   ),
//                 ),
//                 child: const CircleAvatar(
//                   backgroundColor: Colors.transparent,
//                   foregroundColor: Colors.black,
//                   child: Icon(Icons.notifications_outlined),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             GradientHeader(
//               title: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text("Get your",
//                       style: typography(context)
//                           .smallBody
//                           .copyWith(color: Colors.white)),
//                   const SizedBox(width: 8),
//                   GradientText(
//                       text: "Toe Tracker",
//                       gradient: LinearGradient(colors: [
//                         colors(context).primary.s400,
//                         colors(context).warning.s500
//                       ])),
//                   const SizedBox(width: 8),
//                   Text("Here",
//                       style: typography(context)
//                           .smallBody
//                           .copyWith(color: Colors.white))
//                 ],
//               ),
//               trailing:
//                   const Icon(Icons.keyboard_arrow_right, color: Colors.white),
//             ),
//             Container(
//               width: double.infinity,
//               height: MediaQuery.of(context).size.height * 0.4,
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                   colors: [
//                     Colors.blue.shade200,
//                     Colors.white,
//                     Colors.blue.shade200,
//                   ],
//                   stops: const [0.0, 0.5, 1.0],
//                 ),
//               ),
//               child: Stack(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 20.0, vertical: 12),
//                     child: Image.asset("assets/images/content/tracker_bg.png"),
//                   ),
//                   Positioned(
//                     top: 25.0,
//                     left: 36.0,
//                     child: Text(
//                       "Get your",
//                       style: typography(context)
//                           .smallBody
//                           .copyWith(color: Colors.white),
//                     ),
//                   ),
//                   Positioned(
//                     top: 40.0,
//                     left: 36.0,
//                     child: Text(
//                       "Tracker",
//                       style: typography(context).smallBody.copyWith(
//                           color: Colors.white,
//                           fontSize: 20,
//                           fontWeight: FontWeight.w600),
//                     ),
//                   ),
//                   Positioned(
//                     top: 60.0,
//                     left: 36.0,
//                     child: Text(
//                       "Now",
//                       style: typography(context)
//                           .smallBody
//                           .copyWith(color: Colors.white),
//                     ),
//                   ),
//                   Positioned(
//                     bottom: 40.0,
//                     left: 36.0,
//                     child: Button(
//                       onPressed: () {
//                         // Add button action here
//                       },
//                       label: "Explore",
//                       variant: 'filled',
//                       buttonColor: Colors.white,
//                       foregroundColor: Colors.black,
//                     ),
//                   ),
//                   Positioned(
//                     bottom: 50.0,
//                     right: 50.0,
//                     child: Text(
//                       "Ploofypaws",
//                       style: typography(context)
//                           .smallBody
//                           .copyWith(color: Colors.white),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               height: MediaQuery.of(context).size.height * 0.34,
//               child: Stack(
//                 children: [
//                   Image.asset("assets/images/content/text.png"),
//                   Positioned(
//                     bottom: 11,
//                     left: 10,
//                     right: 10,
//                     child: _addDevice(),
//                   ),
//                   Positioned(
//                     right: 10,
//                     left: 10,
//                     bottom: 8,
//                     top: 0,
//                     child: Opacity(
//                       opacity: 0.7,
//                       child: Image.asset(
//                           "assets/images/content/doodle_cat_black.png"),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const Text(
//               "By adding you are agreeing to terms and conditions and blah blah lorem ipsum",
//               textAlign: TextAlign.center,
//               style: TextStyle(color: Colors.grey),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _addDevice() {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: SizedBox(
//         height: MediaQuery.of(context).size.height * 0.06,
//         width: double.maxFinite,
//         child: Button(
//           onPressed: () {
//             Navigator.push(
//                 context,
//                 MaterialWithModalsPageRoute(
//                     builder: (context) => const TrackerPairingMode()));
//           },
//           label: "Add Device",
//           variant: 'filled',
//           buttonIcon: const Icon(Icons.add, color: Colors.white),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:ploofypaws/components/adaptive_page_scaffold.dart';
import 'package:ploofypaws/components/button.dart';
import 'package:ploofypaws/components/gradient_header.dart';
import 'package:ploofypaws/components/gradient_text_icon.dart';
import 'package:ploofypaws/config/theme/theme.dart';
import 'package:ploofypaws/location/map_location.dart';
import 'package:ploofypaws/pages/tracker/input_imei.dart';
import 'package:ploofypaws/pages/tracker/pairing.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/providers/user_provider.dart';
import 'package:provider/provider.dart';

class Tracker extends StatefulWidget {
  const Tracker({super.key});

  @override
  State<Tracker> createState() => _TrackerState();
}

class _TrackerState extends State<Tracker> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAndShowAddressModal();
    });
  }

  void _checkAndShowAddressModal() {
    final userProvider = context.read<UserProvider>();
    print("address status: ${userProvider.hasAddress()}");
    if (!userProvider.hasAddress()) {
      _showAddressModal();
    }
  }

  void _showAddressModal() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        // Replace this with your actual modal content
        return const AddAddressSheet();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AdaptivePageScaffold(
        appBarBottom: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: GradientHeader(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Get your",
                      style: typography(context)
                          .smallBody
                          .copyWith(color: Colors.white)),
                  const SizedBox(width: 8),
                  GradientText(
                      text: "Toe Tracker",
                      gradient: LinearGradient(colors: [
                        colors(context).primary.s400,
                        colors(context).warning.s500
                      ])),
                  const SizedBox(width: 8),
                  Text("Here",
                      style: typography(context)
                          .smallBody
                          .copyWith(color: Colors.white))
                ],
              ),
              trailing:
                  const Icon(Icons.keyboard_arrow_right, color: Colors.white)),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Button(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialWithModalsPageRoute(
                    builder: (context) => const
                        // TrackerPairingMode(),
                        InputImeiScreen(),
                  ));
            },
            label: "Add Device",
            variant: 'filled',
            buttonIcon: const Icon(Icons.add, color: Colors.white),
          ),
        ),
        body: const Column(
          children: [],
        ));
  }
}
