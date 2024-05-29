import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:restoe/components/gradient_header.dart';
import 'package:restoe/config/theme/theme.dart';
import 'package:restoe/pages/profile/app_settings/app_settings.dart';
import 'package:restoe/pages/profile/widgets/pet_card.dart';

class ModalFit extends StatelessWidget {
  const ModalFit({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
        child: SafeArea(
      top: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Center(
              child: Icon(
            Iconsax.minus,
            size: 34,
            color: primary,
          )),
          ListTile(
            title: const Text('Share Profile'),
            leading: const Icon(Icons.share_outlined),
            onTap: () => Navigator.of(context).pop(),
          ),
          ListTile(
            title: const Text('My Favorites'),
            leading: const Icon(Iconsax.heart),
            onTap: () => Navigator.of(context).pop(),
          ),
          ListTile(
            title: const Text('My Bookings'),
            leading: const Icon(Iconsax.book),
            onTap: () => Navigator.of(context).pop(),
          ),
          ListTile(
              title: const Text('Settings'),
              leading: const Icon(Iconsax.setting),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialWithModalsPageRoute(builder: (context) => const AppSettings()));
              }),
          const SizedBox(height: 24),
        ],
      ),
    ));
  }
}

class Profile extends ConsumerStatefulWidget {
  const Profile({super.key});

  @override
  ConsumerState createState() => _ProfileState();
}

class _ProfileState extends ConsumerState<Profile> {
  final PageController _controller = PageController(viewportFraction: 0.8, initialPage: 0);

  // Dummy data that might typically come from a backend.
  final List<Map<String, dynamic>> petData = [
    {
      'name': 'Arlo',
      'type': 'Beagle',
      'species': 'Dog',
      'gender': 'Male',
      'age': '2 years old',
      'image': 'assets/images/placeholders/pet_card_placeholder.png'
    },
    {
      'name': 'Bella',
      'type': 'Labrador',
      'species': 'Dog',
      'gender': 'Female',
      'age': '3 years old',
      'image': 'assets/images/placeholders/pet_card_placeholder.png'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            child: PageView.builder(
              controller: _controller,
              itemCount: petData.length + 1, // +1 for the 'Add a pet' card
              itemBuilder: (context, index) {
                return AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    double scale = 1.0;
                    if (_controller.position.haveDimensions) {
                      scale = _controller.page! - index;
                      scale = (1 - (scale.abs() * 0.2)).clamp(0.8, 1.0);
                    } else {
                      scale = index == 0 ? 1.0 : 0.8; // Default scale for the initial load
                    }
                    return Center(
                      child: SizedBox(
                        height: Curves.easeInOut.transform(scale) * MediaQuery.of(context).size.height * 0.6,
                        width: Curves.easeInOut.transform(scale) * MediaQuery.of(context).size.width * 0.8,
                        child: index < petData.length
                            ? PetCard(pet: petData[index], scale: scale)
                            : Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Iconsax.add_circle, size: 50, color: Colors.white),
                                    const SizedBox(height: 16),
                                    Text('Add a pet',
                                        style: typography(context).restoeTitle.copyWith(color: Colors.amber)),
                                  ],
                                ),
                              ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          GradientHeader(
            leading: Text(
              "Wellness Score",
              style: typography(context).body.copyWith(
                    color: Colors.white,
                  ),
            ),
            trailing: const Icon(Icons.keyboard_arrow_right_outlined, color: Colors.white),
          ),
          const SizedBox(height: 16),
          GradientHeader(
            leading: Text(
              "Activity",
              style: typography(context).body.copyWith(
                    color: Colors.white,
                  ),
            ),
            trailing: const Icon(Icons.keyboard_arrow_right_outlined, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
