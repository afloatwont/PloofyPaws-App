import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ploofypaws/pages/appointment/appointment.dart';
import 'package:ploofypaws/pages/profile/app_settings/app_settings.dart';
import 'package:ploofypaws/pages/profile/pet_life_event/memories.dart';
import 'package:ploofypaws/pages/root/init_app.dart';
import 'package:ploofypaws/pages/root/saved_address_page.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/fire_auth.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/fire_store.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/models/user_model.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/providers/pet_provider.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/providers/user_provider.dart';
import 'package:provider/provider.dart';

class Sidebar extends StatefulWidget {
  const Sidebar({super.key});

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  final List<Map<String, dynamic>> sidebarItems = [
    {'title': 'My Orders', 'icon': Icons.shopping_bag_outlined, 'pushTo': null},
    {
      'title': 'Appointments',
      'icon': Icons.calendar_today_outlined,
      'pushTo': const Appointment()
    },
    {'title': 'Cart', 'icon': Icons.shopping_cart_outlined, 'pushTo': null},
    {
      'title': 'Addresses',
      'icon': Icons.location_on_outlined,
      'pushTo': const SavedAddressPage()
    },
    {
      'title': 'Rewards and Wallets',
      'icon': Icons.card_giftcard_outlined,
      'pushTo': null
    },
    {
      'title': 'Settings and Privacy',
      'icon': Icons.settings_outlined,
      'pushTo': const AppSettings()
    },
    {'title': 'About Us', 'icon': Icons.info_outline, 'pushTo': null},
  ];

  final List<Widget> pages = [
    const Memories(),
  ];

  final GetIt _getIt = GetIt.instance;
  late AuthServices _authServices;
  late UserDatabaseService _userDatabaseService;

  @override
  void initState() {
    super.initState();
    _authServices = _getIt.get<AuthServices>();
    _userDatabaseService = _getIt.get<UserDatabaseService>();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.read<UserProvider>();
    return Drawer(
      child: Column(
        children: [
          _buildUserHeader(context),
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
                return _buildSidebarItem(index);
              },
            ),
          ),
          _buildSignOutButton(context),
        ],
      ),
    );
  }

  Widget _buildUserHeader(BuildContext context) {
    final user = context.read<UserProvider>().user;
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => pages[0],
              ));
        },
        child: Container(
          margin: EdgeInsets.fromLTRB(
              0, MediaQuery.sizeOf(context).height * 0.07, 0, 0),
          height: MediaQuery.sizeOf(context).height * 0.10,
          decoration: BoxDecoration(
            color: const Color.fromARGB(154, 229, 229, 229),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: Colors.black,
                backgroundImage:
                    (user?.photoUrl != null && user?.photoUrl != "")
                        ? NetworkImage((user?.photoUrl)!)
                        : null,
                child: (user?.photoUrl?.isEmpty ?? true)
                    ? const Icon(Icons.person, size: 32)
                    : null,
              ),
              Text(
                user?.displayName ?? "User",
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios_outlined,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSidebarItem(int index) {
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
            if (sidebarItems[index]['pushTo'] != null) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => sidebarItems[index]['pushTo'],
                  ));
            }
          },
        ),
      ),
    );
  }

  Widget _buildSignOutButton(BuildContext context) {
    final userProvider = context.read<UserProvider>();
    final petProvider = context.read<PetProvider>();
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ElevatedButton(
        onPressed: () async {
          bool res = await _authServices.signOut();

          userProvider.removeUser();
          petProvider.setPets(null);
          if (res) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const InitApp(),
                ));
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          foregroundColor: Colors.white,
          fixedSize:
              Size(double.maxFinite, MediaQuery.sizeOf(context).height * 0.07),
        ),
        child: const Text("Sign Out"),
      ),
    );
  }
}
