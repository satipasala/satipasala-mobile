import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:path/path.dart' as p;

FirebaseStorage storage = FirebaseStorage.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;

Future<String> uploadImageAndSaveUrl(
  String folder,
  String eventId,
  File image,
) async {
  var downloadUrl;
  String extension = p.extension(image.path);
  String fileName =
      DateTime.now().millisecondsSinceEpoch.toString() + extension;

  var snapshot = await storage
      .ref()
      .child('$folder/$eventId/$fileName')
      .putFile(image)
      .whenComplete(() => print("image uploaded"))
      .then((snapshot) async {
    downloadUrl = await snapshot.ref.getDownloadURL();

    await firestore.collection("eventSessions").doc(eventId).update({
      "imgUrls": FieldValue.arrayUnion([downloadUrl])
    });
  }).onError((error, stackTrace) {
    print(error);
    downloadUrl = "error";
  });
  return downloadUrl;
}
