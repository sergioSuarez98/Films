class Cast{

  List<Actor> actores = [];
  Cast.fromJsonList( List<dynamic> jsonList  ) {

    if ( jsonList == null ) return;

    jsonList.forEach((item) {

      final actor = Actor.fromJsonMap(item);
      actores.add(actor);
    });
  }

}

class Actor {
  Actor({
    this.adult,
    this.gender,
    this.id,
    this.knownForDepartment,
    this.name,
    this.originalName,
    this.popularity,
    this.profilePath,
    this.castId,
    this.character,
    this.creditId,
    this.order,
    this.department,
    this.job,
  });

  bool adult;
  int gender;
  int id;
  String knownForDepartment;
  String name;
  String originalName;
  double popularity;
  String profilePath;
  int castId;
  String character;
  String creditId;
  int order;
  String department;
  String job;


  Actor.fromJsonMap( Map<String, dynamic> json ){
      gender = json['gender'];
      id= json['id'];
      name= json['name'];
      profilePath= json['profile_path'];
      castId= json['cast_id'];
      character= json['character'];
      creditId= json['credit_id'];
      order= json['order'];


  }
  getFoto() {
    print(id);
    if ( profilePath == null ) {
      return 'http://forum.spaceengine.org/styles/se/theme/images/no_avatar.jpg';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$profilePath';
    }

  }

}
