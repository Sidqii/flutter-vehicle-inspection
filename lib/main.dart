import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vehicle_inspection_app/feature/information/data/datasource/location_datasource_impl.dart';
import 'package:vehicle_inspection_app/feature/information/data/datasource/photo_datasource_impl.dart';
import 'package:vehicle_inspection_app/feature/information/domain/usecase/clear_draft_usecase.dart';
import 'package:vehicle_inspection_app/feature/information/domain/usecase/current_location_usecase.dart';
import 'package:vehicle_inspection_app/feature/information/domain/usecase/load_draft_usecase.dart';
import 'package:vehicle_inspection_app/feature/information/domain/usecase/save_draft_usecase.dart';
import 'package:vehicle_inspection_app/feature/information/domain/usecase/submit_form_usecase.dart';
import 'package:vehicle_inspection_app/feature/information/domain/usecase/take_photo_usecase.dart';
import 'package:vehicle_inspection_app/feature/information/presentation/bloc/vehicle_bloc.dart';
import 'package:vehicle_inspection_app/feature/information/presentation/pages/home_page.dart';
import 'package:vehicle_inspection_app/config/storage/draft_storage_impl.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) {
          return VehicleBloc(
            locationUsecase: CurrentLocationUsecase(LocationDatasourceImpl()),
            photoUsecase: TakePhotoUsecase(PhotoDatasourceImpl(ImagePicker())),
            submitUsecase: SubmitFormUsecase(DraftStorageImpl()),
            saveUsecase: SaveDraftUsecase(DraftStorageImpl()),
            loadUsecase: LoadDraftUsecase(DraftStorageImpl()),
            clearUsecase: ClearDraftUsecase(DraftStorageImpl()),
          );
        },
        child: const HomePage(),
      ),

      builder: (context, child) => GestureDetector(
        behavior: HitTestBehavior.translucent,

        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),

        child: child!,
      ),
    );
  }
}
