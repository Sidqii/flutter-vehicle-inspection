enum EnumMovement { yes, no }

extension EnumMovementX on EnumMovement {
  String get label {
    switch (this) {
      case EnumMovement.yes:
        return 'Ya';

      case EnumMovement.no:
        return 'Tidak';
    }
  }
}
