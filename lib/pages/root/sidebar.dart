import 'package:flutter/material.dart';

class Sidebar extends StatefulWidget {
  const Sidebar({super.key});

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  final List<Map<String, dynamic>> sidebarItems = [
    {'title': 'My Orders', 'icon': Icons.shopping_bag_outlined},
    {'title': 'Appointments', 'icon': Icons.calendar_today_outlined},
    {'title': 'Cart', 'icon': Icons.shopping_cart_outlined},
    {'title': 'Addresses', 'icon': Icons.location_on_outlined},
    {'title': 'Rewards and Wallets', 'icon': Icons.card_giftcard_outlined},
    {'title': 'Settings and Privacy', 'icon': Icons.settings_outlined},
    {'title': 'About Us', 'icon': Icons.info_outline},
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              margin: EdgeInsets.fromLTRB(
                  0, MediaQuery.sizeOf(context).height * 0.07, 0, 0),
              height: MediaQuery.sizeOf(context).height * 0.10,
              decoration: BoxDecoration(
                color: const Color.fromARGB(154, 229, 229, 229),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Name",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
          const Divider(
            color: Colors.black,
            thickness: 0.5,
            endIndent: 12,
            indent: 12,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: sidebarItems.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 0, 12, 12),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(121, 237, 237, 237),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: ListTile(
                      leading: Icon(sidebarItems[index]['icon']),
                      title: Text(
                        sidebarItems[index]['title'],
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      onTap: () {
                        // Handle item tap
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                foregroundColor: Colors.white,
                fixedSize: Size(
                    double.maxFinite, MediaQuery.sizeOf(context).height * 0.07),
              ),
              child: const Text("Sign Out"),
            ),
          ),
        ],
      ),
    );
  }
}
