import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vehicle_inspection_app/feature/vehicle_information/bloc/vehicle_bloc.dart';
import 'package:vehicle_inspection_app/feature/vehicle_information/page/home_page.dart';
import 'package:vehicle_inspection_app/feature/vehicle_information/service/vehicle_location_service.dart';
import 'package:vehicle_inspection_app/feature/vehicle_information/service/vehicle_photo_service.dart';
import 'package:vehicle_inspection_app/shared/storage/vehicle_dratf_storage.dart';

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
            locationService: VehicleLocationService(),
            photoService: VehiclePhotoService(),
            dratfStorage: VehicleDratfStorage(),
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
