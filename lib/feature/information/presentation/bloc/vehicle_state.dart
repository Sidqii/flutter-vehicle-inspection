part of 'vehicle_bloc.dart';

enum VehicleInspectionStatus { initial, loading, success, failure }

class VehicleState extends Equatable {
  final VehicleInspectionStatus status;
  final VehicleInspectionForm form;

  final String? message;

  const VehicleState({
    this.status = VehicleInspectionStatus.initial,
    this.form = const VehicleInspectionForm(),
    this.message,
  });

  VehicleState copyWith({
    VehicleInspectionStatus? status,
    VehicleInspectionForm? form,
    String? message,
  }) {
    return VehicleState(
      status: status ?? this.status,
      form: form ?? this.form,
      message: message,
    );
  }

  @override
  List<Object?> get props => [status, form, message];
}
