//lógica de la conexión con Firebase Auth

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


class UsuarioSesionRepositorio {

  final FirebaseAuth faAuth= FirebaseAuth.instance; //trae  lo que está en la consola de firebase, lo que se definió dentro de la consola de firebase  se instancia en esta varible
  final GoogleSignIn gsiCuenta=GoogleSignIn();  //trae la instancia de  lo que tenga que ver con google sign in
 // bool? esNuevo;
  //Método que contiene la lógica del API
  //está ejecutándose en segundo plano, entonces s e necesita async
  // Future<UserCredential?> signInGoogleFire() async{

  // Future<CredencialBool> signInGoogleFire() async{
  Future<UserCredential?> signInGoogleFire() async{

  //  Future<NombreEmail> signInGoogleFire() async{

    //Primera autenticación con Google
    GoogleSignInAccount? gsiacCuenta= await gsiCuenta.signIn();//se abre la ventana de con qué cuenta te quieres registrar
    GoogleSignInAuthentication? gsiauCuenta= await gsiacCuenta?.authentication;//con que cuenta te quieres registrar, obtener las respectivas credenciales

    String email=gsiacCuenta!.email.toString();
    List<String> listaEmail= email.split('@');
    String nombreUsuario=listaEmail[0];

    UserCredential? usuario=await faAuth.signInWithCredential(GoogleAuthProvider.credential(idToken: gsiauCuenta?.idToken, accessToken: gsiauCuenta?.accessToken )).then((userCredential) {

    });
    //retornan las credenciales de la cuenta que el usuario escogió para autenticarse
    return await usuario ;

  }



  SignOutGoogleFire() async{
    //cerrar sesión firebase
    await faAuth.signOut().then((value) => print("Sesión cerrada fire"));
    //cerrar sesión Google
   await gsiCuenta.signOut().then((value) => print("Sesión cerrada google"));

    print("sesiones cerradas google");
  }

  //Monitorear el estado de la sesión de autenticación
  Stream<User?> EstadoSesion= FirebaseAuth.instance.authStateChanges();
  //Método Escuchar el estado de la sesión, el obj auth status devuelve el estado de la sesión
  //para acceder al estado necesito el método get
  Stream<User?> get authEstadoSesion=>EstadoSesion; //es lo mismo que {return streamFirebase}



}

