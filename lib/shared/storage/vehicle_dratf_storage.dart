import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:vehicle_inspection_app/feature/vehicle_information/model/vehicle_inspection_form.dart';

class VehicleDratfStorage {
  static const _draftKey = 'vehicle_inspection_draft';

  Future<void> saveDraft(VehicleInspectionForm form) async {
    final prefs = await SharedPreferences.getInstance();

    final jsonString = jsonEncode(form.toJson());

    await prefs.setString(_draftKey, jsonString);
  }

  Future<VehicleInspectionForm?> loadDraft() async {
    final prefs = await SharedPreferences.getInstance();

    final jsonString = prefs.getString(_draftKey);

    if (jsonString == null) return null;

    final json = jsonDecode(jsonString);

    return VehicleInspectionForm.fromJson(json);
  }

  Future<void> clearDraft() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_draftKey);
  }
}
