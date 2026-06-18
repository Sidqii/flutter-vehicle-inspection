import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vehicle_inspection_app/feature/vehicle_information/bloc/vehicle_bloc.dart';
import 'package:vehicle_inspection_app/feature/vehicle_information/model/form_format/vehicle_movement.dart';

class MovementTextField extends StatefulWidget {
  const MovementTextField({super.key});

  @override
  State<MovementTextField> createState() => _MovementTextFieldState();
}

class _MovementTextFieldState extends State<MovementTextField> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<VehicleBloc, VehicleState, VehicleMovement>(
      selector: (state) => state.form.movement,

      builder: (context, state) {
        if (!state.cannotBeMoved) {
          return SizedBox.shrink();
        }

        final text = state.unableReason;

        if (controller.text != text) {
          controller.text = text;

          controller.selection = TextSelection.collapsed(
            offset: controller.text.length,
          );
        }

        return TextFormField(
          controller: controller,

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
