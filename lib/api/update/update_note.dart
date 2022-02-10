
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:platform_device_id/platform_device_id.dart';

class UpdateNote {
  Future<void> updateNote(String ducId, String title, String content) async {
    String? deviceId = await PlatformDeviceId.getDeviceId;
    var date = DateTime.now();
    CollectionReference users = FirebaseFirestore.instance.collection(
        deviceId.toString());
    users.doc(ducId)
        .update({
      "title": title,
      "content": content,
      "range": date
    });
  }
}