import 'package:vehicle_inspection_app/feature/vehicle_information/model/vehicle_inspection_form.dart';

class InputValidator {
  static String? validate(VehicleInspectionForm form) {
    final cannotBeMoved = form.movement.cannotBeMoved;
    final unableReason = form.movement.unableReason;

    if (form.information.plateNumber.isEmpty) {
      return 'Nomor polisi wajib diisi';
    }

    if (form.information.kilometer <= 0) {
      return 'Kilometer tidak valid';
    }

    if (!form.photos.isComplete) {
      return 'Semua foto wajib diisi';
    }

    if (!form.signature.hasSignature) {
      return 'Tanda tangan tidak boleh kosong';
    }

    if (cannotBeMoved && unableReason.length < 30) {
      return 'Alasan minimal 30 karakter';
    }

    return null;
  }
}
