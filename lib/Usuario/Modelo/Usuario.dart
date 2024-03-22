



class Usuario {
  String nombre='';
  String emailsesion='';
  String idUsuario='';
  String idVideo='';
  String fechaNacimiento='';
  String genero='';
  String profesion='';
  String especialidad='';
//  String slogan='';
  String descripcion='';
  String redSocialPagweb='';
  String redSocialFacebook='';
  String redSocialInsta='';
  String redSocialTikTok='';
  String redSocialEMail='';
  String redSocialTelefono='';
//  String redSocialWhatsapp='';
  String ubicacion='';
  String urlFotoPerfil='';
  String urlVideo='';

  Usuario({
    required this.nombre,
    required this.emailsesion,
    required this.idUsuario,
    required this.idVideo,
    required this.fechaNacimiento,
    required this.profesion,
    required this.genero,
    required this.especialidad,
  //  required this.slogan,
    required this.descripcion,
    required this.redSocialPagweb,
    required this.redSocialFacebook,
    required this.redSocialInsta,
    required this.redSocialTikTok,
    required this.redSocialEMail,
    required this.redSocialTelefono,
   // required this.redSocialWhatsapp,
    required this.ubicacion,
    required this.urlFotoPerfil,
    required this.urlVideo,
  });


  factory Usuario.vacio(){
    return Usuario(
        nombre: '',
        emailsesion: '',
        idUsuario: '',
        idVideo: '',
        fechaNacimiento: '',
        profesion: '',
        genero: '',
        especialidad: '',
     //   slogan: '',
        descripcion: '',
        redSocialPagweb: '',
        redSocialFacebook: '',
        redSocialInsta: '',
        redSocialTikTok: '',
        redSocialEMail: '',
        redSocialTelefono: '',
      //  redSocialWhatsapp: '',
        ubicacion: '',
        urlFotoPerfil: '',
        urlVideo: '');
  }

  factory Usuario.fromJson(Map<String, dynamic>json){
    return Usuario(
      nombre: json['nombre'],
      emailsesion: json['emailsesion'],
      idUsuario: json['idUsuario'],
      idVideo: json['idVideo'],
      fechaNacimiento: json['fechaNacimiento'],
      profesion: json['profesion'],
      genero: json['genero'],
      especialidad: json['especialidad'],
    //  slogan: json['slogan'],
      descripcion: json['descripcion'],
      redSocialPagweb: json['pagweb'],
      redSocialFacebook: json['facebook'],
      redSocialInsta: json['instagram'],
      redSocialTikTok: json['tiktok'],
      redSocialEMail: json['email'],
      redSocialTelefono: json['telefono'],
    //  redSocialWhatsapp: json['whatsapp'],
      ubicacion: json['ubicacion'],
      urlFotoPerfil: json['urlFotoPerfil'],
      urlVideo: json['urlVideo'],
    );
  }

  factory Usuario.fromJson2(Map<String, dynamic>?json){
    return Usuario(
      nombre: json!['nombre'],
      emailsesion: json['email'],
      idUsuario: json['idUsuario'],
      idVideo: json['idVideo'],
      fechaNacimiento: json['fechaNacimiento'],
      profesion: json['profesion'],
      genero: json['genero'],
      especialidad: json['especialidad'],
    //  slogan: json['slogan'],
      descripcion: json['descripcion'],
      redSocialPagweb: json['pagweb'],
      redSocialFacebook: json['facebook'],
      redSocialInsta: json['instagram'],
      redSocialTikTok: json['tiktok'],
      redSocialEMail: json['email'],
      redSocialTelefono: json['telefono'],
     // redSocialWhatsapp: json['whatsapp'],
      ubicacion: json['ubicacion'],
      urlFotoPerfil: json['urlFotoPerfil'],
      urlVideo: json['urlVideo'],

    );
  }

  Map<String, dynamic> toJson()=>{
    'nombre':nombre,
    'emailsesion': emailsesion,
    'idUsuario': idUsuario,
    'idVideo': idVideo,
    'fechaNacimiento':fechaNacimiento,
    'profesion':profesion,
    'genero':genero,
    'especialidad':especialidad,
   // 'slogan':slogan,
    'descripcion':descripcion,
    'pagweb':redSocialPagweb,
    'facebook':redSocialFacebook,
    'instagram':redSocialInsta,
    'tiktok':redSocialTikTok,
    'email':redSocialEMail,
    'telefono':redSocialTelefono,
    //'whatsapp':redSocialWhatsapp,
    'ubicacion':ubicacion,
    'urlFotoPerfil':urlFotoPerfil,
    'urlVideo':urlVideo
  };
}



