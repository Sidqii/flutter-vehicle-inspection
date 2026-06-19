import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vehicle_inspection_app/feature/information/presentation/bloc/vehicle_bloc.dart';
import 'package:vehicle_inspection_app/feature/information/presentation/pages/signature_pad_page.dart';

class SignatureNavigator extends StatelessWidget {
  const SignatureNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,

      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey.shade900,
          foregroundColor: Colors.white,

          disabledBackgroundColor: Colors.grey.shade900,
          disabledForegroundColor: Colors.white,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(10),
          ),
        ),

        onPressed: () async {
          final path = await Navigator.push<String>(
            context,
            MaterialPageRoute(builder: (context) => const SignaturePadPage()),
          );

          if (path == null) return;

          context.read<VehicleBloc>().add(SignaturePadEvent(path));
        },
        child: const Text('Buat tanda tangan'),
      ),
    );
  }
}
