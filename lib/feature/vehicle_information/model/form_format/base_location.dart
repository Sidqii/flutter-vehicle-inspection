import 'package:equatable/equatable.dart';

class BaseLocation extends Equatable {
  final double? latitude;
  final double? longitude;
  final String address;
  final String addressNote;

  const BaseLocation({
    this.latitude,
    this.longitude,
    this.address = '',
    this.addressNote = '',
  });

  BaseLocation copyWith({
    double? latitude,
    double? longitude,
    String? address,
    String? addressNote,
  }) {
    return BaseLocation(
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

  factory BaseLocation.fromJson(Map<String, dynamic> json) {
    return BaseLocation(
      latitude: json['latitude'],
      longitude: json['longitude'],
      address: json['address'],
      addressNote: json['address_note'],
    );
  }

  @override
  List<Object?> get props => [latitude, longitude, address, addressNote];
}
