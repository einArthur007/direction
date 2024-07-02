import 'package:direction/location-service/location-controller.dart';
import 'package:location/location.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:permission_handler/permission_handler.dart' as handler;

class LocationService {
  LocationService.init();
  static LocationService instance = LocationService.init();

  final Location phoneLocation = Location();

  Future checkService() async {
    bool locationService = await phoneLocation.serviceEnabled();
    if (locationService) {
      return Future.value(true);
    }

    locationService = await phoneLocation.requestService();

    if (locationService) {
      return Future.value(true);
    }

    return Future.value(false);
  }

  Future checkPermission() async {
    PermissionStatus status = await phoneLocation.hasPermission();

    if (status == PermissionStatus.denied) {
      status = await phoneLocation.requestPermission();
      if (status == PermissionStatus.granted) {
        return true;
      }
      return false;
    }
    if (status == PermissionStatus.deniedForever) {
      Get.snackbar('Permission Needed',
          'We need your location in order to see when you arrive at your destination',
          onTap: (snack) {
        handler.openAppSettings();
      }).show();
      return false;
    }
    return Future.value(true);
  }

  Future getLocation({required LocationController controller}) async {
    controller.updateAccessingLocation(true);
    if (!(await checkService())) {
      controller.errorDescription.value = 'service not enabled';
      controller.updateAccessingLocation(false);
      return;
    }

    if (!(await checkPermission())) {
      controller.errorDescription.value = 'permission not given';
      controller.updateAccessingLocation(false);
      return;
    }

    final LocationData data = await phoneLocation.getLocation();
    controller.updateUserLocation(data);
    controller.updateAccessingLocation(false);
  }
}
