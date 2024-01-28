class Estudiante {
  int id;
  String name;
  String lastName;
  String career;
  String branch;
  Map<String, int> varkEstilosAprendizaje;

  Estudiante(
      {required this.id,
      required this.name,
      required this.lastName,
      required this.career,
      required this.branch,
      required this.varkEstilosAprendizaje});

  factory Estudiante.fromJson(Map<String, dynamic> json) {
    return Estudiante(
      id: json['id'],
      name: json['name'],
      lastName: json['last_name'],
      career: json['career'],
      branch: json['branch'],
      varkEstilosAprendizaje:
          Map<String, int>.from(json['vark_estilos_aprendizaje']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'last_name': lastName,
      'career': career,
      'branch': branch,
      'vark_estilos_aprendizaje': varkEstilosAprendizaje,
    };
  }
}

class Usuario {
  int? id; // Haz que id sea nullable
  String user;
  String password;
  String branch;
  String level;
  String status;

  Usuario(
      {this.id, // id ahora es opcional
      required this.user,
      required this.password,
      required this.branch,
      required this.level,
      required this.status});

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['_id'],
      user: json['user'],
      password: json['password'],
      branch: json['branch'],
      level: json['level'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (id != null) {
      data['_id'] = this.id;
    }
    data['user'] = this.user;
    data['password'] = this.password;
    data['branch'] = this.branch;
    data['level'] = this.level;
    data['status'] = this.status;
    return data;
  }
}
