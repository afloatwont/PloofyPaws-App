import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:ploofypaws/components/button.dart';
import 'package:ploofypaws/components/keep_alive.dart';
import 'package:ploofypaws/config/theme/theme.dart';
import 'package:ploofypaws/pages/pet_onboarding/add_update_extra_details.dart';
import 'package:ploofypaws/pages/pet_onboarding/add_update_pet_dob.dart';
import 'package:ploofypaws/pages/pet_onboarding/add_update_pet_gender.dart';
import 'package:ploofypaws/pages/pet_onboarding/add_update_pet_name.dart';
import 'package:ploofypaws/pages/pet_onboarding/add_update_pet_size.dart';
import 'package:ploofypaws/pages/pet_onboarding/add_update_pet_type_and_breed.dart';
import 'package:ploofypaws/pages/pet_onboarding/data/breed.dart';
import 'package:ploofypaws/pages/root/root.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PetOnboarding extends StatefulWidget {
  const PetOnboarding({
    super.key,
  });

  @override
  State<PetOnboarding> createState() => _PetOnboardingState();
}

class _PetOnboardingState extends State<PetOnboarding> with SingleTickerProviderStateMixin {
  late final AnimationController _lottieController;

  @override
  void initState() {
    super.initState();
    _lottieController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _lottieController.dispose();
    super.dispose();
  }

  void pauseLottieAnimation() {
    _lottieController.stop();
  }

  void resumeLottieAnimation() {
    _lottieController.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(elevation: 0, automaticallyImplyLeading: false, actions: [
        Button(
          label: 'Skip',
          buttonColor: Colors.black,
          onPressed: () async {
            final storage = await SharedPreferences.getInstance();
            storage.setBool('pet_onboarding', true);

            if (!mounted) return;
            Navigator.of(context)
                .pushAndRemoveUntil(MaterialWithModalsPageRoute(builder: (context) => const Root()), (route) => false);
          },
          variant: 'text',
        ),
      ]),
      backgroundColor: Colors.white,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Directionality(
            textDirection: TextDirection.rtl,
            child: Button(
              label: 'Get Started',
              onPressed: () {
                pauseLottieAnimation();
                showCupertinoModalBottomSheet(
                    isDismissible: false,
                    enableDrag: false,
                    context: context,
                    builder: (context) {
                      return const AddUpdatePetInfo();
                    }).then((_) => resumeLottieAnimation());
              },
              variant: 'filled',
              buttonColor: Colors.black,
              foregroundColor: Colors.white,
              buttonIcon: const Icon(
                Iconsax.arrow_right_14,
              ),
            )),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Lottie.asset('assets/lottie/pet_onboarding.json', controller: _lottieController, onLoaded: (composition) {
            _lottieController
              ..duration = composition.duration
              ..repeat();
          }, frameRate: FrameRate.max),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Lets setup your \npet for ploofypaws life. \nshall we?',
              style: typography(context).ploofypawsTitle.copyWith(fontSize: 26),
            ),
          ),
        ],
      ),
    );
  }
}

class AddUpdatePetInfo extends StatefulWidget {
  const AddUpdatePetInfo({super.key});

  @override
  State<AddUpdatePetInfo> createState() => _AddUpdatePetInfoState();
}

class _AddUpdatePetInfoState extends State<AddUpdatePetInfo> {
  PetBreed? selectedBreed;
  int _currentPage = 0;

  final GlobalKey<FormBuilderState> _petNameFormKey = GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> _petTypeFormKey = GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> _petSizeFormKey = GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> _petGenderFormKey = GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> _petDobFormKey = GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> _petExtraDetailsFormKey = GlobalKey<FormBuilderState>();

  final PageController _pageController = PageController(
    initialPage: 0,
  );

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void nextPage() {
    final formKeys = [
      _petNameFormKey,
      _petTypeFormKey,
      _petSizeFormKey,
      _petDobFormKey,
      _petGenderFormKey,
      _petExtraDetailsFormKey
    ];

    if (formKeys[_currentPage].currentState?.saveAndValidate() ?? false) {
      final petName = _petNameFormKey.currentState?.fields['pet_name']?.value;
      final petType = _petTypeFormKey.currentState?.fields['pet_type']?.value ?? "Dog";
      final petBreed = selectedBreed?.name ?? "";
      final petSize = _petSizeFormKey.currentState?.fields['pet_size']?.value;
      final petDob = _petDobFormKey.currentState?.fields['pet_date_of_birth']?.value;
      final petGender = _petGenderFormKey.currentState?.fields['pet_gender']?.value;
      final petExtraDetails = _petExtraDetailsFormKey.currentState?.fields['pet_extra_details']?.value ?? "a";

      if (_currentPage == 5) {
        _handleSubmit(petName, petType, petBreed, petSize, petDob, petGender, petExtraDetails);
      }

      _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    } else {
      // Optionally handle the case where validation fails
    }
  }

  _handleSubmit(String petName, String petType, String petBreed, String petSize, String petGender, String petDob,
      List<String> petExtraDetails) async {
    try {
      final storage = await SharedPreferences.getInstance();
      storage.setBool('pet_onboarding', true);

      if (!mounted) return;
      Navigator.of(context)
          .pushAndRemoveUntil(MaterialWithModalsPageRoute(builder: (context) => const Root()), (route) => false);
    } catch (e) {
      print(e);
    }
  }

  void onBreedSelected(List<PetBreed> breed) {
    setState(() {
      selectedBreed = breed.first;
    });
    _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  void onPagePopped() {
    if (_currentPage == 0) {
      Navigator.of(context).pop();
    } else {
      _pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    }
  }

  Future<bool> onPageWillPopScope() async {
    if (_currentPage == 0) {
      Navigator.of(context).pop();
      return false;
    }
    return await showAdaptiveDialog(
      context: context,
      builder: (context) {
        return AlertDialog.adaptive(
          title: const Text('Are you sure?'),
          content: const Text('Do you want to cancel the onboarding process?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () async {
                final storage = await SharedPreferences.getInstance();
                storage.setBool('pet_onboarding', true);

                if (!mounted) return;
                Navigator.of(context).pop(false);
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const Root()));
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double bottomPadding = MediaQuery.of(context).viewInsets.bottom;
    final petName = _petNameFormKey.currentState?.fields['pet_name']?.value;
    return WillPopScope(
      onWillPop: onPageWillPopScope,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Iconsax.arrow_left_2),
            onPressed: onPagePopped,
          ),
        ),
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: onPageChanged,
          children: [
            KeepAlivePage(
                child: AddUpdatePetName(
              formKey: _petNameFormKey,
            )),
            KeepAlivePage(
                child: AddUpdatePetType(
              onBreedSelected: onBreedSelected,
              formKey: _petTypeFormKey,
              petName: petName,
            )),
            KeepAlivePage(child: AddUpdatePetSize(selected: selectedBreed, formKey: _petSizeFormKey, petName: petName)),
            KeepAlivePage(
                child: AddUpdatePetDOB(
              formKey: _petDobFormKey,
              petName: petName,
            )),
            KeepAlivePage(
                child: AddUpdatePetGender(
              formKey: _petGenderFormKey,
              petName: petName,
            )),
            KeepAlivePage(
                child: AddUpdateExtraDetails(
              formKey: _petExtraDetailsFormKey,
            ))
          ],
        ),
        bottomNavigationBar: _currentPage == 1
            ? null
            : Padding(
                padding: EdgeInsets.only(bottom: bottomPadding + 16, left: 16, right: 16, top: 16),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Button(
                    label: 'Next',
                    onPressed: nextPage,
                    variant: 'filled',
                    buttonIcon: const Icon(
                      Iconsax.arrow_right_14,
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
