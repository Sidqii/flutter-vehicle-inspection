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

  Map<String, dynamic> toJson() {
    return {
      'plate_number': plateNumber,
      'exterior_condition': exteriorCondition?.name,
      'engine_condition': engineCondition?.name,
      'kilometer': kilometer,
    };
  }

  factory VehicleInformation.fromJson(Map<String, dynamic> json) {
    return VehicleInformation(
      plateNumber: json['plate_number'] ?? '',
      exteriorCondition: json['exterior_condition'] == null
          ? null
          : ExteriorCondition.values.firstWhere(
              (element) => element.name == json['exterior_condition'],
            ),
      engineCondition: json['engine_condition'] == null
          ? null
          : EngineCondition.values.firstWhere(
              (element) => element.name == json['engine_condition'],
            ),
      kilometer: json['kilometer'] ?? 0,
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
