import 'package:flutter/material.dart';
import 'package:so_flutter/so_flutter.dart';
import 'package:so/so.dart';

void main() {
  App app = App();
  app.debugMode=false;
  app.home = LoginPage();
  app.run();
}

class LoginPage extends DataScreen{

  @override
  Scaffold build(BuildContext context) {

    Field<String> username = textField(
      // textAlign: TextAlign.left,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 20, left: 8),
            border: InputBorder.none,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            label: const Text(
              'Enter your username',
              style: TextStyle(
                color: Color(0xFFA09393),
                fontSize: 16,
                fontFamily: 'Khmer',
                fontWeight: FontWeight.w400,
              ),
            )
        )
    );

    bool obscure = true;

    Field<String> password = textField(
      obscureText: obscure,
      decoration: InputDecoration(
          suffixIcon: IconButton(
              onPressed: () => setState(() {
                obscure = !obscure;
                print(obscure);
              }
              ),

              icon: Icon(
                obscure ? Icons.visibility_off : Icons.visibility,
              )
          ),
          contentPadding: EdgeInsets.only(bottom: 20, left: 8),
          border: InputBorder.none,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          label: const Text(
            'Enter your password',
            style: TextStyle(
              color: Color(0xFF929090),
              fontSize: 16,
              fontFamily: 'Khmer',
              fontWeight: FontWeight.w400,
            ),
          )
      ),
    );

    return Scaffold(
      backgroundColor: Color(0xFF2B2B2B),
      body: Column(
        children: [

          //---------------DESIGN
          // Align(
          //   alignment: Alignment.topLeft, // Positions in the top-left corner dynamically
          //   child: Stack(
          //       children: [
          //
          //           Container(
          //             width: 200,
          //             height: 200,
          //             decoration: ShapeDecoration(
          //               color: Color(0x477CCCCC),
          //               shape: OvalBorder(),
          //             ),
          //           ),
          //
          //           Container(
          //             width: 200,
          //             height: 200,
          //             decoration: ShapeDecoration(
          //               color: Color(0x477CCCCC),
          //               shape: OvalBorder(),
          //             ),
          //           ),
          //       ],
          //     ),
          //   ),

          SizedBox(height: 30,),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.all(13),
              child: Text('CONCORD',
                style: TextStyle(
                    color: Color(0xFF555555),
                    fontSize: 20,
                    fontWeight: FontWeight.w900),
              ),
            ),
          ),

          SizedBox(height: MediaQuery.of(context).size.height*0.15,),
          Align(
            alignment: Alignment.topCenter,
            child: Text(
              'Welcome to Concord',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontFamily: 'Khmer',
                fontWeight: FontWeight.w200,
              ),
            ),
          ),

          //---------------USERNAME & PASSWORD

          SizedBox(height: MediaQuery.of(context).size.height*0.2),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: MediaQuery.of(context).size.width*0.85,
              height: 60,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: username,
              ),
            ),
          ),

          SizedBox(height: 20,),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: MediaQuery.of(context).size.width*0.85,
              height: 60,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: password,
              ),
            ),
          ),

          //---------------FORGOT PASSWORD

          SizedBox(height: 5,),
          Align(
              alignment: Alignment.center,
              child: Transform.translate(
                offset: Offset(-MediaQuery.of(context).size.width*0.26, 0),
                child: TextButton(
                    onPressed: () => App.goTo(Forgot()),
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Color(0xFF47ACBA),
                        fontSize: 15,
                        fontFamily: 'Khmer',
                        fontWeight: FontWeight.w400,
                      ),
                    )
                ),
              )
          ),

          //---------------LOGIN BUTTON

          SizedBox(height: 30,),
          Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () => login(username.value ?? '', password.value ?? ''),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF2D6C83),
                  minimumSize: Size(MediaQuery.of(context).size.width*0.85, 85),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                  ),
                  elevation: 5,
                ),
                child: Text(
                  'Continue',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: 'Khmer',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              )
          ),

          //---------------SIGNUP BUTTON

          SizedBox(height: 5,),
          Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account?",
                  style: TextStyle(
                    color: Color(0xFF6C6C6C),
                    fontSize: 16,
                    fontFamily: 'Khmer',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextButton(
                    onPressed: () => App.goTo(Signup()),
                    child: Text('Sign up!',
                      style: TextStyle(
                        color: Color(0xFF51ADD4),
                        fontSize: 16,
                        fontFamily: 'Heebo',
                        fontWeight: FontWeight.w700,
                      ),
                    )
                )
              ],
            ),
          )

          //END

        ],
      ),
    );
  }


  Future<void> login(String username, String password) async{
    Client client = Client('storedobject.com','concord');
    String status = await client.login(username, password);
    if(status==''){
      print('Successfully logged in!');

      Map<String, dynamic> person_data = await client.command(
          'list', {'className':'com.storedobject.core.Person'}
      );

      // print(person_data);
      App.goTo(Test(data: person_data));

    } else {
      App.message(status);
      print(status);
    }
  }
}

//---------------TEST PAGE

class Test extends StatelessScreen{
  final Map<String, dynamic> data;
  Test({required this.data});

  @override
  Scaffold build(BuildContext context) {

    List<dynamic> people = data['data'] ?? [];

    return Scaffold(
        backgroundColor: Color(0xFF2B2B2B),
        body:
        Column(
          children: [

            SizedBox(height: 7,),
            Row(
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(top:1,left: 3),
                      child: IconButton(
                          onPressed: () => App.goTo(LoginPage()),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF2B2B2B),
                            // minimumSize: Size(5, 20),
                          ),
                          icon: Icon(Icons.arrow_back_rounded,
                            color: Colors.white,
                          )
                      ),
                    )
                ),

                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.288),
                    child: Text('CONCORD',
                      style: TextStyle(
                          color: Color(0xFF555555),
                          fontSize: 20,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                ),

              ],
            ),

            Expanded(child: ListView.builder(

                padding: EdgeInsets.all(16),
                itemCount: people.length,
                itemBuilder: (context, index){

                  var person = people[index];
                  return Card(
                    color: Color(0xFF444444),
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      title: Text(
                        person['FirstName'] ?? "Unknown",
                        style: TextStyle(color: Colors.white),),
                      subtitle: Text(
                        person.toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                }
            ),)
          ],
        )

    );
  }
}

class Forgot extends DataScreen{

  @override
  Scaffold build(BuildContext context) {

    Field<String> email = textField(
      // textAlign: TextAlign.left,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 20, left: 8,),
            border: InputBorder.none,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            label: const Text(
              'Enter your email',
              style: TextStyle(
                color: Color(0xFFA09393),
                fontSize: 16,
                fontFamily: 'Khmer',
                fontWeight: FontWeight.w400,
              ),
            )
        )
    );

    return Scaffold(
      backgroundColor: Color(0xFF2B2B2B),
      body: Column(
        children: [

          SizedBox(height: 30,),
          Row(
            children: [
              Column(
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(top:1,left: 3),
                        child: IconButton(
                            onPressed: () => App.goTo(LoginPage()),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF2B2B2B),
                              // minimumSize: Size(5, 20),
                            ),
                            icon: Icon(Icons.arrow_back_rounded,
                              color: Colors.white,
                            )
                        ),
                      )
                  ),
                ],
              ),
              Column(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text('CONCORD',
                      style: TextStyle(
                          color: Color(0xFF555555),
                          fontSize: 20,
                          fontWeight: FontWeight.w900),
                    ),

                  ),
                ],
              ),
              Column(

              ),

            ],
          ),

          //---------------FORGOT PASSWORD

          SizedBox(height: MediaQuery.of(context).size.height*0.17,),
          Align(
            alignment: Alignment.topCenter,
            child: Text(
              'Forgot Password?',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontFamily: 'Khmer',
                fontWeight: FontWeight.w200,
              ),
            ),
          ),

          //---------------EMAIL

          SizedBox(height: MediaQuery.of(context).size.height*0.2,),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: MediaQuery.of(context).size.width*0.85,
              height: 60,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: email,
              ),
            ),
          ),

          //---------------SEND BUTTON

          SizedBox(height: 33,),
          Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () => forgot(email.value ?? ''),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF2D6C83),
                  minimumSize: Size(MediaQuery.of(context).size.width*0.85, 85),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                  ),
                  elevation: 5,
                ),
                child: Text(
                  'Send',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: 'Khmer',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
          ),

          //END

        ],
      ),
    );
  }

  Future<void> forgot(String email) async{
    // print('I forgot the password for $email');
    App.message('Forgot the password for $email');
    App.goTo(Otp());
  }
}

class Otp extends DataScreen{

  @override
  Scaffold build(BuildContext context) {

    Field<String> otp = textField(
      // textAlign: TextAlign.left,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 20, left: 8,),
            border: InputBorder.none,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            label: const Text(
              'Enter the OTP',
              style: TextStyle(
                color: Color(0xFFA09393),
                fontSize: 16,
                fontFamily: 'Khmer',
                fontWeight: FontWeight.w400,
              ),
            )
        )
    );

    return Scaffold(
      backgroundColor: Color(0xFF2B2B2B),
      body: Column(
        children: [

          SizedBox(height: 30,),
          Row(
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(top:1,left: 3),
                    child: IconButton(
                        onPressed: () => App.goTo(Forgot()),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF2B2B2B),
                          // minimumSize: Size(5, 20),
                        ),
                        icon: Icon(Icons.arrow_back_rounded,
                          color: Colors.white,
                        )
                    ),
                  )
              ),

              Align(
                alignment: Alignment.center,
                child: Text('CONCORD',
                  style: TextStyle(
                      color: Color(0xFF555555),
                      fontSize: 20,
                      fontWeight: FontWeight.w900),
                ),
              ),

            ],
          ),

          SizedBox(height: MediaQuery.of(context).size.height*0.17,),
          Align(
            alignment: Alignment.topCenter,
            child: Text(
              'Check your email',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontFamily: 'Khmer',
                fontWeight: FontWeight.w200,
              ),
            ),
          ),

          //---------------OTP

          SizedBox(height: MediaQuery.of(context).size.height*0.2),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: MediaQuery.of(context).size.width*0.85,
              height: 60,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: otp,
              ),
            ),
          ),

          SizedBox(height: 5,),
          Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Didn't get an OTP?",
                  style: TextStyle(
                    color: Color(0xFF6C6C6C),
                    fontSize: 16,
                    fontFamily: 'Khmer',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextButton(
                    onPressed: ()=>App.message('Resent!'),
                    child: Text('Resend',
                      style: TextStyle(
                        color: Color(0xFF51ADD4),
                        fontSize: 16,
                        fontFamily: 'Heebo',
                        fontWeight: FontWeight.w700,
                      ),
                    )
                )
              ],
            ),
          ),

          //---------------VERIFY OTP

          SizedBox(height: 30,),
          Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () => otp_verify(otp.value ?? ''),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF2D6C83),
                  minimumSize: Size(MediaQuery.of(context).size.width*0.85, 85),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                  ),
                  elevation: 5,
                ),
                child: Text(
                  'Verify OTP',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: 'Khmer',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              )
          ),

          //END

        ],
      ),
    );
  }

  Future<void> otp_verify(String code) async{
    App.message('Verified!');
    App.goTo(Reset());
  }
}

class Reset extends DataScreen{

  @override
  Scaffold build(BuildContext context) {

    bool obscure = true;

    Field<String> password = textField(
      obscureText: obscure,
      decoration: InputDecoration(
          suffixIcon: IconButton(
              onPressed: () => setState(() {
                obscure = !obscure;
                print(obscure);
              }
              ),

              icon: Icon(
                obscure ? Icons.visibility_off : Icons.visibility,
              )
          ),
          contentPadding: EdgeInsets.only(bottom: 20, left: 8),
          border: InputBorder.none,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          label: const Text(
            'Enter your password',
            style: TextStyle(
              color: Color(0xFF929090),
              fontSize: 16,
              fontFamily: 'Khmer',
              fontWeight: FontWeight.w400,
            ),
          )
      ),
    );

    Field<String> confirm_password = textField(
      obscureText: obscure,
      decoration: InputDecoration(
          suffixIcon: IconButton(
              onPressed: () => setState(() {
                obscure = !obscure;
                print(obscure);
              }
              ),

              icon: Icon(
                obscure ? Icons.visibility_off : Icons.visibility,
              )
          ),
          contentPadding: EdgeInsets.only(bottom: 20, left: 8),
          border: InputBorder.none,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          label: const Text(
            'Confirm your password',
            style: TextStyle(
              color: Color(0xFF929090),
              fontSize: 16,
              fontFamily: 'Khmer',
              fontWeight: FontWeight.w400,
            ),
          )
      ),
    );

    return Scaffold(
      backgroundColor: Color(0xFF2B2B2B),
      body: Column(
        children: [

          SizedBox(height: 30,),
          Row(
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(top:1,left: 3),
                    child: IconButton(
                        onPressed: () => App.goTo(Forgot()),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF2B2B2B),
                          // minimumSize: Size(5, 20),
                        ),
                        icon: Icon(Icons.arrow_back_rounded,
                          color: Colors.white,
                        )
                    ),
                  )
              ),

              Align(
                alignment: Alignment.center,
                child: Text('CONCORD',
                  style: TextStyle(
                      color: Color(0xFF555555),
                      fontSize: 20,
                      fontWeight: FontWeight.w900),
                ),
              ),

            ],
          ),

          SizedBox(height: MediaQuery.of(context).size.height*0.15,),
          Align(
            alignment: Alignment.topCenter,
            child: Text(
              'Reset Password',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontFamily: 'Khmer',
                fontWeight: FontWeight.w200,
              ),
            ),
          ),

          //---------------PASSWORDS

          SizedBox(height: MediaQuery.of(context).size.height*0.2),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: MediaQuery.of(context).size.width*0.85,
              height: 60,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: password,
              ),
            ),
          ),

          SizedBox(height: 20,),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: MediaQuery.of(context).size.width*0.85,
              height: 60,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: confirm_password,
              ),
            ),
          ),

          //---------------RESET BUTTON

          SizedBox(height: 40,),
          Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () => reset_verify(password.value ?? '', confirm_password.value ?? ''),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF2D6C83),
                  minimumSize: Size(MediaQuery.of(context).size.width*0.85, 85),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                  ),
                  elevation: 5,
                ),
                child: Text(
                  'Reset',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: 'Khmer',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              )
          ),

          //END

        ],
      ),
    );
  }

  Future<void> reset_verify(String password, String confirm_password) async{
    if(password==confirm_password){
      App.message('Password has been reset!');
      App.goTo(LoginPage());
    }
    else{
      App.message('Passwords are not matching');
    }
  }
}

class Signup extends DataScreen{

  @override
  Scaffold build(BuildContext context) {

    Field<String> signupUsername = textField(
      // textAlign: TextAlign.left,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 20, left: 8),
            border: InputBorder.none,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            label: const Text(
              'Enter your username',
              style: TextStyle(
                color: Color(0xFFA09393),
                fontSize: 16,
                fontFamily: 'Khmer',
                fontWeight: FontWeight.w400,
              ),
            )
        )
    );

    bool obscure = true;

    Field<String> signupPassword = textField(
      obscureText: obscure,
      decoration: InputDecoration(
          suffixIcon: IconButton(
              onPressed: () => setState(() {
                obscure = !obscure;
                print(obscure);
              }
              ),

              icon: Icon(
                obscure ? Icons.visibility_off : Icons.visibility,
              )
          ),
          contentPadding: EdgeInsets.only(bottom: 20, left: 8),
          border: InputBorder.none,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          label: const Text(
            'Enter your password',
            style: TextStyle(
              color: Color(0xFF929090),
              fontSize: 16,
              fontFamily: 'Khmer',
              fontWeight: FontWeight.w400,
            ),
          )
      ),
    );

    Field<String> signupConfirmPassword = textField(
      obscureText: obscure,
      decoration: InputDecoration(
          suffixIcon: IconButton(
              onPressed: () => setState(() {
                obscure = !obscure;
                print(obscure);
              }
              ),

              icon: Icon(
                obscure ? Icons.visibility_off : Icons.visibility,
              )
          ),
          contentPadding: EdgeInsets.only(bottom: 20, left: 8),
          border: InputBorder.none,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          label: const Text(
            'Enter your password',
            style: TextStyle(
              color: Color(0xFF929090),
              fontSize: 16,
              fontFamily: 'Khmer',
              fontWeight: FontWeight.w400,
            ),
          )
      ),
    );

    return Scaffold(
      backgroundColor: Color(0xFF2B2B2B),
      body: Column(
        children: [

          SizedBox(height: 30,),
          Row(
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(top:1,left: 3),
                    child: IconButton(
                        onPressed: () => App.goTo(LoginPage()),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF2B2B2B),
                          // minimumSize: Size(5, 20),
                        ),
                        icon: Icon(Icons.arrow_back_rounded,
                          color: Colors.white,
                        )
                    ),
                  )
              ),

              Align(
                alignment: Alignment.center,
                child: Text('CONCORD',
                  style: TextStyle(
                      color: Color(0xFF555555),
                      fontSize: 20,
                      fontWeight: FontWeight.w900),
                ),
              ),

            ],
          ),

          SizedBox(height: MediaQuery.of(context).size.height*0.15,),
          Align(
            alignment: Alignment.topCenter,
            child: Text(
              'New to Concord?',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontFamily: 'Khmer',
                fontWeight: FontWeight.w200,
              ),
            ),
          ),

          //---------------USERNAME, PASSWORD, CONFIRM PASSWORD

          SizedBox(height: MediaQuery.of(context).size.height*0.2),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: MediaQuery.of(context).size.width*0.85,
              height: 60,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: signupUsername,
              ),
            ),
          ),

          SizedBox(height: 20,),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: MediaQuery.of(context).size.width*0.85,
              height: 60,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: signupPassword,
              ),
            ),
          ),

          SizedBox(height: 20,),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: MediaQuery.of(context).size.width*0.85,
              height: 60,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: signupConfirmPassword,
              ),
            ),
          ),

          //---------------REGISTER BUTTON

          SizedBox(height: 36,),
          Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () =>
                    register(signupUsername.value ?? '', signupPassword.value ?? '', signupConfirmPassword.value ?? ''),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF2D6C83),
                  minimumSize: Size(MediaQuery.of(context).size.width*0.85, 85),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                  ),
                  elevation: 5,
                ),
                child: Text(
                  'Create your account',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: 'Khmer',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              )
          ),

          //---------------SIGNUP BUTTON

          SizedBox(height: 5,),
          Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account?",
                  style: TextStyle(
                    color: Color(0xFF6C6C6C),
                    fontSize: 16,
                    fontFamily: 'Khmer',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextButton(
                    onPressed: ()=>App.goTo(LoginPage()),
                    child: Text('Login',
                      style: TextStyle(
                        color: Color(0xFF51ADD4),
                        fontSize: 16,
                        fontFamily: 'Heebo',
                        fontWeight: FontWeight.w700,
                      ),
                    )
                )
              ],
            ),
          )

          //END

        ],
      ),
    );
  }

  Future<void> register(String username, String password, String confirmPassword) async{

    if (password==confirmPassword){
      App.message('$username registered successfully!');
    }
    else {
      App.message('passwords are not matching');
    }
  }
}

