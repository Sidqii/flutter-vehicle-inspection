enum PhotoType { front, back, left, right, speedometer }

extension PhotoTypeX on PhotoType {
  String get label {
    switch (this) {
      case PhotoType.front:
        return 'Depan';

      case PhotoType.back:
        return 'Belakang';

      case PhotoType.left:
        return 'Kiri';

      case PhotoType.right:
        return 'Kanan';

      case PhotoType.speedometer:
        return 'Speedometer';
    }
  }
}
