import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vehicle_inspection_app/feature/vehicle_information/bloc/vehicle_bloc.dart';
import 'package:vehicle_inspection_app/feature/vehicle_information/model/enum/enum_photo.dart';

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
        return BlocProvider.value(
          value: bloc,
          child: BlocBuilder<VehicleBloc, VehicleState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 30,
                ),

                child: Column(
                  children: EnumPhoto.values.map((type) {
                    final isTaken = state.form.photos.getByType(type) != null;

                    return ListTile(
                      leading: Icon(
                        Icons.camera_alt,
                        color: Colors.grey.shade700,
                      ),

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

                      trailing: isTaken
                          ? Icon(
                              Icons.check_circle,
                              color: Colors.green.shade700,
                            )
                          : null,

                      onTap: () {
                        Navigator.pop(context);

                        bloc.add(TakePhotoEvent(type));
                      },
                    );
                  }).toList(),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
