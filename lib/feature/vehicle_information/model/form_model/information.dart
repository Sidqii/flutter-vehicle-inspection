import 'package:equatable/equatable.dart';
import 'package:vehicle_inspection_app/feature/vehicle_information/model/enum/enum_engine.dart';
import 'package:vehicle_inspection_app/feature/vehicle_information/model/enum/enum_exterior.dart';

class Information extends Equatable {
  final String plateNumber;
  final EnumExterior? exteriorCondition;
  final EnumEngine? engineCondition;
  final int kilometer;

  const Information({
    this.plateNumber = '',
    this.exteriorCondition,
    this.engineCondition,
    this.kilometer = 0,
  });

  Information copyWith({
    String? plateNumber,
    EnumExterior? exteriorCondition,
    EnumEngine? engineCondition,
    int? kilometer,
  }) {
    return Information(
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

  factory Information.fromJson(Map<String, dynamic> json) {
    return Information(
      plateNumber: json['plate_number'] ?? '',
      exteriorCondition: json['exterior_condition'] == null
          ? null
          : EnumExterior.values.firstWhere(
              (element) => element.name == json['exterior_condition'],
            ),
      engineCondition: json['engine_condition'] == null
          ? null
          : EnumEngine.values.firstWhere(
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
