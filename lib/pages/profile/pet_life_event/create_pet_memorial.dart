import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get_it/get_it.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ploofypaws/components/adaptive_date_picker.dart';
import 'package:ploofypaws/components/adaptive_page_scaffold.dart';
import 'package:ploofypaws/components/body_with_action.dart';
import 'package:ploofypaws/components/button.dart';
import 'package:ploofypaws/helpers/date_format.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ploofypaws/pages/profile/pet_life_event/add_media.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/fire_auth.dart';
import 'package:ploofypaws/services/repositories/memory/memory_model.dart';
import 'package:ploofypaws/services/repositories/memory/memory_service.dart';

class PetMemorialScreen extends StatefulWidget {
  const PetMemorialScreen({super.key});

  @override
  State<PetMemorialScreen> createState() => _PetMemorialScreenState();
}

class _PetMemorialScreenState extends State<PetMemorialScreen> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  String? title;
  DateTime? date;
  String? location;
  String? story;
  List<File> imageFileList = [];
  late MemoryService memoryService;
  late AuthServices authServices;
  final getIt = GetIt.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    memoryService = getIt.get<MemoryService>();
    authServices = getIt.get<AuthServices>();
  }

  @override
  Widget build(BuildContext context) {
    bool isFormFilled = _formKey.currentState?.isValid ?? false;
    return AdaptivePageScaffold(
        automaticallyImplyLeading: true,
        // previousPageTitle: 'Records',
        title: const Text("Pet's Life Events"),
        body: BodyWithAction(
          formKey: _formKey,
          action: Button(
            onPressed: () {
              _checkPermissionAndOpenPicker(context);
            },
            variant: 'filled',
            label: 'Add new life event',
            disabled: isFormFilled ? false : true,
            disabledColor: Colors.grey,
          ),
          body: [
            const SizedBox(
              height: 30,
            ),
            FormBuilderTextField(
              initialValue: title,
              name: 'event_title',
              validator: FormBuilderValidators.required(
                errorText: 'Title  is required',
              ),
              onChanged: (value) {
                setState(() {
                  title = value!;
                });
              },
              decoration: const InputDecoration(
                hintText: 'Title of event',
              ),
            ),
            const SizedBox(height: 10),
            FormBuilderTextField(
              readOnly: true,
              showCursor: false,
              enableInteractiveSelection: false,
              validator: FormBuilderValidators.required(
                errorText: 'Event date is required',
              ),
              name: 'event_date',
              decoration: const InputDecoration(
                suffixIconColor: Colors.black,
                suffixIcon: Icon(Iconsax.calendar),
                hintText: 'Date of event',
              ),
              onTap: () async {
                await AdaptiveDatePicker.pickDate(
                  context,
                  disableFutureDates: true,
                  onDateSelected: (selectedDate) {
                    setState(() {
                      date = selectedDate; // Update the state with the new date
                      final formattedDate = selectedDate.toFullDate();
                      _formKey.currentState?.fields['event_date']
                          ?.didChange(formattedDate);
                    });
                  },
                );
              },
              initialValue: date
                  ?.toFullDate(), // Use the formatted date as the initial value if available
            ),
            const SizedBox(height: 10),
            FormBuilderTextField(
              validator: FormBuilderValidators.required(
                errorText: 'Location date is required',
              ),
              name: 'location',
              decoration: const InputDecoration(
                suffixIconColor: Colors.black,
                suffixIcon: Icon(Iconsax.location),
                hintText: 'location',
              ),
              onChanged: (value) {
                setState(() {
                  location = value!;
                });
              },
              initialValue: date?.toFullDate(),
            ),
            const SizedBox(height: 15),
            FormBuilderTextField(
              name: 'story',
              keyboardType: TextInputType.multiline,
              maxLines: 5,
              onChanged: (value) {
                setState(() {
                  story = value!;
                });
              },
              validator: FormBuilderValidators.required(
                errorText: 'Story is required',
              ),
              decoration: const InputDecoration(
                hintText: 'Story',
              ),
            ),
          ],
        ));
  }

  Future<void> _checkPermissionAndOpenPicker(BuildContext context) async {
    PermissionStatus status = await Permission.mediaLibrary.status;
    if (status.isGranted) {
      await _openImagePicker(context);
      MemoryModel memory = MemoryModel(
        userId: authServices.user!.uid,
        date: date,
        location: location,
        story: story,
        title: title,
      );
      await memoryService.createMemory(memory, imageFileList[0]);
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const UploadPhotoScreen(),
        ),
      );
    }
  }

  Future<void> _openImagePicker(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        imageFileList.add(File(image.path));
      });
    }
  }
}
