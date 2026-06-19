import 'package:vehicle_inspection_app/feature/information/data/datasource/photo_datasource.dart';
import 'package:vehicle_inspection_app/feature/information/domain/entities/base_location.dart';
import 'package:vehicle_inspection_app/feature/information/domain/entities/base_photo.dart';
import 'package:vehicle_inspection_app/feature/information/domain/enum/enum_photo.dart';

class TakePhotoUsecase {
  final PhotoDatasource photoDatasource;

  const TakePhotoUsecase(this.photoDatasource);

  Future<BasePhoto?> call({
    required EnumPhoto photoType,
    required BaseLocation photoLocation,
  }) async {
    final path = await photoDatasource.takePhoto();

    if (path == null) return null;

    return BasePhoto(
      label: photoType.label,
      path: path,
      latitude: photoLocation.latitude,
      longitude: photoLocation.longitude,
      timeStamp: DateTime.now(),
      surveyorName: 'King Qii\'s burger',
    );
  }
}
