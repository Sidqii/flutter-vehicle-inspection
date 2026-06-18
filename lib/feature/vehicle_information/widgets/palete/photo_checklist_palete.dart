import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vehicle_inspection_app/feature/vehicle_information/bloc/vehicle_bloc.dart';
import 'package:vehicle_inspection_app/feature/vehicle_information/model/form_format/vehicle_photos.dart';

class PhotoChecklistPalete extends StatelessWidget {
  const PhotoChecklistPalete({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<VehicleBloc, VehicleState, VehiclePhotos>(
      selector: (state) => state.form.photos,
      builder: (context, state) {
        return Container(
          width: double.infinity,

          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),

          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade500),
            borderRadius: BorderRadius.circular(12),
          ),

          child: Column(
            spacing: 10,
            children: [
              _PhotoItem(label: 'Depan', photo: state.front),

              _PhotoItem(label: 'Belakang', photo: state.back),

              _PhotoItem(label: 'Kiri', photo: state.left),

              _PhotoItem(label: 'Kanan', photo: state.right),

              _PhotoItem(label: 'Speedometer', photo: state.speedometer),
            ],
          ),
        );
      },
    );
  }
}

class _PhotoItem extends StatelessWidget {
  final String label;
  final VehiclePhoto? photo;

  const _PhotoItem({required this.label, required this.photo});

  bool get isTaken => photo != null;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
        splashColor: Colors.transparent,
      ),
      child: ExpansionTile(
        enabled: isTaken,

        minTileHeight: 0,

        tilePadding: EdgeInsets.symmetric(horizontal: 10),

        shape: const Border(),
        collapsedShape: const Border(),

        title: Text.rich(
          TextSpan(
            style: TextStyle(fontSize: 16),
            children: [
              TextSpan(text: 'Foto '),

              TextSpan(
                text: label,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),

        leading: Icon(
          isTaken ? Icons.check_circle : Icons.radio_button_unchecked,
          color: isTaken ? Colors.green : Colors.red,
          size: 15,
        ),

        trailing: Text(
          isTaken ? 'Sudah' : 'Belum',
          style: TextStyle(
            color: isTaken ? Colors.green : Colors.red,
            fontWeight: FontWeight.w500,
            fontSize: 14
          ),
        ),

        children: [
          if (photo != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.file(
                File(photo!.path),
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
        ],
      ),
    );
  }
}
