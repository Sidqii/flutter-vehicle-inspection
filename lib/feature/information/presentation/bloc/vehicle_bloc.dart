import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vehicle_inspection_app/feature/information/domain/enum/enum_engine.dart';
import 'package:vehicle_inspection_app/feature/information/domain/enum/enum_exterior.dart';
import 'package:vehicle_inspection_app/feature/information/domain/enum/enum_movement.dart';
import 'package:vehicle_inspection_app/feature/information/domain/enum/enum_photo.dart';
import 'package:vehicle_inspection_app/feature/information/domain/usecase/clear_draft_usecase.dart';
import 'package:vehicle_inspection_app/feature/information/domain/usecase/current_location_usecase.dart';
import 'package:vehicle_inspection_app/feature/information/domain/usecase/load_draft_usecase.dart';
import 'package:vehicle_inspection_app/feature/information/domain/usecase/save_draft_usecase.dart';
import 'package:vehicle_inspection_app/feature/information/domain/usecase/submit_form_usecase.dart';
import 'package:vehicle_inspection_app/feature/information/domain/usecase/take_photo_usecase.dart';
import 'package:vehicle_inspection_app/feature/information/domain/entities/vehicle_inspection_form.dart';

part 'vehicle_event.dart';
part 'vehicle_state.dart';

class VehicleBloc extends Bloc<VehicleEvent, VehicleState> {
  final CurrentLocationUsecase locationUsecase;
  final TakePhotoUsecase photoUsecase;
  final SubmitFormUsecase submitUsecase;
  final SaveDraftUsecase saveUsecase;
  final LoadDraftUsecase loadUsecase;
  final ClearDraftUsecase clearUsecase;

  VehicleBloc({
    required this.locationUsecase,
    required this.photoUsecase,
    required this.submitUsecase,
    required this.saveUsecase,
    required this.loadUsecase,
    required this.clearUsecase,
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
    on<SignaturePadEvent>(_signaturePadEvent);
    on<SubmitInspectionEvent>(_submitInspectionEvent);
    on<SaveDraftEvent>(_saveDraftEvent);
    on<LoadDraftEvent>(_loadDraftEvent);
    on<ClearDraftEvent>(_clearDraftEvent);

    on<ClearFormEvent>((event, emit) => emit(const VehicleState()));
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
            unableReason: event.value == EnumMovement.yes
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

      final location = await locationUsecase.call();

      emit(
        state.copyWith(
          status: VehicleInspectionStatus.initial,
          form: state.form.copyWith(
            location: state.form.location.copyWith(
              latitude: location.latitude,
              longitude: location.longitude,
              address: location.address,
            ),
          ),
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
      final photo = await photoUsecase.call(
        photoType: event.valueType,
        photoLocation: state.form.location,
      );

      if (photo == null) return;

      final updatePhotos = state.form.photos.updateByType(
        event.valueType,
        photo,
      );

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

  void _signaturePadEvent(SignaturePadEvent event, Emitter emit) {
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

    final error = await submitUsecase.call(state.form);

    if (error != null) {
      emit(
        state.copyWith(status: VehicleInspectionStatus.failure, message: error),
      );

      return;
    }

    emit(const VehicleState(status: VehicleInspectionStatus.success));
  }

  Future<void> _saveDraftEvent(SaveDraftEvent event, Emitter emit) async {
    await saveUsecase.call(state.form);
  }

  Future<void> _loadDraftEvent(LoadDraftEvent event, Emitter emit) async {
    final draft = await loadUsecase.call();

    emit(state.copyWith(form: draft));
  }

  Future<void> _clearDraftEvent(ClearDraftEvent event, Emitter emit) async {
    await clearUsecase.call();
  }
}
