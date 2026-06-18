import 'package:equatable/equatable.dart';
import 'package:vehicle_inspection_app/feature/vehicle_information/model/form_format/vehicle_information.dart';
import 'package:vehicle_inspection_app/feature/vehicle_information/model/form_format/vehicle_location.dart';
import 'package:vehicle_inspection_app/feature/vehicle_information/model/form_format/vehicle_movement.dart';
import 'package:vehicle_inspection_app/feature/vehicle_information/model/form_format/vehicle_photos.dart';
import 'package:vehicle_inspection_app/feature/vehicle_information/model/form_format/vehicle_signature.dart';

class VehicleInspectionForm extends Equatable {
  final VehicleInformation information;
  final VehicleLocation location;
  final VehiclePhotos photos;
  final VehicleMovement movement;
  final VehicleSignature signature;
  final String additionalNote;

  const VehicleInspectionForm({
    this.information = const VehicleInformation(),
    this.location = const VehicleLocation(),
    this.photos = const VehiclePhotos(),
    this.movement = const VehicleMovement(),
    this.signature = const VehicleSignature(),
    this.additionalNote = '',
  });

  VehicleInspectionForm copyWith({
    VehicleInformation? information,
    VehicleLocation? location,
    VehiclePhotos? photos,
    VehicleMovement? movement,
    VehicleSignature? signature,
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
