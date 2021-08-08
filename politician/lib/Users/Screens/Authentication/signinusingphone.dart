import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:politician/Users/Bottomnavigation/Navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_autofill/sms_autofill.dart';

class signinusingphone extends StatefulWidget {
  SharedPreferences prefskylo;
  signinusingphone({required this.prefskylo});
  @override
  _signinusingphoneState createState() => _signinusingphoneState();
}

class _signinusingphoneState extends State<signinusingphone> {
  late String phone,otp;
  User? user = FirebaseAuth.instance.currentUser;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _smsController = TextEditingController();
  final SmsAutoFill _autoFill = SmsAutoFill();
  late String _verificationId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.srcOver),
            image: AssetImage('Assets/Images/Rectangle.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20,100,0,0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Confirm Your Phone Number",
                  style: TextStyle(color: Colors.white,fontSize: 24,fontWeight: FontWeight.w500)),
              Padding(
                padding: EdgeInsets.fromLTRB(0,30,20,0),
                child: TextField(
                  textAlign: TextAlign.start,
                  controller: _phoneNumberController,
                  keyboardType: TextInputType.text,
                  style: TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                    hintText: 'Enter Phone No',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    filled: true,
                    contentPadding: EdgeInsets.all(16),
                    fillColor: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 5,),
              Container(
                height: 30,
                width: MediaQuery.of(context).size.width-40,
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: ()async {
                    _phoneNumberController.text = (await _autoFill.hint)!;
                  },
                  child: Text("Auto Detect ??",
                      style: TextStyle(color: Color(0xFFFFD011),fontSize: 18,fontWeight: FontWeight.bold)),
                ),
              ),
              SizedBox(height: 20,),
              Text("Enter Your OTP",
                  style: TextStyle(color: Colors.white,fontSize: 24,fontWeight: FontWeight.w500)),
              Padding(
                padding: EdgeInsets.fromLTRB(0,30,20,0),
                child: TextField(
                  textAlign: TextAlign.start,
                  controller: _smsController,
                  keyboardType: TextInputType.text,
                  style: TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                    hintText: 'Enter OTP',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    filled: true,
                    contentPadding: EdgeInsets.all(16),
                    fillColor: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 5,),
              GestureDetector(
                onTap: (){
                  verifyPhoneNumber();
                },
                child: Text("Resend OTP",
                    style: TextStyle(color: Colors.grey[300],fontSize: 18,fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 75,),
              GestureDetector(
                onTap: (){
                  verifyPhoneNumber();
                },
                child: Container(
                  width: MediaQuery.of(context).size.width-50,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Color(0xFFFFD011),
                      borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  child: Center(
                      child: Text("Send OTP"
                        ,style: TextStyle(color: Color(0xFF6C6C6C),fontSize: 20,fontFamily: 'Montserrat',fontWeight: FontWeight.w700),)),
                ),
              ),
              SizedBox(height: 20,),
              GestureDetector(
                onTap: () async {
                  signInWithPhoneNumber();
                },
                child: Container(
                  width: MediaQuery.of(context).size.width-50,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Color(0xFFFFD011),
                      borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  child: Center(
                      child: Text("Verify"
                        ,style: TextStyle(color: Color(0xFF6C6C6C),fontSize: 20,fontFamily: 'Montserrat',fontWeight: FontWeight.w700),)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void verifyPhoneNumber() async {

    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) async {
      await _auth.signInWithCredential(phoneAuthCredential);
      showSnackbar("Phone number automatically verified and user signed in: ${_auth.currentUser!.uid}");
    };

    PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      showSnackbar('Phone number verification failed. Message: ${authException.message}');
    };

    PhoneCodeSent codeSent =
        (String verificationId, [int? forceResendingToken]) async {
      showSnackbar('Please check your phone for the verification code.');
      _verificationId = verificationId;
    } as PhoneCodeSent;

    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      showSnackbar("Verification Code Sucessfully Sent");
      _verificationId = verificationId;
    };

    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: _phoneNumberController.text,
          timeout: const Duration(seconds: 5),
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    } catch (e) {
      showSnackbar("Failed to Verify Phone Number!!!. Try Again Later");
    }

  }

  void signInWithPhoneNumber() async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: _smsController.text,
      );

      final User? user = (await _auth.signInWithCredential(credential)).user;
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Navigation(prefskylo:widget.prefskylo,tweetpressed: false)));
      showSnackbar("Successfully Signedin");
    } catch (e) {
      showSnackbar("Failed to Signin");
    }
  }


  void showSnackbar(String message) {
    _scaffoldKey.currentState!.showSnackBar(SnackBar(content: Text(message)));
  }
}
