import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vehicle_inspection_app/feature/vehicle_information/bloc/vehicle_bloc.dart';
import 'package:vehicle_inspection_app/feature/vehicle_information/model/enum/photo_type.dart';

class TakePhoto extends StatelessWidget {
  const TakePhoto({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _showPhotoSheet(context),
      child: const Icon(Icons.camera_alt),
    );
  }

  void _showPhotoSheet(BuildContext context) {
    final bloc = context.read<VehicleBloc>();

    showModalBottomSheet(
      backgroundColor: Colors.white,
      useSafeArea: true,

      context: context,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),

            child: Column(
              children: PhotoType.values.map((type) {
                return ListTile(
                  leading: const Icon(Icons.camera_alt),

                  title: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: 'Ambil foto '),

                        TextSpan(
                          text: type.label,
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),

                  onTap: () {
                    Navigator.pop(context);

                    bloc.add(TakePhotoEvent(type));
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
