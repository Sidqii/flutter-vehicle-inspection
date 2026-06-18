import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vehicle_inspection_app/feature/vehicle_information/bloc/vehicle_bloc.dart';

class PlateTextField extends StatelessWidget {
  const PlateTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textCapitalization: TextCapitalization.characters,

      decoration: InputDecoration(
        labelText: 'Nomor Polisi',
        labelStyle: TextStyle(color: Colors.grey.shade900),

        hintText: 'B 12345 ABC',
        hintStyle: TextStyle(color: Colors.grey.shade500),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade500),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade800),
        ),
      ),

      onChanged: (value) {
        context.read<VehicleBloc>().add(PlateNumberEvent(value));
      },
    );
  }
}
