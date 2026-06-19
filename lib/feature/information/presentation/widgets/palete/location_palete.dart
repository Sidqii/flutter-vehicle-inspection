import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vehicle_inspection_app/feature/information/presentation/bloc/vehicle_bloc.dart';
import 'package:vehicle_inspection_app/feature/information/domain/entities/base_location.dart';

class LocationPalete extends StatelessWidget {
  const LocationPalete({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<VehicleBloc, VehicleState, BaseLocation>(
      selector: (state) => state.form.location,

      builder: (context, state) {
        return InputDecorator(
          decoration: InputDecoration(
            labelText: 'Detail lokasi',
            labelStyle: TextStyle(color: Colors.grey.shade900),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey.shade500),
            ),
          ),

          child: Text.rich(
            TextSpan(
              style: TextStyle(color: Colors.grey.shade900, fontSize: 15),

              children: [
                TextSpan(
                  text: 'Latitude    : ',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                TextSpan(text: '${state.latitude ?? '0'}'),

                TextSpan(text: '\n'),

                TextSpan(
                  text: 'Longitude : ',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                TextSpan(text: '${state.longitude ?? '0'}'),

                TextSpan(text: '\n\n'),

                TextSpan(
                  text: 'Alamat:',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),

                TextSpan(text: '\n'),

                TextSpan(
                  text: state.address.isEmpty
                      ? 'Catat lokasi.\n'
                      : state.address,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
