import 'package:vehicle_inspection_app/config/storage/draft_storage.dart';

class ClearDraftUsecase {
  final DraftStorage draftStorage;

  const ClearDraftUsecase(this.draftStorage);

  Future<void> call() async {
    return draftStorage.clearDraft();
  }
}
