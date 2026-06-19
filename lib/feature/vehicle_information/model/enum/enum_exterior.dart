enum EnumExterior { good, lightScratch, damaged, severelyDamaged }

extension EnumExteriorX on EnumExterior {
  String get label {
    switch (this) {
      case EnumExterior.good:
        return 'Baik';

      case EnumExterior.lightScratch:
        return 'Lecet Ringan';

      case EnumExterior.damaged:
        return 'Rusak';

      case EnumExterior.severelyDamaged:
        return 'Sangat Rusak';
    }
  }
}
