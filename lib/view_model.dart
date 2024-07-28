import 'package:bank_management_app/components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

final viewModel =
    ChangeNotifierProvider.autoDispose<ViewModel>((ref) => ViewModel());

class ViewModel extends ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  bool isSignedIn = false;
  bool isObscure = true;
  var logger = Logger();

  List expensesName = [];
  List expensesAmount = [];
  List incomesName = [];
  List incomesAmount = [];

  //Check if Signed In
  Future<void> isLoggedIn() async {
    await _auth.authStateChanges().listen((User? user) {
      if (user == null) {
        isSignedIn = false;
      } else {
        isSignedIn = true;
      }
    });
    notifyListeners();
  }


  //Toggle if the button is obscure
  toggleObscure(){
    isObscure = !isObscure;
    notifyListeners();
  }

  //Logout
  Future<void> logout() async{
    await _auth.signOut();
  }

  //Create the user with email and password
  Future<void> createUserWithEmailAndPassword(
    BuildContext context, String email, String password,
  ) async{
      await _auth.createUserWithEmailAndPassword(email: email, password: password)
        .then((value) => logger.d("REGISTRATION SUCCESSFUL"))
        .onError((error, stackTrace) {
        logger.d("Registration Error $error");
        DialogBox(context, error.toString().replaceAll(RegExp('\\[.*?\\]'), ''));

      });
  }

  //Sign in user with email and password
  Future<void> signinUserWithEmailAndPassword(
    BuildContext context, String email, String password,
  ) async{
      await _auth.signInWithEmailAndPassword(email: email, password: password)
        .then((value) => logger.d("LOGIN IN SUCCESSFUL"))
        .onError((error, stackTrace) {
        logger.d("Login In Error $error");
        DialogBox(context, error.toString().replaceAll(RegExp('\\[.*?\\]'), ''));

      });
  }

  //Sign in user with google account web
  Future<void> signinUserWithGoogleWeb(
    BuildContext context,
  ) async{
      GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();
      await _auth.signInWithPopup(googleAuthProvider)
        .then((value) => logger.d("LOGIN IN SUCCESSFUL"))
        .onError((error, stackTrace) {
        logger.d("Login In Error $error");
        DialogBox(context, error.toString().replaceAll(RegExp('\\[.*?\\]'), ''));

      });
  }

  //Sign in user with google mobile
  Future<void> signinUserWithGoogleMobile(
    BuildContext context,
  ) async{
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn().onError((error, stackTrace) => 
        DialogBox(context, error.toString().replaceAll(RegExp('\\[.*?\\]'), ''))
      );

      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken:  googleAuth?.idToken
      );

      

      // GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();
      await _auth.signInWithCredential(credential)
        .then((value) => logger.d("LOGIN IN SUCCESSFUL"))
        .onError((error, stackTrace) {
        logger.d("Login In Error $error");
        DialogBox(context, error.toString().replaceAll(RegExp('\\[.*?\\]'), ''));
      });

  }

  //Database

  Future addExpense(BuildContext context) async {
    final formKey = GlobalKey<FormState>();
    TextEditingController controllerName = TextEditingController();
    TextEditingController controllerAmount = TextEditingController();
    return await showDialog(context: context, builder:
      (BuildContext context) => AlertDialog(
        actionsAlignment:  MainAxisAlignment.center,
        contentPadding: EdgeInsets.all(32.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),

        ),
        title: Form(
          key: formKey,
          child:Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextForm(text: "Name", containerWidth: 130, hintText: "Name", controller: controllerName, validator: (text){
                if(text.toString().isEmpty){
                  return "Required";
                }
              }),
              SizedBox(width: 10.0,),
              TextForm(text: "Amount", containerWidth: 100, hintText: "Amount", controller: controllerAmount, validator: (text){
                if(text.toString().isEmpty){
                  return "Required";
                }
              })
            ],
          )
        ),
        actions: [
          MaterialButton(
            child: OpenSans(text: "Save", size: 15.0, color: Colors.white,),
            splashColor: Colors.grey,
            color: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0)
            ),
            onPressed: () async{
              if(formKey.currentState!.validate()){
                await userCollection.doc(_auth.currentUser!.uid).collection('expenses')
                .add(
                  {
                    "name" : controllerName.text,
                    "amount" : controllerAmount.text
                }  
                ).onError((error, stackTrace) {
                  logger.d("Add expense error = $error");
                  return DialogBox(context, error.toString());
                });
                Navigator.pop(context);
              }
            }
          )
        ],
      )
    );
  }

  Future addIncome(BuildContext context) async{
    final formKey = GlobalKey<FormState>();
    TextEditingController controllerName = TextEditingController();
    TextEditingController controllerAmount = TextEditingController();
    return await showDialog(
      context: context, 
      builder: (BuildContext context) =>
        AlertDialog(
          actionsAlignment: MainAxisAlignment.center,
          contentPadding: EdgeInsets.all(32.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(width: 1.0, color:Colors.black)
          ),
          title: Form(
            key:formKey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextForm(
                  text: "Name", 
                  containerWidth: 130.0, 
                  hintText: "Name", 
                  controller: controllerName, 
                  validator: (text){
                    if(text.toString().isEmpty){
                      return "Required";
                    }
                  }
                ),
                SizedBox(width: 10.0,),
                TextForm(
                  text: "Amount", 
                  containerWidth: 130.0, 
                  hintText: "Amount", 
                  controller: controllerAmount, 
                  validator: (text){
                    if(text.toString().isEmpty){
                      return "Required";
                    }
                  }
                ),
              ],
            )
          ),
          actions: [
            MaterialButton(
              child: OpenSans(text: "Save", size: 15.0, color: Colors.white,),
              splashColor: Colors.grey,
              color: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)
              ),
              onPressed: () async{
                if(formKey.currentState!.validate()){
                  await userCollection.doc(_auth.currentUser!.uid).collection('incomes')
                  .add(
                    {
                      "name" : controllerName.text,
                      "amount" : controllerAmount.text
                  }  
                  ).then(
                    (value) {
                      logger.d("Income Added");
                    }
                  )
                  .onError((error, stackTrace) {
                    logger.d("Add expense error = $error");
                    return DialogBox(context, error.toString());
                  });
                  Navigator.pop(context);
                }
              }
            )
          ],
        )
      
    );

  }

  void expensesStream() async{
    await for(var snapshot in userCollection.doc(_auth.currentUser!.uid)
    .collection("expenses").snapshots()
    ){
      expensesAmount = [];
      expensesName = [];
      for(var expense in snapshot.docs){
        expensesName.add(expense.data()['name']);
        expensesAmount.add(expense.data()['amount']);
        notifyListeners();
      }

    }
  }

  void incomeStream() async{
    await for(var snapshot in userCollection.doc(_auth.currentUser!.uid)
    .collection("incomes").snapshots()
    ){
      incomesAmount = [];
      incomesAmount = [];
      for(var expense in snapshot.docs){
        incomesName.add(expense.data()['name']);
        incomesAmount.add(expense.data()['amount']);
        notifyListeners();
      }

    }
  }

  Future<void> reset() async{
    await userCollection.doc(_auth.currentUser!.uid)
    .collection("expenses").get().then((snapshot){
      for(DocumentSnapshot ds in snapshot.docs){
        ds.reference.delete();
      }
    });

    await userCollection.doc(_auth.currentUser!.uid)
    .collection("incomes").get().then((snapshot){
      for(DocumentSnapshot ds in snapshot.docs){
        ds.reference.delete();
      }
    });
  }

}
