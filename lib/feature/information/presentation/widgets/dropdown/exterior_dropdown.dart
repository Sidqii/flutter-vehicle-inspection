import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vehicle_inspection_app/feature/information/presentation/bloc/vehicle_bloc.dart';
import 'package:vehicle_inspection_app/feature/information/domain/enum/enum_exterior.dart';

class ExteriorDropdown extends StatelessWidget {
  const ExteriorDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<VehicleBloc, VehicleState, EnumExterior?>(
      selector: (state) => state.form.information.exteriorCondition,

      builder: (context, state) {
        return DropdownMenuFormField(
          key: ValueKey(state),

          label: Text('Eksterior kendaraan'),
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

          dropdownMenuEntries: EnumExterior.values.map((condition) {
            return DropdownMenuEntry(value: condition, label: condition.label);
          }).toList(),

          onSelected: (value) {
            if (value == null) return;

            context.read<VehicleBloc>().add(ExteriorConditionEvent(value));
          },
        );
      },
    );
  }
}
