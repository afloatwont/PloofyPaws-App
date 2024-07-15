import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/fire_store.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:ploofypaws/pages/profile/pet_life_event/create_pet_memorial.dart';

class Memories extends StatefulWidget {
  const Memories({Key? key}) : super(key: key);

  @override
  State<Memories> createState() => _MemoriesState();
}

class _MemoriesState extends State<Memories> {
  final getIt = GetIt.instance;
  late UserDatabaseService userDatabaseService;
  String? pfp;
  bool isUploading = false; // Track whether an image upload is in progress

  @override
  void initState() {
    super.initState();
    userDatabaseService = getIt.get<UserDatabaseService>();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final displayName = userProvider.user?.displayName ?? "User";

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          title: const Text("Memories"),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const PetMemorialScreen()));
              },
              icon: const Icon(
                Icons.add,
                color: Colors.blue,
              ),
            ),
          ],
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: double.maxFinite,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  await showImageSourceActionSheet(
                      context, userProvider.user!.id!);
                  final user = await userDatabaseService
                      .getUserProfileByUID(userProvider.user!.id!);

                  userProvider.setUser(user!);
                  setState(() {
                    pfp = user.photoUrl;
                  });
                },
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      height: 70,
                      width: 100,
                      child: CircleAvatar(
                        radius: 34,
                        backgroundColor: Colors.grey,
                        backgroundImage: userProvider.user?.photoUrl != null
                            ? NetworkImage(userProvider.user!.photoUrl!)
                            : null,
                        child: isUploading
                            ? const CircularProgressIndicator(
                                color: Colors.black,
                                strokeWidth: 3,
                              )
                            : userProvider.user?.photoUrl == null
                                ? const Icon(Iconsax.user)
                                : null,
                      ),
                    ),
                    const Positioned(
                      bottom: 0,
                      right: 5,
                      child: Icon(
                        Icons.add,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                displayName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text("I am a parent of Arlo and Meoww"),
              const SizedBox(height: 20),
              const TabBar(
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(
                    width: 1.0,
                    color: Colors.black,
                  ),
                  insets: EdgeInsets.symmetric(horizontal: 100),
                ),
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                labelStyle: TextStyle(fontWeight: FontWeight.normal),
                tabs: [
                  Tab(text: "Photos"),
                  Tab(text: "Videos"),
                ],
              ),
              const Expanded(
                child: TabBarView(
                  children: [
                    Center(child: Text("Photos Content")),
                    Center(child: Text("Videos Content")),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> showImageSourceActionSheet(
      BuildContext context, String userId) async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () async {
                  Navigator.pop(context);
                  await pickAndUploadProfilePicture(
                      userId, ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () async {
                  Navigator.pop(context);
                  await pickAndUploadProfilePicture(userId, ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> pickAndUploadProfilePicture(
      String userId, ImageSource source) async {
    setState(() {
      isUploading = true; // Start showing progress indicator
    });

    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      File file = File(pickedFile.path);
      final userDatabaseService = GetIt.instance<UserDatabaseService>();

      try {
        String downloadUrl =
            await userDatabaseService.uploadProfilePicture(userId, file);

        print('Profile picture uploaded: $downloadUrl');
      } catch (e) {
        print('Failed to upload profile picture: $e');
      } finally {
        setState(() {
          isUploading = false; // Stop showing progress indicator
        });
      }
    } else {
      print('No image selected.');
      setState(() {
        isUploading = false; // Stop showing progress indicator
      });
    }
  }
}
