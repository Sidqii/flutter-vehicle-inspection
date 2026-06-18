import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vehicle_inspection_app/feature/vehicle_information/model/enum/engine_condition.dart';
import 'package:vehicle_inspection_app/feature/vehicle_information/model/enum/exterior_condition.dart';
import 'package:vehicle_inspection_app/feature/vehicle_information/model/enum/movement_status.dart';
import 'package:vehicle_inspection_app/feature/vehicle_information/model/enum/photo_type.dart';
import 'package:vehicle_inspection_app/feature/vehicle_information/model/form_format/vehicle_photo.dart';
import 'package:vehicle_inspection_app/feature/vehicle_information/model/form_format/vehicle_photos.dart';
import 'package:vehicle_inspection_app/feature/vehicle_information/model/validator/vehicle_validator.dart';
import 'package:vehicle_inspection_app/feature/vehicle_information/model/vehicle_inspection_form.dart';
import 'package:vehicle_inspection_app/feature/vehicle_information/service/vehicle_location_service.dart';
import 'package:vehicle_inspection_app/feature/vehicle_information/service/vehicle_photo_service.dart';
import 'package:vehicle_inspection_app/shared/storage/vehicle_dratf_storage.dart';

part 'vehicle_event.dart';
part 'vehicle_state.dart';

class VehicleBloc extends Bloc<VehicleEvent, VehicleState> {
  final VehicleLocationService locationService;
  final VehiclePhotoService photoService;
  final VehicleDratfStorage dratfStorage;

  VehicleBloc({
    required this.locationService,
    required this.photoService,
    required this.dratfStorage,
  }) : super(const VehicleState()) {
    on<PlateNumberEvent>(_plateEvent);
    on<KilometerEvent>(_kilometerEvent);
    on<ExteriorConditionEvent>(_exteriorEvent);
    on<EngineConditionEvent>(_engineEvent);
    on<MovementStatusEvent>(_movementStatusEvent);
    on<UnableReasonEvent>(_unableReasonEvent);
    on<LocationEvent>(_locationEvent);
    on<AddressNoteEvent>(_addressNoteEvent);
    on<CurrentLocationEvent>(_currentLocationEvent);
    on<TakePhotoEvent>(_takePhotoEvent);
    on<SignautrePadEvent>(_signaturePadEvent);
    on<SubmitInspectionEvent>(_submitInspectionEvent);
    on<SaveDraftEvent>(_saveDraftEvent);
    on<LoadDraftEvent>(_loadDraftEvent);
    on<ClearDraftEvent>(_clearDraftEvent);
  }

  void _plateEvent(PlateNumberEvent event, Emitter emit) {
    emit(
      state.copyWith(
        form: state.form.copyWith(
          information: state.form.information.copyWith(
            plateNumber: event.value,
          ),
        ),
      ),
    );
  }

  void _kilometerEvent(KilometerEvent event, Emitter emit) {
    emit(
      state.copyWith(
        form: state.form.copyWith(
          information: state.form.information.copyWith(kilometer: event.value),
        ),
      ),
    );
  }

  void _exteriorEvent(ExteriorConditionEvent event, Emitter emit) {
    emit(
      state.copyWith(
        form: state.form.copyWith(
          information: state.form.information.copyWith(
            exteriorCondition: event.value,
          ),
        ),
      ),
    );
  }

  void _engineEvent(EngineConditionEvent event, Emitter emit) {
    emit(
      state.copyWith(
        form: state.form.copyWith(
          information: state.form.information.copyWith(
            engineCondition: event.value,
          ),
        ),
      ),
    );
  }

  void _movementStatusEvent(MovementStatusEvent event, Emitter emit) {
    emit(
      state.copyWith(
        form: state.form.copyWith(
          movement: state.form.movement.copyWith(
            status: event.value,
            unableReason: event.value == MovementStatus.yes
                ? ''
                : state.form.movement.unableReason,
          ),
        ),
      ),
    );
  }

  void _unableReasonEvent(UnableReasonEvent event, Emitter emit) {
    emit(
      state.copyWith(
        form: state.form.copyWith(
          movement: state.form.movement.copyWith(unableReason: event.value),
        ),
      ),
    );
  }

  void _locationEvent(LocationEvent event, Emitter emit) {
    emit(
      state.copyWith(
        form: state.form.copyWith(
          location: state.form.location.copyWith(
            latitude: event.latitude,
            longitude: event.longitude,
            address: event.address,
          ),
        ),
      ),
    );
  }

  void _addressNoteEvent(AddressNoteEvent event, Emitter emit) {
    emit(
      state.copyWith(
        form: state.form.copyWith(
          location: state.form.location.copyWith(addressNote: event.value),
        ),
      ),
    );
  }

  Future<void> _currentLocationEvent(
    CurrentLocationEvent event,
    Emitter emit,
  ) async {
    final latitude = state.form.location.latitude;
    final longitude = state.form.location.longitude;

    if (latitude != null || longitude != null) {
      return;
    }

    try {
      emit(state.copyWith(status: VehicleInspectionStatus.loading));

      final location = await locationService.getCurrentLocation();

      emit(
        state.copyWith(
          status: VehicleInspectionStatus.initial,
          form: state.form.copyWith(location: location),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: VehicleInspectionStatus.failure,
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> _takePhotoEvent(TakePhotoEvent event, Emitter emit) async {
    try {
      final path = await photoService.takePhoto();

      if (path == null) return;

      final photo = VehiclePhoto(
        label: event.valueType.label,
        path: path,
        latitude: state.form.location.latitude,
        longitude: state.form.location.longitude,
        timeStamp: DateTime.now(),
        surveyorName: 'King qi`s burger',
      );

      final photos = state.form.photos;

      VehiclePhotos updatePhotos;

      switch (event.valueType) {
        case PhotoType.front:
          updatePhotos = photos.copyWith(front: photo);
          break;

        case PhotoType.back:
          updatePhotos = photos.copyWith(back: photo);
          break;

        case PhotoType.left:
          updatePhotos = photos.copyWith(left: photo);
          break;

        case PhotoType.right:
          updatePhotos = photos.copyWith(right: photo);
          break;

        case PhotoType.speedometer:
          updatePhotos = photos.copyWith(speedometer: photo);
          break;
      }

      emit(state.copyWith(form: state.form.copyWith(photos: updatePhotos)));
    } catch (e) {
      emit(
        state.copyWith(
          status: VehicleInspectionStatus.failure,
          message: e.toString(),
        ),
      );
    }
  }

  void _signaturePadEvent(SignautrePadEvent event, Emitter emit) {
    emit(
      state.copyWith(
        form: state.form.copyWith(
          signature: state.form.signature.copyWith(path: event.path),
        ),
      ),
    );
  }

  Future<void> _submitInspectionEvent(
    SubmitInspectionEvent event,
    Emitter emit,
  ) async {
    emit(
      state.copyWith(status: VehicleInspectionStatus.initial, message: null),
    );

    final error = VehicleValidator.validate(state.form);

    if (error != null) {
      emit(
        state.copyWith(status: VehicleInspectionStatus.failure, message: error),
      );

      return;
    }

    await dratfStorage.clearDraft();

    emit(state.copyWith(status: VehicleInspectionStatus.success));

    emit(const VehicleState());
  }

  Future<void> _saveDraftEvent(SaveDraftEvent event, Emitter emit) async {
    await dratfStorage.saveDraft(state.form);
  }

  Future<void> _loadDraftEvent(LoadDraftEvent event, Emitter emit) async {
    final draft = await dratfStorage.loadDraft();

    if (draft == null) return;

    emit(state.copyWith(form: draft));
  }

  Future<void> _clearDraftEvent(ClearDraftEvent event, Emitter emit) async {
    await dratfStorage.clearDraft();
  }
}
