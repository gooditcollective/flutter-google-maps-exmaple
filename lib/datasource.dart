import 'package:google_maps_flutter/google_maps_flutter.dart';

class Place {
  String id;
  String name;
  String photo;
  List<String> occasions;
  List<String> vibes;
  List<String> budget;
  LatLng location;

  Place({
    required this.id,
    required this.name,
    required this.photo,
    required this.occasions,
    required this.vibes,
    required this.budget,
    required this.location,
  });
}

final places = [
  Place(
    id: "1a384787-d806-47ed-8d33-084d92eea8a1",
    name: "A.T",
    photo:
        "https://cdn.sanity.io/images/371smjdp/production/3589d7c732bcd7e0919a9aef433f74334941a753-1440x1093.jpg?rect=27,27,1281,1034&w=135&h=109&dpr=3",
    occasions: ["dining"],
    vibes: ["haute cuisine"],
    budget: ["€€€"],
    location: const LatLng(
      48.84971800206682,
      2.3545490216252176,
    ),
  ),
  Place(
    id: "78cd546b-638b-401f-beb3-b79b1cd3f260",
    name: "Abri",
    photo:
        "https://cdn.sanity.io/images/371smjdp/production/f8d544a63cef526d5cdefc9dca0006878eee2bbc-1125x1407.jpg?rect=0,250,1125,908&w=135&h=109&dpr=3",
    occasions: ["dining"],
    vibes: ["haute cuisine"],
    budget: ["€€"],
    location: const LatLng(
      48.87787298247119,
      2.3492359846594013,
    ),
  ),
  Place(
    id: "ff268a4c-3651-4678-a2ed-dd998e34fa0b",
    name: "Amagat",
    photo:
        "https://cdn.sanity.io/images/371smjdp/production/3324d4b96bf1ae25c1103f90e278bbd9c262c39d-878x1100.png?rect=0,131,878,709&w=135&h=109&dpr=3",
    occasions: ["casual dining", "lunch"],
    vibes: ["hang out"],
    budget: ["€€"],
    location: const LatLng(
      48.85796600433903,
      2.3965199768527157,
    ),
  ),
  Place(
    id: "fe270569-e658-401a-84ed-b6b21c6fb9f3",
    name: "Table",
    photo:
        "https://cdn.sanity.io/images/371smjdp/production/a7b850e80e233ef49aae32a8d8737a508557ffa1-1125x772.jpg?rect=169,0,956,772&w=135&h=109&dpr=3",
    occasions: ["upscale dining"],
    vibes: ["haute cuisine"],
    budget: ["€€€€"],
    location: const LatLng(
      48.8487640157569,
      2.375861016277156,
    ),
  ),
  Place(
    id: "83d3ec6c-f766-4fd8-b712-074f5fd81416",
    name: "Le Clarence",
    photo:
        "https://cdn.sanity.io/images/371smjdp/production/d83b0bdeadcb87c330204787cb5fcfa3ffa5202d-1125x1120.jpg?rect=0,166,1125,908&w=135&h=109&dpr=3",
    occasions: ["upscale dining"],
    vibes: ["classy"],
    budget: ["€€€€"],
    location: const LatLng(
      48.86748861216618,
      2.3098819870872633,
    ),
  ),
];
