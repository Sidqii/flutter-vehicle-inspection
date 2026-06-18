import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vehicle_inspection_app/feature/vehicle_information/bloc/vehicle_bloc.dart';

class KilometerTextField extends StatefulWidget {
  const KilometerTextField({super.key});

  @override
  State<KilometerTextField> createState() => _KilometerTextFieldState();
}

class _KilometerTextFieldState extends State<KilometerTextField> {
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
        final previous = prev.form.information.kilometer;
        final current = curr.form.information.kilometer;

        return previous != current;
      },

      listener: (context, state) {
        final kilometer = state.form.information.kilometer;

        final text = kilometer == 0 ? '' : kilometer.toString();

        if (controller.text == text) return;

        controller.text = text;

        controller.selection = TextSelection.collapsed(
          offset: controller.text.length,
        );
      },

      child: TextFormField(
        controller: controller,

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
      ),
    );
  }
}
