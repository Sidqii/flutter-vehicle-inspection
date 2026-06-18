import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vehicle_inspection_app/feature/vehicle_information/bloc/vehicle_bloc.dart';
import 'package:vehicle_inspection_app/feature/vehicle_information/model/form_format/vehicle_signature.dart';
import 'package:vehicle_inspection_app/feature/vehicle_information/page/signature_pad_page.dart';

class SignaturePalete extends StatelessWidget {
  const SignaturePalete({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<VehicleBloc, VehicleState, VehicleSignature>(
      selector: (state) => state.form.signature,

      builder: (context, state) {
        return GestureDetector(
          behavior: HitTestBehavior.translucent,

          onTap: () async {
            final path = await Navigator.push<String>(
              context,
              MaterialPageRoute(builder: (context) => const SignaturePadPage()),
            );

            if (path == null) return;

            context.read<VehicleBloc>().add(SignautrePadEvent(path));
          },

          child: Container(
            width: double.infinity,
            height: 180,

            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade500),
              borderRadius: BorderRadius.circular(12),
            ),

            child: state.hasSignature
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(
                      File(state.path ?? ''),
                      fit: BoxFit.contain,
                    ),
                  )
                : const Center(child: Text('Belum ada tanda tangan')),
          ),
        );
      },
    );
  }
}
