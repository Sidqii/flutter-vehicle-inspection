import 'package:equatable/equatable.dart';
import 'package:vehicle_inspection_app/feature/vehicle_information/model/form_format/base_photo.dart';

class Photos extends Equatable {
  final BasePhoto? front;
  final BasePhoto? back;
  final BasePhoto? left;
  final BasePhoto? right;
  final BasePhoto? speedometer;

  const Photos({
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

  Photos copyWith({
    BasePhoto? front,
    BasePhoto? back,
    BasePhoto? left,
    BasePhoto? right,
    BasePhoto? speedometer,
  }) {
    return Photos(
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

  factory Photos.fromJson(Map<String, dynamic> json) {
    return Photos(
      front: json['front'] == null
          ? null
          : BasePhoto.fromJson(json['front']),

      back: json['back'] == null ? null : BasePhoto.fromJson(json['back']),

      left: json['left'] == null ? null : BasePhoto.fromJson(json['left']),

      right: json['right'] == null
          ? null
          : BasePhoto.fromJson(json['right']),

      speedometer: json['speedometer'] == null
          ? null
          : BasePhoto.fromJson(json['speedometer']),
    );
  }

  @override
  List<Object?> get props => [front, back, left, right, speedometer];
}
