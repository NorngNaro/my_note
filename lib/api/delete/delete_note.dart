import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:platform_device_id/platform_device_id.dart';
class DeleteNote{
  // Create user in Firebase fireStore
  Future<void> deleteNote(String ducumentId) async {
    String? deviceId = await PlatformDeviceId.getDeviceId;
    CollectionReference users = FirebaseFirestore.instance.collection(deviceId.toString());
      return users
          .doc(ducumentId)
          .delete()
          .then((value) => print("Note Deleted"))
          .catchError((error) => print("Failed to delete note: $error"));
  }
}