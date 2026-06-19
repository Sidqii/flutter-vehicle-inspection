import 'package:equatable/equatable.dart';
import 'package:vehicle_inspection_app/feature/information/domain/enum/enum_movement.dart';

class Movement extends Equatable {
  final EnumMovement? status;
  final String unableReason;

  const Movement({this.status, this.unableReason = ''});

  bool get cannotBeMoved => status == EnumMovement.no;

  Movement copyWith({EnumMovement? status, String? unableReason}) {
    return Movement(
      status: status ?? this.status,
      unableReason: unableReason ?? this.unableReason,
    );
  }

  Map<String, dynamic> toJson() {
    return {'status': status?.name, 'unable_reason': unableReason};
  }

  factory Movement.fromJson(Map<String, dynamic> json) {
    return Movement(
      status: json['status'] == null
          ? null
          : EnumMovement.values.firstWhere(
              (element) => element.name == json['status'],
            ),
      unableReason: json['unable_reason'] ?? '',
    );
  }

  @override
  List<Object?> get props => [status, unableReason];
}
