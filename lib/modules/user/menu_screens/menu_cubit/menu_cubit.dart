import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

import 'menu_states.dart';

class MenuCubit extends Cubit<MenuStates>{
  MenuCubit():super(InitState());
  static MenuCubit get (context)=> BlocProvider.of(context);

  ImagePicker picker = ImagePicker();
  XFile? chatImage;
  XFile? profileImage;
  TextEditingController controller = TextEditingController();
  Position? position;


  Future<XFile?> pick(ImageSource source)async{
    try{
      return await picker.pickImage(source: source);
    } catch(e){
      print(e.toString());
      emit(ImageWrong());
    }
  }

  void justEmit(){
    emit(JustEmitState());
  }


  Future<Position> checkPermissions() async {
    bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    LocationPermission permission = await Geolocator.checkPermission();
    if (!isServiceEnabled) {}
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        //showToast(msg: 'Location permissions are denied', toastState: false);
        emit(GetCurrentLocationState());
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
    //  showToast(msg: 'Location permissions are permanently denied, we cannot request permissions.', toastState: false);
      await Geolocator.openLocationSettings();
      emit(GetCurrentLocationState());
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  Future<void> getCurrentLocation() async {
    emit(GetCurrentLocationLoadingState());
    await checkPermissions();
    await Geolocator.getLastKnownPosition().then((value) {
      print(value);
      if (value != null) {
        position = value;
        emit(GetCurrentLocationState());
      }
    });
  }

  Future<void> getAddress({LatLng? latLng,required TextEditingController controller}) async {
    if (latLng != null) {
      List<Placemark> place = await placemarkFromCoordinates(
          latLng.latitude, latLng.longitude,
          localeIdentifier: 'ar');
      Placemark placeMark = place[0];
      controller.text = placeMark.street!;
      controller.text += ', ${placeMark.country!}';
      emit(GetCurrentLocationState());
    }
  }
}