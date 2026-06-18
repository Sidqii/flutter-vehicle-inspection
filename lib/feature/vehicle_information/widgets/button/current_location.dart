import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vehicle_inspection_app/feature/vehicle_information/bloc/vehicle_bloc.dart';

class CurrentLocation extends StatelessWidget {
  const CurrentLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<VehicleBloc, VehicleState, VehicleInspectionStatus>(
      selector: (state) => state.status,

      builder: (context, state) {
        final isLoading = state == VehicleInspectionStatus.loading;

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

            onPressed: isLoading ? null : () => _getLoaction(context),

            child: isLoading ? loadingIndicator() : Text('Tandai lokasi'),
          ),
        );
      },
    );
  }

  void _getLoaction(BuildContext context) {
    context.read<VehicleBloc>().add(const CurrentLocationEvent());
  }

  Widget loadingIndicator() {
    return const Center(
      child: SizedBox(
        width: 10,
        height: 10,
        child: CircularProgressIndicator(strokeWidth: 1, color: Colors.white),
      ),
    );
  }
}
