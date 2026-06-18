enum ExteriorCondition { good, lightScratch, damaged, severelyDamaged }

extension ExteriorConditionX on ExteriorCondition {
  String get label {
    switch (this) {
      case ExteriorCondition.good:
        return 'Baik';

      case ExteriorCondition.lightScratch:
        return 'Lecet Ringan';

      case ExteriorCondition.damaged:
        return 'Rusak';

      case ExteriorCondition.severelyDamaged:
        return 'Sangat Rusak';
    }
  }
}
