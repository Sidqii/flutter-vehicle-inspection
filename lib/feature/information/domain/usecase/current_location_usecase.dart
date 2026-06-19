import 'package:vehicle_inspection_app/feature/information/data/datasource/location_datasource.dart';
import 'package:vehicle_inspection_app/feature/information/domain/entities/base_location.dart';

class CurrentLocationUsecase {
  final LocationDatasource locationDatasource;

  const CurrentLocationUsecase(this.locationDatasource);

  Future<BaseLocation> call() async {
    return locationDatasource.getCurrentLocation();
  }
}
