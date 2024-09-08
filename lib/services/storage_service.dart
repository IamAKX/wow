import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  static Future<String> uploadImage(File file, String path) async {
    final ref = FirebaseStorage.instance.ref().child(path);
    UploadTask? uploadTask = ref.putFile(file);
    final snapshot = await uploadTask.whenComplete(() {});
    final downloadLink = await snapshot.ref.getDownloadURL();
    return downloadLink;
  }
}
