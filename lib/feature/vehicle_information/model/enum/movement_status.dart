enum MovementStatus { yes, no }

extension MovementStatusX on MovementStatus {
  String get label {
    switch (this) {
      case MovementStatus.yes:
        return 'Ya';

      case MovementStatus.no:
        return 'Tidak';
    }
  }
}
