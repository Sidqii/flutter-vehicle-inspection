import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vehicle_inspection_app/feature/vehicle_information/bloc/vehicle_bloc.dart';
import 'package:vehicle_inspection_app/feature/vehicle_information/model/form_format/vehicle_movement.dart';

class MovementTextField extends StatelessWidget {
  const MovementTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<VehicleBloc, VehicleState, VehicleMovement>(
      selector: (state) => state.form.movement,

      builder: (context, state) {
        if (!state.cannotBeMoved) {
          return SizedBox.shrink();
        }

        return TextFormField(
          maxLines: 3,

          textCapitalization: TextCapitalization.sentences,

          decoration: InputDecoration(
            labelText: 'Alasan tidak bisa dipindahkan',
            labelStyle: TextStyle(color: Colors.grey.shade900),

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
            context.read<VehicleBloc>().add(UnableReasonEvent(value));
          },
        );
      },
    );
  }
}
