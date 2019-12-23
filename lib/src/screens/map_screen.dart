import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../widgets/widgets.dart';

class MapScreen extends StatelessWidget {
  static final String routeName = '/map';

  @override
  Widget build(BuildContext context) {
    final OrderModel order = Provider.of<OrderModel>(context);

    final CameraPosition cameraPosition = CameraPosition(
      target: LatLng(order.lat, order.lon),
      zoom: 14.4746,
    );

    return ScaffoldWithBackground(
      hideOrderButton: true,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: cameraPosition,
          markers: Set.of([
            Marker(
                markerId: MarkerId('Order location'),
                position: LatLng(order.lat, order.lon))
          ]),
        ),
      ),
    );
  }
}
