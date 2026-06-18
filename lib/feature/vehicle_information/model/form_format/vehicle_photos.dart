import 'package:equatable/equatable.dart';

class VehiclePhoto extends Equatable {
  final String label;
  final String path;
  final double? latitude;
  final double? longitude;
  final DateTime timeStamp;
  final String surveyorName;

  const VehiclePhoto({
    required this.label,
    required this.path,
    required this.latitude,
    required this.longitude,
    required this.timeStamp,
    required this.surveyorName,
  });

  @override
  List<Object?> get props => [
    label,
    path,
    latitude,
    longitude,
    timeStamp,
    surveyorName,
  ];
}

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

  bool get isComplete {
    return front != null &&
        back != null &&
        left != null &&
        right != null &&
        speedometer != null;
  }

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

  @override
  List<Object?> get props => [front, back, left, right, speedometer];
}
