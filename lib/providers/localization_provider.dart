import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocalizationProvider extends ChangeNotifier {
  double lat = 0.0;
  double long = 0.0;
  String erro = '';
  String street = '';
  String zipCode = '';
  String sublocality = '';

  LocalizationProvider() {
    getPosicao();
  }

  getPosicao() async {
    try {
      Position posicao = await _posicaoAtual();
      lat = posicao.latitude;
      long = posicao.longitude;
      List<Placemark> locais = await placemarkFromCoordinates(lat, long);
      street = locais[0].street!;
      zipCode = locais[0].postalCode!;
      sublocality = locais[0].subLocality!;
    } catch (e) {
      erro = e.toString();
    }

    notifyListeners();
  }

  Future<Position> _posicaoAtual() async {
    LocationPermission permissao;

    bool ativado = await Geolocator.isLocationServiceEnabled();
    if (!ativado) {
      return Future.error('Por favor, habilite a localização no smartphone');
    }

    permissao = await Geolocator.checkPermission();
    if (permissao == LocationPermission.denied) {
      permissao = await Geolocator.requestPermission();
      if (permissao == LocationPermission.denied) {
        return Future.error('Você precisa autorizar o acesso à localização');
      }
    }

    if (permissao == LocationPermission.deniedForever) {
      return Future.error('Você precisa autorizar o acesso à localização');
    }

    return await Geolocator.getCurrentPosition();
  }
}
