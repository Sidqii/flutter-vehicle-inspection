import 'package:equatable/equatable.dart';

class VehicleLocation extends Equatable {
  final double? latitude;
  final double? longitude;
  final String address;
  final String addressNote;

  const VehicleLocation({
    this.latitude,
    this.longitude,
    this.address = '',
    this.addressNote = '',
  });

  VehicleLocation copyWith({
    double? latitude,
    double? longitude,
    String? address,
    String? addressNote,
  }) {
    return VehicleLocation(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      address: address ?? this.address,
      addressNote: addressNote ?? this.addressNote,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      'address_note': addressNote,
    };
  }

  factory VehicleLocation.fromJson(Map<String, dynamic> json) {
    return VehicleLocation(
      latitude: json['latitude'],
      longitude: json['longitude'],
      address: json['address'],
      addressNote: json['address_note'],
    );
  }

  @override
  List<Object?> get props => [latitude, longitude, address, addressNote];
}
