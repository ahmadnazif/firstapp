import 'dart:math';

class MalaysiaState {
  String imagePath;
  String stateName;
  String stateDesc;
  int totalPlaceInState;
  MalaysiaState(
      {this.imagePath, this.stateName, this.stateDesc, this.totalPlaceInState});
}

class MalaysiaStatesData {
  static List<MalaysiaState> _getAllRawStatesData() {
    final String path = "res/images/statesbanner";

    return <MalaysiaState>[
      MalaysiaState(
          imagePath: "$path/perak.jpg",
          stateName: "Perak",
          stateDesc: "Darul Ridzuan",
          totalPlaceInState: PlacesData.countPlaces("Perak")),
      MalaysiaState(
          imagePath: "$path/johor.jpg",
          stateName: "Johor",
          stateDesc: "Darul Takzim",
          totalPlaceInState: PlacesData.countPlaces("Johor")),
      MalaysiaState(
          imagePath: "$path/selangor.jpg",
          stateName: "Selangor",
          stateDesc: "Darul Ehsan",
          totalPlaceInState: PlacesData.countPlaces("Selangor")),
      MalaysiaState(
          imagePath: "$path/kl.jpg",
          stateName: "Kuala Lumpur",
          stateDesc: "Wilayah Persekutuan",
          totalPlaceInState: PlacesData.countPlaces("Kuala Lumpur")),
      MalaysiaState(
          imagePath: "$path/kelantan.jpg",
          stateName: "Kelantan",
          stateDesc: "Darul Naim",
          totalPlaceInState: PlacesData.countPlaces("Kelantan")),
    ];
  }

  static int countStates() => _getAllRawStatesData().length;

  static List<MalaysiaState> getAllState(StateSortType sortType) {
    var list = _getAllRawStatesData().toList();
    switch (sortType) {
      case StateSortType.stateName_asc:
        list.sort((x, y) => x.stateName.compareTo(y.stateName));
        break;
      case StateSortType.stateName_desc:
        list.sort((x, y) => y.stateName.compareTo(x.stateName));
        break;
      case StateSortType.totalPlaceCount_asc:
        list.sort((x, y) => x.totalPlaceInState.compareTo(y.totalPlaceInState));
        break;
      case StateSortType.totalPlaceCount_desc:
        list.sort((x, y) => y.totalPlaceInState.compareTo(x.totalPlaceInState));
        break;
    }
    return list;
  }
}

enum StateSortType {
  stateName_asc,
  stateName_desc,
  totalPlaceCount_asc,
  totalPlaceCount_desc
}

class Place {
  final String imagePath;
  int numberOfLikes;
  final String placeState;
  final String placeName;
  final String placeDesc;
  Place({this.imagePath, this.placeState, this.placeName, this.placeDesc});
}

class PlacesData {
  static List<Place> _getAllRawPlacesData() {
    final String path = "res/images/places";
    return <Place>[
      Place(
          imagePath: "$path/bd.jpg",
          placeState: "Perak",
          placeName: "Bagan Datuk",
          placeDesc:
              "The Bagan Datuk District (Malay: Daerah Bagan Datuk) is the most southwest district in Perak, Malaysia. It covers an area of 951 square kilometres, and had a population about of 70,300. The district is bordered by Perak River which separates Manjung and Central Perak in the north, Bernam River which separates Sabak Bernam in the state of Selangor in the south, Muallim and Hilir Perak in the northeast."),
      Place(
          imagePath: "$path/kgajah.jpg",
          placeState: "Perak",
          placeName: "Kampung Gajah",
          placeDesc:
              "Kampung Gajah is a town and mukim in Perak Tengah District, Perak, Malaysia. The mukim has a population of 7,693 people and spans over an area of 59.57 km2. The mukim is also home to Perak's 11th highest peak (1522m), Gunung Jelak, which is home to a small Kelantanese-Javanese population."),
      Place(
          imagePath: "$path/setiawan.jpg",
          placeState: "Perak",
          placeName: "Setiawan",
          placeDesc:
              "Sitiawan (alternate spelling: Setiawan; origin: from Malay, a portmanteau of Setia Kawan, meaning \"Loyal Friend\") is a region in Manjung District, Perak, Malaysia. The region covers an area of 331.5 square kilometers (128.0 sq mi) and as of year 2000, its population was 95,920 and has risen to more than 150,000 by 2015. Sitiawan town, the principal town of Sitiawan sub-district (mukim), is located at 4°13′N 100°42′E."),
      Place(
          imagePath: "$path/uchepor.jpg",
          placeState: "Perak",
          placeName: "Ulu Chepor",
          placeDesc:
              "To reach the recreational site of Ulu Chepor, follow the directions to Ipoh and Jelapang. From Jelapang take the road to Chemor. After about 4 km you reach Kg Ulu Chepor. Here you will find a signboard to the picnic area of Ulu Chenor. Follow the small road until your reach the site where you can park your car. On weekends there will be a few Ringgit fee."),
      Place(
          imagePath: "$path/utm.jpg",
          placeState: "Johor",
          placeName: "UTM Skudai",
          placeDesc:
              "Universiti Teknologi Malaysia (also known as UTM) is a public research-intensive university in engineering, science and technology located in Skudai, Johor and it has a branch campus in Kuala Lumpur. UTM is a graduate-focused university with 56% of its student population consisting of postgraduate students, the highest in Malaysia. As of 2015, UTM has more than 5,000 international students from more than 120 countries, the highest research university in Malaysia."),
      Place(
          imagePath: "$path/segamat.jpg",
          placeState: "Johor",
          placeName: "Rumah Wafau",
          placeDesc: "Rumah kuning"),
      Place(
          imagePath: "$path/segamat.jpg",
          placeState: "Johor",
          placeName: "Danga Bay",
          placeDesc: "Rumah kuning"),
      Place(
          imagePath: "$path/segamat.jpg",
          placeState: "Johor",
          placeName: "Desaru",
          placeDesc: "Rumah kuning"),
      Place(
          imagePath: "$path/langkawi.jpg",
          placeState: "Kedah",
          placeName: "Pulau Langkawi",
          placeDesc:
              "Langkawi, officially known as Langkawi, the Jewel of Kedah (Malay: Langkawi Permata Kedah), is a district and an archipelago of 99 islands (+ 5 small islands visible only at low tide) in the Andaman Sea some 30 km off the mainland coast of northwestern Malaysia. The islands are a part of the state of Kedah, which is adjacent to the Thai border."),
      Place(
          imagePath: "$path/kkangsar.jpg",
          placeState: "Perak",
          placeName: "Kuala Kangsar",
          placeDesc:
              "The Kuala Kangsar is the royal town of Perak, Malaysia. It is located at the downstream of Kangsar River where it joins the Perak River, approximately 25 km northwest of Ipoh, Perak's capital, and 98 km southeast of George Town, Penang"),
      Place(
          imagePath: "$path/klcc.jpg",
          placeState: "Kuala Lumpur",
          placeName: "Menara KLCC",
          placeDesc:
              "Kuala Lumpur City Centre (KLCC) is a multipurpose development area in Kuala Lumpur, Malaysia. The area is located around Jalan Ampang, Jalan P. Ramlee, Jalan Binjai, Jalan Kia Peng and Jalan Pinang. There are a number of shopping complexes such as Suria KLCC and Avenue K. There are also hotels within walking distance such as G Tower, Mandarin Oriental, Grand Hyatt Kuala Lumpur and InterContinental Kuala Lumpur hotel."),
      Place(
          imagePath: "$path/segamat.jpg",
          placeState: "Kedah",
          placeName: "Kd",
          placeDesc: "Rumah kuning"),
      Place(
          imagePath: "$path/segamat.jpg",
          placeState: "Pulau Pinang",
          placeName: "pp1",
          placeDesc: "Rumah kuning"),
      Place(
          imagePath: "$path/segamat.jpg",
          placeState: "Pulau Pinang",
          placeName: "pp2",
          placeDesc: "Rumah kuning"),
      Place(
          imagePath: "$path/segamat.jpg",
          placeState: "Kelantan",
          placeName: "k1",
          placeDesc: "Rumah kuning")
    ];
  }

  static Place getRandomPlace(String stateName) {
    var locs =
        _getAllRawPlacesData().where((x) => x.placeState == stateName).toList();

    Random r = new Random();
    var rIndex = r.nextInt(locs.length);
    return locs[rIndex];
  }

  // Count all place for given state name
  static int countPlaces(String stateName) => _getAllRawPlacesData()
      .where((x) => x.placeState == stateName)
      .toList()
      .length;

  static Place getData(String stateName, int index) {
    var locs =
        _getAllRawPlacesData().where((x) => x.placeState == stateName).toList();

    locs.sort((x, y) => x.placeName.compareTo(y.placeName)); // ascending

    return locs[index];
  }
}
