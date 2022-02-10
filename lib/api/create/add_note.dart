import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:platform_device_id/platform_device_id.dart';

class CreateNote{
  // Create user in Firebase fireStore
  Future<void> addUser(String title,String content) async {
    String? deviceId = await PlatformDeviceId.getDeviceId;
    CollectionReference users = FirebaseFirestore.instance.collection(deviceId.toString());
    var date = DateTime.now();
    // Call the user's CollectionReference to add a new user
    return users.add({
      'title': title,
      'content': content,
      'date': '${date.day}/${date.month}/${date.year}',
      'range': date
    })
        .then((value) => print("note have been save"))
        .catchError((error) => print("Failed to save note: $error"));
  }
}