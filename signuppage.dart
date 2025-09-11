import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:upwork/Privacypolicy.dart';
import 'package:upwork/Termsof%20services.dart';

class SignUp extends StatefulWidget{
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  String _userType = 'freelancer';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration:  BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF66B2FF),
              Color(0xFF0052D4),
            ],
          ),
        ),
        child: Center(
          child: Container(
            margin:  EdgeInsets.all(20),
            padding:  EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            width:500,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Logo
                  Center(
                    child: Image.asset(
                      "assets/images/wc logo1.jpg",
                      height: 80,
                    ),
                  ),
                  SizedBox(height: 10),
                  // Tagline
                  Text(
                    'Create your account',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Join thousands of freelancers and clients',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                   SizedBox(height: 30),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding:  EdgeInsets.all(5),
                    child: Row(
                      children: [
                        Expanded(
                          child: ChoiceChip(
                            label: const Text('Freelancer'),
                            selected: _userType == 'freelancer',
                            onSelected: (selected) {
                              setState(() {
                                _userType = 'freelancer';
                              });
                            },
                            selectedColor:  Color(0xFF00C053),
                            labelStyle: TextStyle(
                              color: _userType == 'freelancer' ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                        Expanded(
                          child: ChoiceChip(
                            label: const Text('Client'),
                            selected: _userType == 'client',
                            onSelected: (selected) {
                              setState(() {
                                _userType = 'client';
                              });
                            },
                            selectedColor: const Color(0xFF0066FF),
                            labelStyle: TextStyle(
                              color: _userType == 'client' ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Column(
                      children: [
                        TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            labelText: 'Full Name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            prefixIcon:  Icon(Icons.person_outline),
                          ),
                        ),
                         SizedBox(height: 20),
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            prefixIcon: const Icon(Icons.email_outlined),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.visibility_off ,
                              ),
                              onPressed: () {
                              },
                            ),
                          ),

                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _confirmPasswordController,
                          obscureText: _obscureConfirmPassword,
                          decoration: InputDecoration(
                            labelText: 'Confirm Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.visibility_off ,
                              ),
                              onPressed: () {
                              },
                            ),
                          ),
                        ),
                         SizedBox(height: 20),
                        Row(
                          children: [
                            Icon(Icons.check_box),
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                  text: 'I agree to the ',
                                  style: TextStyle(
                                    color: Colors.grey[700],
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'Terms of Service',
                                      style:  TextStyle(
                                        color: Color(0xFF0066FF),
                                        fontWeight: FontWeight.bold,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => TermsOfServices(),
                                            ),
                                          );
                                        },
                                    ),
                                    TextSpan(
                                      text: ' and ',
                                      style: TextStyle(
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'Privacy Policy',
                                      style: const TextStyle(
                                        color: Color(0xFF0066FF),
                                        fontWeight: FontWeight.bold,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => PrivacyPolicy(),
                                            ),
                                          );
                                        },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                         SizedBox(height: 20),
                        // Sign Up Button
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF0066FF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child:  Text(
                              'Create Account',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                         SizedBox(height: 20),
                        // Divider
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: Colors.grey[400],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                'OR',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: Colors.grey[400],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton.icon(
                            onPressed: () {
                            },
                            icon:   FaIcon(FontAwesomeIcons.google, size: 30, color: Colors.red),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF0066FF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),

                            label: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Sign Up With Google',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have an account? ",
                              style: TextStyle(
                                color: Colors.grey[700],
                              ),
                            ),
                            SizedBox(width: 10,),
                            ElevatedButton(onPressed: (){
                              ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF0066FF),
                              );
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUp(),));
                            },
                              child: Text('Log in'),
                            ),
                          ],
                        ),

                      ],
                    ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}