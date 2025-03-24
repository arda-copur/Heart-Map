import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:heartmap/feature/home/presentation/provider/home_view_model.dart';
import 'package:provider/provider.dart';

class CustomMap extends StatelessWidget {
  final Set<Marker> markers;
  final Function(LatLng)? onTap;

  const CustomMap({super.key, required this.markers, this.onTap});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context, listen: false);

    return GoogleMap(
      initialCameraPosition: const CameraPosition(
        target: LatLng(39.925533, 32.866287),
        zoom: 5,
      ),
      onMapCreated: (controller) async {
        final String mapStyle =
            await DefaultAssetBundle.of(context).loadString("assets/map.json");
        controller.setMapStyle(mapStyle);
        viewModel.onMapCreated(controller);
      },
      markers: markers,
      mapType: MapType.normal,
      onTap: onTap,
    );
  }
}
