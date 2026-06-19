import 'package:vehicle_inspection_app/config/storage/draft_storage.dart';
import 'package:vehicle_inspection_app/feature/information/domain/entities/vehicle_inspection_form.dart';

class LoadDraftUsecase {
  final DraftStorage draftStorage;

  const LoadDraftUsecase(this.draftStorage);

  Future<VehicleInspectionForm?> call() async {
    final draft = await draftStorage.loadDraft();

    if (draft == null) return null;

    return draft;
  }
}
