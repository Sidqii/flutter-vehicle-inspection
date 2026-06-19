enum EnumPhoto { front, back, left, right, speedometer }

extension EnumPhotoX on EnumPhoto {
  String get label {
    switch (this) {
      case EnumPhoto.front:
        return 'Depan';

      case EnumPhoto.back:
        return 'Belakang';

      case EnumPhoto.left:
        return 'Kiri';

      case EnumPhoto.right:
        return 'Kanan';

      case EnumPhoto.speedometer:
        return 'Speedometer';
    }
  }
}
