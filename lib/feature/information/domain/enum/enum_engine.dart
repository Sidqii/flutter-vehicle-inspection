enum EnumEngine { normal, abnormal, off }

extension EnumEngineX on EnumEngine {
  String get label {
    switch (this) {
      case EnumEngine.normal:
        return 'Hidup Normal';

      case EnumEngine.abnormal:
        return 'Hidup Tidak Normal';

      case EnumEngine.off:
        return 'Mati';
    }
  }
}
