import 'package:equatable/equatable.dart';
import 'package:vehicle_inspection_app/feature/vehicle_information/model/enum/engine_condition.dart';
import 'package:vehicle_inspection_app/feature/vehicle_information/model/enum/exterior_condition.dart';

class VehicleInformation extends Equatable {
  final String plateNumber;
  final ExteriorCondition? exteriorCondition;
  final EngineCondition? engineCondition;
  final int kilometer;

  const VehicleInformation({
    this.plateNumber = '',
    this.exteriorCondition,
    this.engineCondition,
    this.kilometer = 0,
  });

  VehicleInformation copyWith({
    String? plateNumber,
    ExteriorCondition? exteriorCondition,
    EngineCondition? engineCondition,
    int? kilometer,
  }) {
    return VehicleInformation(
      plateNumber: plateNumber ?? this.plateNumber,
      exteriorCondition: exteriorCondition ?? this.exteriorCondition,
      engineCondition: engineCondition ?? this.engineCondition,
      kilometer: kilometer ?? this.kilometer,
    );
  }

  @override
  List<Object?> get props => [
    plateNumber,
    exteriorCondition,
    engineCondition,
    kilometer,
  ];
}
