import 'package:firebase_storage/firebase_storage.dart';

Future<String> getImageUrl(String imagePath) async {
  final ref = FirebaseStorage.instance.ref().child(imagePath);
  return await ref.getDownloadURL();
}