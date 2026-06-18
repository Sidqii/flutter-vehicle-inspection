import 'package:equatable/equatable.dart';
import 'package:vehicle_inspection_app/feature/vehicle_information/model/enum/movement_status.dart';

class VehicleMovement extends Equatable {
  final MovementStatus? status;
  final String unableReason;

  const VehicleMovement({this.status, this.unableReason = ''});

  bool get cannotBeMoved => status == MovementStatus.no;

  VehicleMovement copyWith({MovementStatus? status, String? unableReason}) {
    return VehicleMovement(
      status: status ?? this.status,
      unableReason: unableReason ?? this.unableReason,
    );
  }

  @override
  List<Object?> get props => [status, unableReason];
}
