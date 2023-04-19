import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:untitled/pages/auth/reset_pass/verfication_pass.dart';
import 'package:untitled/util/Colores.dart';
class Rtpassword extends StatefulWidget {
  const Rtpassword({Key? key}) : super(key: key);

  @override
  State<Rtpassword> createState() => _RtpasswordState();

}

class _RtpasswordState extends State<Rtpassword> {
  TextEditingController emailInputCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.greyW,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(32) ,

          width:double.maxFinite ,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Text("réinitialiser le mot de passe",
                  style:(TextStyle(fontSize:28,fontWeight: FontWeight.bold,color: AppColors.blueG,fontFamily: "Castoro" ))),
              const SizedBox(
                height: 100 ,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Confirmez votre EMAIL ",
                      style:(TextStyle(fontSize:16,fontWeight: FontWeight.w300,color: Colors.black,fontFamily: "Castoro" ))),
                ],
              ),
              const SizedBox(
                height: 24 ,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress ,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)
                  ),
                  hintText: "Email",
                  suffixIcon: Icon( Icons.email_outlined ,
                      color: AppColors.blueG) ,


                ),
                controller: emailInputCtrl ,
              ),
              const SizedBox(
                height:24 ,
              ),
              Row(
                children: [
                  Expanded(

                    child: CupertinoButton(child: Text('ENVOYER',style:TextStyle(color: Colors.black,fontFamily: "Castoro"), )
                      , onPressed:() {Navigator.push(context, CupertinoPageRoute(builder:(context) => Verfication() ) ) ;}, color:AppColors.blueG , ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

    );
  }
}


