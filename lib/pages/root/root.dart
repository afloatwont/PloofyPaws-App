import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:ploofypaws/components/navigation.dart';
import 'package:ploofypaws/config/constants.dart';
import 'package:ploofypaws/config/theme/theme.dart';
import 'package:ploofypaws/pages/care/app_bar.dart';
import 'package:ploofypaws/pages/care/care.dart';
import 'package:ploofypaws/pages/developer/app_bar.dart';
import 'package:ploofypaws/pages/developer/developer.dart';
import 'package:ploofypaws/pages/home/app_bar.dart';
import 'package:ploofypaws/pages/home/home.dart';
import 'package:ploofypaws/pages/profile/app_bar.dart';
import 'package:ploofypaws/pages/profile/profile.dart';
import 'package:ploofypaws/pages/root/platform_app_bar.dart';
import 'package:ploofypaws/pages/root/provider.dart';
import 'package:ploofypaws/pages/root/sidebar.dart';
import 'package:ploofypaws/pages/tracker/app_bar.dart';
import 'package:ploofypaws/pages/tracker/tracker.dart';
import 'package:ploofypaws/pet_adoption/adoption_page.dart';

class Root extends ConsumerStatefulWidget {
  const Root({super.key});

  @override
  ConsumerState createState() => _RootState();
}

class _RootState extends ConsumerState<Root> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    Home(),
    PetAdoptionPage(),
    Tracker(),
    Profile(),
    if (kDeveloperMode) DeveloperMode(),
  ];

  final List _appBars = [
    HomeAppBar(),
    CareAppBar(),
    TrackerAppBar(),
    ProfileAppBar(),
    if (kDeveloperMode) DevelopersAppBar(),
  ];

  final List<Map<String, dynamic>> _navigationItems = [
    {
      'iconBefore': Iconsax.home_1,
      'label': 'Home',
      'iconAfter': Iconsax.home_25
    },
    {
      'iconBefore': Iconsax.pet4,
      'label': 'Adoption',
      'iconAfter': Iconsax.pet5
    },
    {
      'iconBefore': Iconsax.location,
      'label': 'Track',
      'iconAfter': Iconsax.location5
    },
    {
      'iconBefore': Iconsax.profile_2user,
      'label': 'Profile',
      'iconAfter': Iconsax.profile_2user5
    },
    if (kDeveloperMode)
      {
        'iconBefore': Iconsax.device_message,
        'label': 'Developer',
        'iconAfter': Iconsax.device_message5
      },
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    ref.read(profileProvider);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      systemNavigationBarColor: Colors.black,
      systemNavigationBarDividerColor: Colors.black,
    ));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<ItemNavigationView> tabs = _navigationItems
        .map((item) => _buildNavigationItem(
            item['iconBefore'], item['label'], item['iconAfter']))
        .toList();

    final PlatformAppBar appBar = _appBars[_selectedIndex];

    return CupertinoScaffold(
        body: Scaffold(
            drawer: const Sidebar(),
            appBar: Platform.isAndroid ? appBar.android(context) : null,
            bottomNavigationBar: Padding(
              padding: EdgeInsets.only(bottom: Platform.isIOS ? 16.0 : 0.0),
              child: NavigationView(
                onChangePage: _onItemTapped,
                color: primary,
                items: tabs,
              ),
            ),
            body: Consumer(builder: (context, ref, child) {
              if (Platform.isIOS) {
                return NestedScrollView(
                  headerSliverBuilder: (context, isScrolled) =>
                      [appBar.ios(context)],
                  body: _pages[_selectedIndex],
                );
              }
              return _pages[_selectedIndex];
            })));
  }

  ItemNavigationView _buildNavigationItem(
      IconData iconBefore, String label, IconData iconAfter) {
    return ItemNavigationView(
      childBefore: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(iconBefore, color: Colors.black, size: 20),
          const SizedBox(height: 4),
          Text(label,
              style: typography(context).smallBody.copyWith(fontSize: 12)),
        ],
      ),
      childAfter: Icon(iconAfter, color: Colors.black),
    );
  }

 
}
