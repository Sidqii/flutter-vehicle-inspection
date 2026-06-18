import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vehicle_inspection_app/feature/vehicle_information/bloc/vehicle_bloc.dart';
import 'package:vehicle_inspection_app/feature/vehicle_information/model/enum/engine_condition.dart';

class EngineDropdown extends StatelessWidget {
  const EngineDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<VehicleBloc, VehicleState, EngineCondition?>(
      selector: (state) => state.form.information.engineCondition,

      builder: (context, state) {
        return DropdownMenuFormField(
          label: Text('Kondisi mesin'),
          expandedInsets: EdgeInsets.zero,

          initialSelection: state,

          menuStyle: MenuStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.white),

            side: WidgetStatePropertyAll(
              BorderSide(color: Colors.grey.shade300),
            ),

            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),

          inputDecorationTheme: InputDecorationTheme(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey.shade500),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade800),
            ),
          ),

          dropdownMenuEntries: EngineCondition.values.map((e) {
            return DropdownMenuEntry(value: e, label: e.label);
          }).toList(),

          onSelected: (value) {
            if (value == null) return;

            context.read<VehicleBloc>().add(EngineConditionEvent(value));
          },
        );
      },
    );
  }
}
