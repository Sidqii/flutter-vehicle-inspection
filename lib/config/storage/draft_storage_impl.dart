import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:vehicle_inspection_app/config/storage/draft_storage.dart';
import 'package:vehicle_inspection_app/feature/information/domain/entities/vehicle_inspection_form.dart';

class DraftStorageImpl implements DraftStorage {
  static const _draftKey = 'vehicle_inspection_draft';

  @override
  Future<void> saveDraft(VehicleInspectionForm form) async {
    final prefs = await SharedPreferences.getInstance();

    final jsonString = jsonEncode(form.toJson());

    await prefs.setString(_draftKey, jsonString);
  }

  @override
  Future<VehicleInspectionForm?> loadDraft() async {
    final prefs = await SharedPreferences.getInstance();

    final jsonString = prefs.getString(_draftKey);

    if (jsonString == null) return null;

    final json = jsonDecode(jsonString);

    return VehicleInspectionForm.fromJson(json);
  }

  @override
  Future<void> clearDraft() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_draftKey);
  }
}
