import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vehicle_inspection_app/feature/vehicle_information/bloc/vehicle_bloc.dart';

class AddressTextField extends StatefulWidget {
  const AddressTextField({super.key});

  @override
  State<AddressTextField> createState() => _AddressTextFieldState();
}

class _AddressTextFieldState extends State<AddressTextField> {
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
        final previous = prev.form.location.addressNote;
        final current = curr.form.location.addressNote;

        return previous != current;
      },

      listener: (context, state) {
        final addressNote = state.form.location.addressNote;

        if (controller.text == addressNote) return;

        controller.text = addressNote;

        controller.selection = TextSelection.collapsed(
          offset: controller.text.length,
        );
      },

      child: TextFormField(
        controller: controller,

        maxLines: 2,
        textCapitalization: TextCapitalization.sentences,

        decoration: InputDecoration(
          labelText: 'Keterangan alamat',
          labelStyle: TextStyle(color: Colors.grey.shade900),

          hintText: 'Rumah warna putih pagar hitam',
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
          context.read<VehicleBloc>().add(AddressNoteEvent(value));
        },
      ),
    );
  }
}
