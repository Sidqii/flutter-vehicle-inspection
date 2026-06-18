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

  Map<String, dynamic> toJson() {
    return {'status': status?.name, 'unable_reason': unableReason};
  }

  factory VehicleMovement.fromJson(Map<String, dynamic> json) {
    return VehicleMovement(
      status: json['status'] == null
          ? null
          : MovementStatus.values.firstWhere(
              (element) => element.name == json['status'],
            ),
      unableReason: json['unable_reason'] ?? '',
    );
  }

  @override
  List<Object?> get props => [status, unableReason];
}
