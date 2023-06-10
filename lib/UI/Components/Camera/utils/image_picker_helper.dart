import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImagePickerHelper {
  const ImagePickerHelper._();

  static final ImagePicker _imagePicker = ImagePicker();

  static Future<File?> pickImage(ImageSource imageSource) async {
    final pickedImage = await _imagePicker.pickImage(
      source: imageSource,
      preferredCameraDevice: CameraDevice.front,
    );

    if (pickedImage != null) {
      return File(pickedImage.path);
    }
    return null;
  }
}
