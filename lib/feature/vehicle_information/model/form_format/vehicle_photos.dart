import 'package:equatable/equatable.dart';
import 'package:vehicle_inspection_app/feature/vehicle_information/model/form_format/vehicle_photo.dart';

class VehiclePhotos extends Equatable {
  final VehiclePhoto? front;
  final VehiclePhoto? back;
  final VehiclePhoto? left;
  final VehiclePhoto? right;
  final VehiclePhoto? speedometer;

  const VehiclePhotos({
    this.front,
    this.back,
    this.left,
    this.right,
    this.speedometer,
  });

  bool get isComplete => [
    front,
    back,
    right,
    left,
    speedometer,
  ].every((element) => element != null);

  VehiclePhotos copyWith({
    VehiclePhoto? front,
    VehiclePhoto? back,
    VehiclePhoto? left,
    VehiclePhoto? right,
    VehiclePhoto? speedometer,
  }) {
    return VehiclePhotos(
      front: front ?? this.front,
      back: back ?? this.back,
      left: left ?? this.left,
      right: right ?? this.right,
      speedometer: speedometer ?? this.speedometer,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'front': front?.toJson(),
      'back': back?.toJson(),
      'left': left?.toJson(),
      'right': right?.toJson(),
      'speedometer': speedometer?.toJson(),
    };
  }

  factory VehiclePhotos.fromJson(Map<String, dynamic> json) {
    return VehiclePhotos(
      front: json['front'] == null
          ? null
          : VehiclePhoto.fromJson(json['front']),

      back: json['back'] == null ? null : VehiclePhoto.fromJson(json['back']),

      left: json['left'] == null ? null : VehiclePhoto.fromJson(json['left']),

      right: json['right'] == null
          ? null
          : VehiclePhoto.fromJson(json['right']),

      speedometer: json['speedometer'] == null
          ? null
          : VehiclePhoto.fromJson(json['speedometer']),
    );
  }

  @override
  List<Object?> get props => [front, back, left, right, speedometer];
}
