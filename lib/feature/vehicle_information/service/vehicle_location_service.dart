import 'dart:async';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:vehicle_inspection_app/feature/vehicle_information/model/form_model/base_location.dart';

class VehicleLocationService {
  Future<bool> _handlerPermission() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return false;
    }

    var permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    final always = LocationPermission.always;
    final whileInUse = LocationPermission.whileInUse;

    return permission == always || permission == whileInUse;
  }

  Future<String> _getAddress(double latitude, double longitude) async {
    final placement = await placemarkFromCoordinates(latitude, longitude);

    if (placement.isEmpty) {
      return '';
    }

    final place = placement.first;

    return [
          place.street,
          place.subLocality,
          place.locality,
          place.subAdministrativeArea,
          place.administrativeArea,
          place.country,
        ]
        .where((element) {
          return element != null && element.isNotEmpty;
        })
        .join(', ');
  }

  Future<BaseLocation> getCurrentLocation() async {
    final permission = await _handlerPermission();

    if (!permission) {
      throw Exception('Location permission denied');
    }

    final position = await Geolocator.getCurrentPosition(
      locationSettings: AndroidSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 0,
      ),
    );

    final address = await _getAddress(position.latitude, position.longitude);

    return BaseLocation(
      latitude: position.latitude,
      longitude: position.longitude,
      address: address,
    );
  }
}
