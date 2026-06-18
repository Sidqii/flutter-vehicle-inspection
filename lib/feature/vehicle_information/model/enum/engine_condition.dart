enum EngineCondition { normal, abnormal, off }

extension EngineConditionX on EngineCondition {
  String get label {
    switch (this) {
      case EngineCondition.normal:
        return 'Hidup Normal';

      case EngineCondition.abnormal:
        return 'Hidup Tidak Normal';

      case EngineCondition.off:
        return 'Mati';
    }
  }
}
