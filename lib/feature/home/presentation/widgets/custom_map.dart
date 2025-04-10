import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:heartmap/feature/home/presentation/provider/home_view_model.dart';
import 'package:provider/provider.dart';

class CustomMap extends StatelessWidget {
  final Set<Marker> markers;
  final Function(LatLng)? onTap;
  final LatLng? initialPosition;

  const CustomMap({
    super.key,
    required this.markers,
    this.onTap,
    this.initialPosition,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<HomeViewModel>(context, listen: false);

    // initialPosition null değilse onu kullan, yoksa Türkiye merkezi
    const LatLng defaultPosition = LatLng(39.0, 35.0);
    final LatLng mapCenter = initialPosition ?? defaultPosition;

    debugPrint("Harita merkezi: ${mapCenter.latitude}, ${mapCenter.longitude}");

    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: mapCenter,
        zoom: 5,
      ),
      onMapCreated: (controller) async {
        try {
          final String mapStyle = await DefaultAssetBundle.of(context)
              .loadString("assets/map.json");
          controller.setMapStyle(mapStyle);

          // ViewModel'e controller'ı kaydet
          viewModel.onMapCreated(controller);

          // Küçük bir gecikme ile kamerayı güncelle (daha güvenilir konum güncellemesi için)
          await Future.delayed(const Duration(milliseconds: 100));

          // Kamerayı istenen konuma getir
          await controller.moveCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(target: mapCenter, zoom: 5),
            ),
          );

          // Pozisyonu doğrulamak için güncel kamera pozisyonunu alalım
          final position = await controller.getVisibleRegion();
          final center = LatLng(
            (position.northeast.latitude + position.southwest.latitude) / 2,
            (position.northeast.longitude + position.southwest.longitude) / 2,
          );

          debugPrint("Kamera pozisyonu güncellendi ve doğrulandı:");
          debugPrint(
              "İstenen konum: ${mapCenter.latitude}, ${mapCenter.longitude}");
          debugPrint("Güncel konum: ${center.latitude}, ${center.longitude}");
        } catch (e) {
          debugPrint("Harita yüklenirken hata: $e");
        }
      },
      markers: markers,
      mapType: MapType.normal,
      onTap: onTap,
      myLocationEnabled: false,
      compassEnabled: false,
      zoomControlsEnabled: false,
      rotateGesturesEnabled: false,
      tiltGesturesEnabled: false,
    );
  }
}
