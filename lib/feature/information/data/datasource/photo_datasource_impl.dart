import 'package:image_picker/image_picker.dart';
import 'package:vehicle_inspection_app/feature/information/data/datasource/photo_datasource.dart';

class PhotoDatasourceImpl implements PhotoDatasource {
  final ImagePicker imagePicker;

  PhotoDatasourceImpl(this.imagePicker);

  @override
  Future<String?> takePhoto() async {
    final image = await imagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
      maxHeight: 120,
    );

    return image?.path;
  }
}
