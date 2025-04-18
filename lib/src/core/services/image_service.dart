import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yele/src/core/services/permission_service.dart';

class ImageService {
  static final ImagePicker _imagePicker = ImagePicker();

  static Future<File?> pickImage({
    required BuildContext context,
    required ImageSource source,
  }) async {
    late bool isGranted;
    if (source == ImageSource.gallery) {
      isGranted = await PermissionService.requestGalleryPermission(context);
    } else {
      isGranted = await PermissionService.requestCameraPermission(context);
    }
    if (!isGranted) return null;
    XFile? file = await _imagePicker.pickImage(source: source);
    if (file == null) return null;
    return File(file.path);
  }

  static Future<Uint8List?> pickImageAsUint8List({
    required BuildContext context,
    required ImageSource source,
  }) async {
    File? file = await pickImage(context: context, source: source);
    if (file == null) return null;
    final byte = file.readAsBytesSync();
    return byte;
  }

  static Future<String?> pickImageAsBase64({
    required BuildContext context,
    required ImageSource source,
  }) async {
    Uint8List? byte = await pickImageAsUint8List(
      context: context,
      source: source,
    );
    if (byte == null) return null;
    return base64Encode(byte);
  }

  static Future<List<File>> pickMultipleImage({
    required BuildContext context,
    double? maxHeight,
    double? maxWidth,
  }) async {
    bool isGranted = await PermissionService.requestGalleryPermission(context);
    if (!isGranted) return [];
    List<XFile> files = await _imagePicker.pickMultiImage(
      maxHeight: maxHeight,
      maxWidth: maxWidth,
    );
    return files.map((e) => File(e.path)).toList();
  }
}
