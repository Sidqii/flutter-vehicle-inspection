import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vehicle_inspection_app/feature/vehicle_information/bloc/vehicle_bloc.dart';

class KilometerTextField extends StatelessWidget {
  const KilometerTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Jarak tempuh',
        labelStyle: TextStyle(color: Colors.grey.shade900),

        hintText: '3000',
        hintStyle: TextStyle(color: Colors.grey.shade500),

        suffixText: 'KM',
        suffixStyle: TextStyle(color: Colors.grey.shade900),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade500),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade800),
        ),
      ),

      keyboardType: TextInputType.number,

      onChanged: (value) {
        final kilometer = int.tryParse(value) ?? 0;

        context.read<VehicleBloc>().add(KilometerEvent(kilometer));
      },
    );
  }
}
