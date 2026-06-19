import 'package:equatable/equatable.dart';

class Signature extends Equatable {
  final String? path;

  const Signature({this.path});

  bool get hasSignature => path != null && path!.isNotEmpty;

  Signature copyWith({String? path}) {
    return Signature(path: path ?? this.path);
  }

  Map<String, dynamic> toJson() {
    return {'path': path};
  }

  factory Signature.fromJson(Map<String, dynamic> json) {
    return Signature(path: json['path']);
  }

  @override
  List<Object?> get props => [path];
}
