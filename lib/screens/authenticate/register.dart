import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/constants.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  Register({required this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth=AuthService();
  final _formKey=GlobalKey<FormState>();
  bool loading=false;

  //text field state
  String email="";
  //password field state
  String password="";

  String error="";

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title:Text('Sign Up in to Brew Crew'),
        actions: [
          TextButton.icon(
            onPressed: (){
              widget.toggleView();
            },
            icon: Icon(Icons.person),
            label:Text('Sign In') ,
          )
        ],
      ),
      body:Container(
          padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
          child:Form(
            key:_formKey, //helps us to keep track of state of our form  . . .
              child:Column(
                children: [
                  SizedBox(height:20.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Email'),
                    validator: (val){
                      return val!.isEmpty ? ' Enter a valid email ' : null;
                    },
                    onChanged:(val){
                      setState(() {
                        email=val;
                      });
                    },
                  ),
                  SizedBox(height:20.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Password'),
                    validator: (val){
                      return val!.length<6 ? ' Password must be 6+ letters ' : null;
                    },
                    obscureText: true,
                    onChanged: (val){
                      setState(() {
                        password=val;
                      });
                    },
                  ),
                  SizedBox(height:20.0),
                  ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:MaterialStateProperty.all<Color>(Colors.pink),
                      ),
                      onPressed: () async{
                        if(_formKey.currentState!.validate()){
                          setState(() {
                            loading=true;
                          });
                          dynamic result=await _auth.registerWithEmailAndPassword(email, password);
                          if(result==null){
                            setState(() {
                              error='please supply a valid email';
                              loading=false;
                            });
                          }
                        }
                      },
                      child:Text('Register',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )
                  ),
                  SizedBox(height: 12.0,),
                  Text(
                    error,
                    style:TextStyle(
                      color: Colors.red,
                      fontSize: 14.0,
                    )
                  ),
                ],
              )
          )
      ),
    );
  }
}
