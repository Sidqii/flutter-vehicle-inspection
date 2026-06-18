part of 'vehicle_bloc.dart';

sealed class VehicleEvent extends Equatable {
  const VehicleEvent();

  @override
  List<Object?> get props => [];
}

class PlateNumberEvent extends VehicleEvent {
  final String value;

  const PlateNumberEvent(this.value);

  @override
  List<Object?> get props => [value];
}

class KilometerEvent extends VehicleEvent {
  final int value;

  const KilometerEvent(this.value);

  @override
  List<Object?> get props => [value];
}

class ExteriorConditionEvent extends VehicleEvent {
  final ExteriorCondition value;

  const ExteriorConditionEvent(this.value);

  @override
  List<Object?> get props => [value];
}

class EngineConditionEvent extends VehicleEvent {
  final EngineCondition value;

  const EngineConditionEvent(this.value);

  @override
  List<Object?> get props => [value];
}

class MovementStatusEvent extends VehicleEvent {
  final MovementStatus value;

  const MovementStatusEvent(this.value);

  @override
  List<Object?> get props => [value];
}

class UnableReasonEvent extends VehicleEvent {
  final String value;

  const UnableReasonEvent(this.value);

  @override
  List<Object?> get props => [value];
}

class LocationEvent extends VehicleEvent {
  final double latitude;
  final double longitude;
  final String address;

  const LocationEvent({
    required this.latitude,
    required this.longitude,
    required this.address,
  });

  @override
  List<Object?> get props => [latitude, longitude, address];
}

class AddressNoteEvent extends VehicleEvent {
  final String value;

  const AddressNoteEvent(this.value);

  @override
  List<Object?> get props => [value];
}

class CurrentLocationEvent extends VehicleEvent {
  const CurrentLocationEvent();
}

class TakePhotoEvent extends VehicleEvent {
  final PhotoType valueType;

  const TakePhotoEvent(this.valueType);

  @override
  List<Object?> get props => [valueType];
}

class SignautrePadEvent extends VehicleEvent {
  final String path;

  const SignautrePadEvent(this.path);

  @override
  List<Object?> get props => [path];
}

class SubmitInspectionEvent extends VehicleEvent {
  const SubmitInspectionEvent();
}

class SaveDraftEvent extends VehicleEvent {
  const SaveDraftEvent();
}

class LoadDraftEvent extends VehicleEvent {
  const LoadDraftEvent();
}

class ClearDraftEvent extends VehicleEvent {
  const ClearDraftEvent();
}
