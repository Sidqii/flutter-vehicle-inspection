import 'package:vehicle_inspection_app/config/storage/draft_storage.dart';
import 'package:vehicle_inspection_app/feature/information/domain/entities/vehicle_inspection_form.dart';
import 'package:vehicle_inspection_app/feature/information/domain/validator/input_validator.dart';

class SubmitFormUsecase {
  final DraftStorage draftStorage;

  const SubmitFormUsecase(this.draftStorage);

  Future<String?> call(VehicleInspectionForm form) async {
    final error = InputValidator.validate(form);

    if (error != null) return error;

    await draftStorage.clearDraft();

    return null;
  }
}
