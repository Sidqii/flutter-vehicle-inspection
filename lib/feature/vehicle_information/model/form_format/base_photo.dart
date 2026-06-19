import 'package:equatable/equatable.dart';

class BasePhoto extends Equatable {
  final String label;
  final String path;
  final double? latitude;
  final double? longitude;
  final DateTime timeStamp;
  final String surveyorName;

  const BasePhoto({
    required this.label,
    required this.path,
    required this.latitude,
    required this.longitude,
    required this.timeStamp,
    required this.surveyorName,
  });

  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'path': path,
      'latitude': latitude,
      'longitude': longitude,
      'time_stamp': timeStamp.toIso8601String(),
      'surveyor_name': surveyorName,
    };
  }

  factory BasePhoto.fromJson(Map<String, dynamic> json) {
    return BasePhoto(
      label: json['label'],
      path: json['path'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      timeStamp: DateTime.parse(json['time_stamp']),
      surveyorName: json['surveyor_name'],
    );
  }

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
