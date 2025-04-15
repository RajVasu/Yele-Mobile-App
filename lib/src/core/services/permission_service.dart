import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:yele/src/core/services/device_info_service.dart';
import 'package:yele/src/core/widgets/permission_dialog.dart';

class PermissionService {
  static Future<bool> requestCameraPermission(BuildContext context) async {
    Permission permission = Permission.camera;
    bool isGranted = await _checkPermmisionIsGranted(permission);
    if (isGranted) return true;
    if (!context.mounted) return false;
    final status = await requestPermission(
      context: context,
      permission: permission,
      title: 'Camera Permission Denied',
      message:
          'You need to allow camera access in parameters for use your ID card scan.',
    );
    return status;
  }

  static Future<bool> requestGalleryPermission(BuildContext context) async {
    late Permission permission;
    if (Platform.isAndroid) {
      int sdk = await DeviceInfoService.getSdk();
      if (sdk <= 32) {
        permission = Permission.storage;
      } else {
        return true;
      }
    } else {
      permission = Permission.photos;
    }
    bool isGranted = await _checkPermmisionIsGranted(permission);
    if (isGranted) return true;
    if (!context.mounted) return false;
    final status = await requestPermission(
      context: context,
      permission: permission,
      title: 'Gallery Permission Denied',
      message:
          'The app needs access to your gallery to select and upload photos for your profile.',
    );
    return status;
  }

  static Future<bool> requestLocationPermission(
    BuildContext context, {
    bool showDailog = true,
  }) async {
    LocationPermission locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.whileInUse ||
        locationPermission == LocationPermission.always)
      return true;
    LocationPermission requestPermission = await Geolocator.requestPermission();
    if (requestPermission == LocationPermission.whileInUse ||
        requestPermission == LocationPermission.always)
      return true;
    if (requestPermission == LocationPermission.denied) {
      if (!context.mounted) return false;
      return requestLocationPermission(context, showDailog: showDailog);
    }
    if (requestPermission == LocationPermission.deniedForever) {
      if (!context.mounted) return false;
      if (showDailog) {
        _showPermissionDeniedBottomSheet(
          context,
          title: 'Permission Required',
          message:
              'To provide you with information about nearby booths, we need access to your location. Please grant location permission to enable us to show you booths near your current location.',
        );
      }
    }
    return false;
  }

  static Future<bool> requestPermission({
    required BuildContext context,
    required Permission permission,
    String title = 'Permission Denied',
    String message =
        'The app needs access to your device features to function properly. Please enable the required permissions in the app settings.',
  }) async {
    final status = await permission.request();
    if (status == PermissionStatus.granted ||
        status == PermissionStatus.limited)
      return true;
    if (status == PermissionStatus.denied) {
      return false;
    }
    if (status == PermissionStatus.permanentlyDenied) {
      if (!context.mounted) return false;
      _showPermissionDeniedBottomSheet(context, title: title, message: message);
    }
    return false;
  }

  static Future<bool> _checkPermmisionIsGranted(Permission permission) async {
    bool isGranted = await permission.isGranted;
    return isGranted;
  }

  static Future<void> _showPermissionDeniedBottomSheet(
    BuildContext context, {
    required String title,
    required String message,
  }) async {
    showDialog(
      context: context,
      builder: (context) {
        return PermissionDailog(title: title, message: message);
      },
    );
  }
}
