import 'package:equatable/equatable.dart';
import 'package:vehicle_inspection_app/feature/information/domain/enum/enum_photo.dart';
import 'package:vehicle_inspection_app/feature/information/domain/entities/base_photo.dart';

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

  BasePhoto? getByType(EnumPhoto type) {
    switch (type) {
      case EnumPhoto.front:
        return front;

      case EnumPhoto.back:
        return back;

      case EnumPhoto.left:
        return left;

      case EnumPhoto.right:
        return right;

      case EnumPhoto.speedometer:
        return speedometer;
    }
  }

  Photos updateByType(EnumPhoto type, BasePhoto photo) {
    switch (type) {
      case EnumPhoto.front:
        return copyWith(front: photo);

      case EnumPhoto.back:
        return copyWith(back: photo);

      case EnumPhoto.left:
        return copyWith(left: photo);

      case EnumPhoto.right:
        return copyWith(right: photo);

      case EnumPhoto.speedometer:
        return copyWith(speedometer: photo);
    }
  }

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
      front: json['front'] == null ? null : BasePhoto.fromJson(json['front']),

      back: json['back'] == null ? null : BasePhoto.fromJson(json['back']),

      left: json['left'] == null ? null : BasePhoto.fromJson(json['left']),

      right: json['right'] == null ? null : BasePhoto.fromJson(json['right']),

      speedometer: json['speedometer'] == null
          ? null
          : BasePhoto.fromJson(json['speedometer']),
    );
  }

  @override
  List<Object?> get props => [front, back, left, right, speedometer];
}
