import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:yele/src/core/services/permission_service.dart';
import 'package:yele/src/core/widgets/constant_widgets.dart';

class LocationService {
  static Future<Position?> getUserCurrentLocation(
    BuildContext context, {
    bool showDailog = true,
  }) async {
    try {
      bool isLocationPermission =
          await PermissionService.requestLocationPermission(
            context,
            showDailog: showDailog,
          );
      if (isLocationPermission) {
        final latlng = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        return latlng;
      }
    } catch (e) {
      errorSnackBar(
        message:
            'Please turn on GPS service of this device for live location detection.',
      );
    }
    return null;
  }
}
