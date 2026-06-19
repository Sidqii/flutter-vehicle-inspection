import 'package:equatable/equatable.dart';
import 'package:vehicle_inspection_app/feature/vehicle_information/model/form_format/information.dart';
import 'package:vehicle_inspection_app/feature/vehicle_information/model/form_format/base_location.dart';
import 'package:vehicle_inspection_app/feature/vehicle_information/model/form_format/movement.dart';
import 'package:vehicle_inspection_app/feature/vehicle_information/model/form_format/photos.dart';
import 'package:vehicle_inspection_app/feature/vehicle_information/model/form_format/signature.dart';

class VehicleInspectionForm extends Equatable {
  final Information information;
  final BaseLocation location;
  final Photos photos;
  final Movement movement;
  final Signature signature;
  final String additionalNote;

  const VehicleInspectionForm({
    this.information = const Information(),
    this.location = const BaseLocation(),
    this.photos = const Photos(),
    this.movement = const Movement(),
    this.signature = const Signature(),
    this.additionalNote = '',
  });

  VehicleInspectionForm copyWith({
    Information? information,
    BaseLocation? location,
    Photos? photos,
    Movement? movement,
    Signature? signature,
    String? additionalNote,
  }) {
    return VehicleInspectionForm(
      information: information ?? this.information,
      location: location ?? this.location,
      photos: photos ?? this.photos,
      movement: movement ?? this.movement,
      signature: signature ?? this.signature,
      additionalNote: additionalNote ?? this.additionalNote,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'information': information,
      'location': location,
      'photos': photos,
      'movement': movement,
      'signature': signature,
      'additional_note': additionalNote,
    };
  }

  factory VehicleInspectionForm.fromJson(Map<String, dynamic> json) {
    return VehicleInspectionForm(
      information: Information.fromJson(json['information']),
      location: BaseLocation.fromJson(json['location']),
      photos: Photos.fromJson(json['photos']),
      movement: Movement.fromJson(json['movement']),
      signature: Signature.fromJson(json['signature']),
      additionalNote: json['additional_note'],
    );
  }

  @override
  List<Object?> get props => [
    information,
    location,
    photos,
    movement,
    signature,
    additionalNote,
  ];
}
