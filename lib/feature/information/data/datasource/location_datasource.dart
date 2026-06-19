import 'package:vehicle_inspection_app/feature/information/domain/entities/base_location.dart';

abstract class LocationDatasource {
  Future<BaseLocation> getCurrentLocation();
}