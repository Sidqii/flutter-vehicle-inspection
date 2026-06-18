import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vehicle_inspection_app/feature/vehicle_information/bloc/vehicle_bloc.dart';

class PlateTextField extends StatefulWidget {
  const PlateTextField({super.key});

  @override
  State<PlateTextField> createState() => _PlateTextFieldState();
}

class _PlateTextFieldState extends State<PlateTextField> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<VehicleBloc, VehicleState>(
      listenWhen: (prev, curr) {
        final previous = prev.form.information.plateNumber;
        final current = curr.form.information.plateNumber;

        return previous != current;
      },

      listener: (context, state) {
        final plateNumber = state.form.information.plateNumber;

        if (controller.text == plateNumber) return;

        controller.text = plateNumber;

        controller.selection = TextSelection.collapsed(
          offset: controller.text.length,
        );
      },

      child: TextFormField(
        controller: controller,

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
      ),
    );
  }
}
