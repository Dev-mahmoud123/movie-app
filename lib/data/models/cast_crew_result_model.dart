import 'package:movie_app/domain/entities/cast_entity.dart';

class CastCrewResultModel {
  int? id;
  late List<CastModel> cast;
  List<Crew>? crew;

  CastCrewResultModel({this.id, required this.cast, this.crew});

  CastCrewResultModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['cast'] != null) {
      cast = <CastModel>[];
      json['cast'].forEach((v) {
        cast.add(CastModel.fromJson(v));
      });
    }
    if (json['crew'] != null) {
      crew = <Crew>[];
      json['crew'].forEach((v) {
        crew!.add(Crew.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['cast'] = cast.map((v) => v.toJson()).toList();
    if (crew != null) {
      data['crew'] = crew?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CastModel extends CastEntity {
  final bool? adult;
  final int? gender;
  final int? id;
  final String? knownForDepartment;
  final String name;
  final String? originalName;
  final double? popularity;
  final String profilePath;
  final int? castId;
  final String character;
  final String creditId;
  final int? order;

  const CastModel({
    this.adult,
    this.gender,
    this.id,
    this.knownForDepartment,
    required this.name,
    this.originalName,
    this.popularity,
    required this.profilePath,
    this.castId,
    required this.character,
    required this.creditId,
    this.order,
  }) : super(
            creditId: creditId,
            name: name,
            profilePath: profilePath,
            character: character);

  factory CastModel.fromJson(Map<String, dynamic> json) {
    return CastModel(
      adult: json['adult'],
      gender: json['gender'],
      id: json['id'],
      knownForDepartment: json['known_for_department'],
      name: json['name'],
      originalName: json['original_name'],
      popularity: json['popularity'],
      profilePath: json['profile_path'].toString(),
      castId: json['cast_id'],
      character: json['character'],
      creditId: json['credit_id'],
      order: json['order'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cast_id'] = castId;
    data['character'] = character;
    data['credit_id'] = creditId;
    data['gender'] = gender;
    data['id'] = id;
    data['name'] = name;
    data['order'] = order;
    data['profile_path'] = profilePath;
    return data;
  }
}

class Crew {
  bool? adult;
  int? gender;
  int? id;
  String? knownForDepartment;
  String? name;
  String? originalName;
  double? popularity;
  String? profilePath;
  String? creditId;
  String? department;
  String? job;

  Crew(
      {this.adult,
      this.gender,
      this.id,
      this.knownForDepartment,
      this.name,
      this.originalName,
      this.popularity,
      this.profilePath,
      this.creditId,
      this.department,
      this.job});

  Crew.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    gender = json['gender'];
    id = json['id'];
    knownForDepartment = json['known_for_department'];
    name = json['name'];
    originalName = json['original_name'];
    popularity = json['popularity'];
    profilePath = json['profile_path'];
    creditId = json['credit_id'];
    department = json['department'];
    job = json['job'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['credit_id'] = creditId;
    data['department'] = department;
    data['gender'] = gender;
    data['id'] = id;
    data['job'] = job;
    data['name'] = name;
    data['profile_path'] = profilePath;
    return data;
  }
}
