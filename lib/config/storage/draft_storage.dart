import 'package:vehicle_inspection_app/feature/information/domain/entities/vehicle_inspection_form.dart';

abstract class DraftStorage {
  Future<void> saveDraft(VehicleInspectionForm form);

  Future<VehicleInspectionForm?> loadDraft();

  Future<void> clearDraft();
}
