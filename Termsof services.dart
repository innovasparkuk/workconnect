import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TermsOfServices extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terms of Service'),
        backgroundColor: Color(0xFF0066FF),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'WorkConnect Terms of Service',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'Last Updated: August 27, 2025',
                style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
              ),
              SizedBox(height: 30),
              Text(
                '1. Acceptance of Terms',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0066FF)),
              ),
              Text(
                'By accessing or using the WorkConnect platform, you agree to be bound by these Terms of Service and all applicable laws and regulations.',
                style: TextStyle(fontSize: 16, height: 1.5),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 20),
              Text(
                '2. User Accounts',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0066FF)),
              ),
              Text(
                'You must create an account to access certain features of the Service. You are responsible for maintaining the confidentiality of your account information, including your password, and for all activity that occurs under your account.',
                style: TextStyle(fontSize: 16, height: 1.5),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 20),
              Text(
                '3. User Conduct',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0066FF)),
              ),
              Text(
                'You agree not to engage in any of the following prohibited activities: (a) copying, distributing, or disclosing any part of the Service in any medium; (b) using any automated system to access the Service; (c) interfering with or disrupting the Service; (d) attempting to circumvent any content filtering techniques we employ',
                style: TextStyle(fontSize: 16, height: 1.5),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 20),
              Text(
                '4. Content Rights',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0066FF)),
              ),
              Text(
                'You retain all ownership rights to the content you post on WorkConnect. However, by posting content, you grant WorkConnect a worldwide, non-exclusive, royalty-free license to use, display, and distribute your content for the purpose of operating and providing the Service.',
                style: TextStyle(fontSize: 16, height: 1.5),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 20),
              Text(
                '5. Payments and Fees',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0066FF)),
              ),
              Text(
                'WorkConnect charges fees for certain services. All fees are stated in U.S. dollars. You are responsible for paying all fees and applicable taxes associated with your use of the Service.',
                style: TextStyle(fontSize: 16, height: 1.5),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 20),
              Text(
                '6. Termination',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0066FF)),
              ),
              Text(
                'We may terminate or suspend your account immediately, without prior notice or liability, for any reason whatsoever, including without limitation if you breach the Terms.',
                style: TextStyle(fontSize: 16, height: 1.5),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 20),
              Text(
                '7. Limitation of Liability',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0066FF)),
              ),
              Text(
                'In no event shall WorkConnect, nor its directors, employees, partners, agents, suppliers, or affiliates, be liable for any indirect, incidental, special, consequential or punitive damages, including without limitation, loss of profits, data, use, goodwill, or other intangible losses.',
                style: TextStyle(fontSize: 16, height: 1.5),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 20),
              Text(
                '8. Changes to Terms',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0066FF)),
              ),
              Text(
                'We reserve the right, at our sole discretion, to modify or replace these Terms at any time. If a revision is material we will provide at least 30 days notice prior to any new terms taking effect.',
                style: TextStyle(fontSize: 16, height: 1.5),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 30),
              Text(
                'If you have any questions about these Terms, please contact us at legal@workconnect.com.',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      ),
    );
  }

}