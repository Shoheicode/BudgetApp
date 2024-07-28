import 'package:bank_management_app/components.dart';
import 'package:bank_management_app/view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sign_button/sign_button.dart';
import 'package:logger/logger.dart';

class LoginViewMobile extends HookConsumerWidget {
  const LoginViewMobile({super.key});

  //Logger log;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController _emailField = useTextEditingController();
    TextEditingController _passwordField = useTextEditingController();
    final viewModelProvider = ref.watch(viewModel);
    final double deviceHeight = MediaQuery.of(context).size.height;

    //log.d("HIAJLSJLKFJALKD");
    

    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: deviceHeight/5.5),
              Image.asset(
                "assets/logo.png", 
                fit: BoxFit.contain, 
                width: 210.0,
              ),
              SizedBox(height: 35.0,),
              SizedBox(
                width: 350.0,
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  controller: _emailField,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    prefixIcon: Icon(Icons.email, color: Colors.black, size:30.0),
                    hintText: "Email",
                    hintStyle: GoogleFonts.openSans(),

                  ),
                )
              ),
              SizedBox(height: 20.0,),
              SizedBox(
                width: 350.0,
                child: TextFormField(
                  textAlign: TextAlign.center,
                  controller: _passwordField,
                  obscureText: viewModelProvider.isObscure,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    prefixIcon: IconButton(
                      icon: Icon(
                        viewModelProvider.isObscure ? Icons.visibility : Icons.visibility_off,
                        color: Colors.black,
                        size: 30.0,
                      ),

                      onPressed: (){
                        viewModelProvider.toggleObscure();
                      },
                    ),
                    hintStyle:GoogleFonts.openSans(),
                    hintText: "Password",
                  )
                )
              ),
              SizedBox(
                height: 30.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50.0,
                    width: 150.0,
                    child: MaterialButton(
                      onPressed: () async{
                        await viewModelProvider.createUserWithEmailAndPassword(context, _emailField.text, _passwordField.text);
                      },
                      child: OpenSans(
                        text: "Register",
                        size: 25.0,
                        color: Colors.white
                      ),
                      splashColor: Colors.grey,
                      color: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))
                      ),
                    ),
                  ),
                  SizedBox(width: 20.0),
                  Text(
                    "Or",
                    style: GoogleFonts.pacifico(
                      color:Colors.black, fontSize: 15.0,
                    ),
                  ),
                  SizedBox(width: 20.0),
                  SizedBox(
                    height: 50.0,
                    width: 150.0,
                    child: MaterialButton(
                      onPressed: () async{
                        await viewModelProvider.signinUserWithEmailAndPassword(context, _emailField.text, _passwordField.text);
                        //await viewModelProvider.createUserWithEmailAndPassword(context, _emailField.text, _passwordField.text);
                      },
                      child: OpenSans(
                        text: "Login In",
                        size: 25.0,
                        color: Colors.white
                      ),
                      splashColor: Colors.grey,
                      color: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))
                      ),
                    ),
                  ),
                
                ],
              ),
              SizedBox(height: 30.0),
              SignInButton(
                buttonType: ButtonType.google,
                btnColor: Colors.black,
                btnTextColor: Colors.white,
                buttonSize: ButtonSize.medium,
                onPressed: () async{
                  if(kIsWeb){
                    await viewModelProvider.signinUserWithGoogleWeb(context);
                  } else{
                    await viewModelProvider.signinUserWithGoogleMobile(context);
                  }
                },
              ),
              
            ],
          ),
        ),
    );
  }
}
