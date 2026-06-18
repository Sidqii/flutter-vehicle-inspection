import 'package:image_picker/image_picker.dart';

class VehiclePhotoService {
  final ImagePicker picker;

  VehiclePhotoService({ImagePicker? picker}) : picker = picker ?? ImagePicker();

  Future<String?> takePhoto() async {
    final image = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
      maxWidth: 1280,
    );

    return image?.path;
  }
}
