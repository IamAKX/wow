import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:worldsocialintegrationapp/models/country_continent.dart';
import 'package:worldsocialintegrationapp/utils/helpers.dart';

import '../utils/country_continent_map.dart';

class LocationService {
  Future<CountryContinent?> getCurrentLocation() async {
    bool serviceEnabled;
    log('Inside getCurrentLocation');
    LocationPermission permission;
    CountryContinent countryContinent = CountryContinent();
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    log('serviceEnabled = $serviceEnabled');
    if (!serviceEnabled) {
      return countryContinent;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        // Permissions are denied, don't continue
        showToastMessage('Location permission denied');
        return countryContinent;
      }
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    countryContinent.position = position;
    return _getAddressFromLatLng(countryContinent);
  }

  Future<CountryContinent> _getAddressFromLatLng(
      CountryContinent countryContinent) async {
    try {
      if (countryContinent.position == null) {
        return countryContinent;
      }
      List<Placemark> placemarks = await placemarkFromCoordinates(
          countryContinent.position!.latitude,
          countryContinent.position!.longitude);
      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;

        countryContinent.country = placemark.country ?? 'Unknown';
        countryContinent.continent =
            getContinent(countryContinent.country ?? 'Unknown');
      }
    } catch (e) {
      log(e.toString());
      showToastMessage('Error in fetching country/continent');
    }
    return countryContinent;
  }
}
