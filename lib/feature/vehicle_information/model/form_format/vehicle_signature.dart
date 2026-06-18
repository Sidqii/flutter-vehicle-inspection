import 'package:equatable/equatable.dart';

class VehicleSignature extends Equatable {
  final String? path;

  const VehicleSignature({this.path});

  bool get hasSignature => path != null && path!.isNotEmpty;

  VehicleSignature copyWith({String? path}) {
    return VehicleSignature(path: path ?? this.path);
  }

  Map<String, dynamic> toJson() {
    return {'path': path};
  }

  factory VehicleSignature.fromJson(Map<String, dynamic> json) {
    return VehicleSignature(path: json['path']);
  }

  @override
  List<Object?> get props => [path];
}
