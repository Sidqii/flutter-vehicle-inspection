import 'package:vehicle_inspection_app/config/storage/draft_storage.dart';
import 'package:vehicle_inspection_app/feature/information/domain/entities/vehicle_inspection_form.dart';

class SaveDraftUsecase {
  final DraftStorage draftStorage;

  const SaveDraftUsecase(this.draftStorage);

  Future<void> call(VehicleInspectionForm form) async {
    return draftStorage.saveDraft(form);
  }
}