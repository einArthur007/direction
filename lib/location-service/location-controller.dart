import 'package:get/get.dart';
import 'package:location/location.dart';

class LocationController extends GetxController {
  final RxBool isAccessingLocation = RxBool(false);
  final RxString errorDescription = RxString('');
  final Rx userLocation = Rx(null);

  void updateAccessingLocation(bool b) {
    isAccessingLocation.value = b;
  }

  void updateUserLocation(LocationData data) {
    userLocation.value = data;
  }
}
