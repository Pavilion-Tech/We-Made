class CitiesModel {
  String? message;
  bool? status;
  List<CitiesData>? data;

  CitiesModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <CitiesData>[];
      json['data'].forEach((v) {
        data!.add( CitiesData.fromJson(v));
      });
    }
  }

}

class CitiesData {
  String? id;
  String? name;

  CitiesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }


}

class NeighborhoodModel {
  String? message;
  bool? status;
  List<NeighborhoodData>? data;


  NeighborhoodModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <NeighborhoodData>[];
      json['data'].forEach((v) {
        data!.add(NeighborhoodData.fromJson(v));
      });
    }
  }

}

class NeighborhoodData {
  String? id;
  String? name;
  String? neighborhoodLatitude;
  String? neighborhoodLongitude;


  NeighborhoodData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    neighborhoodLatitude = json['neighborhood_latitude'];
    neighborhoodLongitude = json['neighborhood_longitude'];
  }

}

