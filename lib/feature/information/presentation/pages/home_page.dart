import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vehicle_inspection_app/feature/information/presentation/bloc/vehicle_bloc.dart';
import 'package:vehicle_inspection_app/feature/information/presentation/widgets/button/current_location.dart';
import 'package:vehicle_inspection_app/feature/information/presentation/widgets/button/submit_form.dart';
import 'package:vehicle_inspection_app/feature/information/presentation/widgets/button/take_photo.dart';
import 'package:vehicle_inspection_app/feature/information/presentation/widgets/dropdown/engine_dropdown.dart';
import 'package:vehicle_inspection_app/feature/information/presentation/widgets/dropdown/exterior_dropdown.dart';
import 'package:vehicle_inspection_app/feature/information/presentation/widgets/dropdown/movement_dropdown.dart';
import 'package:vehicle_inspection_app/feature/information/presentation/widgets/palete/location_palete.dart';
import 'package:vehicle_inspection_app/feature/information/presentation/widgets/palete/photo_checklist_palete.dart';
import 'package:vehicle_inspection_app/feature/information/presentation/widgets/palete/signature_palete.dart';
import 'package:vehicle_inspection_app/feature/information/presentation/widgets/textfield/address_text_field.dart';
import 'package:vehicle_inspection_app/feature/information/presentation/widgets/textfield/kilometer_text_field.dart';
import 'package:vehicle_inspection_app/feature/information/presentation/widgets/textfield/plate_text_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const titleStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w300,
  );

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Timer? autoSaveTimer;

  @override
  void initState() {
    super.initState();

    context.read<VehicleBloc>().add(const LoadDraftEvent());

    autoSaveTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      context.read<VehicleBloc>().add(const SaveDraftEvent());
    });
  }

  @override
  void dispose() {
    autoSaveTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<VehicleBloc, VehicleState>(
      listenWhen: (prev, curr) {
        return prev.status != curr.status || prev.message != curr.message;
      },

      listener: (context, state) {
        final failure = VehicleInspectionStatus.failure;
        final message = state.message;

        if (state.status == failure && message != null && message.isNotEmpty) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(state.message ?? '404 Error not found')),
            );
        }

        if (state.status == VehicleInspectionStatus.success) {
          context.read<VehicleBloc>().add(ClearFormEvent());

          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text('Sukses submit form')));
        }
      },

      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsetsGeometry.all(20),

            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 15,

                children: [
                  Text.rich(
                    TextSpan(
                      style: HomePage.titleStyle,
                      children: [
                        TextSpan(
                          text: 'Informasi dasar ',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),

                        TextSpan(text: 'kendaraan'),
                      ],
                    ),
                  ),

                  PlateTextField(),

                  KilometerTextField(),

                  Text.rich(
                    TextSpan(
                      style: HomePage.titleStyle,
                      children: [
                        TextSpan(
                          text: 'Informasi kondisi ',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),

                        TextSpan(text: 'kendaraan'),
                      ],
                    ),
                  ),

                  ExteriorDropdown(),

                  EngineDropdown(),

                  MovementDropdown(),

                  Text.rich(
                    TextSpan(
                      style: HomePage.titleStyle,
                      children: [
                        TextSpan(
                          text: 'Informasi lokasi ',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),

                        TextSpan(text: 'kendaraan'),
                      ],
                    ),
                  ),

                  LocationPalete(),

                  AddressTextField(),

                  CurrentLocation(),

                  Text.rich(
                    TextSpan(
                      style: HomePage.titleStyle,
                      children: [
                        TextSpan(
                          text: 'Informasi foto ',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),

                        TextSpan(text: 'kendaraan'),
                      ],
                    ),
                  ),

                  PhotoChecklistPalete(),

                  Text.rich(
                    TextSpan(
                      style: HomePage.titleStyle,
                      children: [
                        TextSpan(
                          text: 'Informasi kepemilikan ',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),

                        TextSpan(text: 'kendaraan'),
                      ],
                    ),
                  ),

                  SignaturePalete(),

                  SubmitForm(),
                ],
              ),
            ),
          ),
        ),

        floatingActionButton: TakePhoto(),
      ),
    );
  }
}
