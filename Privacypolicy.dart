import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: Text('Privacy Policy'),
       backgroundColor: Color(0xFF0066FF),
       foregroundColor: Colors.white,
     ),
     body: SingleChildScrollView(
       child: Padding(
         padding: const EdgeInsets.all(8.0),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Text(
               'WorkConnect Privacy Policy',
               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
             ),
             SizedBox(height: 20),
             Text(
               'Last Updated: August 27, 2025',
               style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
             ),
             SizedBox(height: 30),
             Text(
               '1. Information We Collect',
               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0066FF)),
             ),
             Text(
               'We collect information you provide directly to us, such as when you create an account, complete your profile, or communicate with us. This may include:',
               style: TextStyle(fontSize: 16, height: 1.5),
               textAlign: TextAlign.justify,
             ),
             SizedBox(height: 10),
             Text(
               '• Name, email address, and contact information',
               style: TextStyle(fontSize: 16, height: 1.5),
             ),
             Text(
               '• Profile information, including skills, experience, and portfolio',
               style: TextStyle(fontSize: 16, height: 1.5),
             ),
             Text(
               '• Payment information for freelancers and clients',
               style: TextStyle(fontSize: 16, height: 1.5),
             ),
             Text(
               '• Communications with other users through the platform',
               style: TextStyle(fontSize: 16, height: 1.5),
             ),
             SizedBox(height: 20),
             Text(
               '2. How We Use Your Information',
               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0066FF)),
             ),
             Text(
               'We use the information we collect to:',
               style: TextStyle(fontSize: 16, height: 1.5),
               textAlign: TextAlign.justify,
             ),
             SizedBox(height: 10),
             Text(
               '• Provide, maintain, and improve our services',
               style: TextStyle(fontSize: 16, height: 1.5),
             ),
             Text(
               '• Facilitate connections between freelancers and clients',
               style: TextStyle(fontSize: 16, height: 1.5),
             ),
             Text(
               '• Process transactions and send related information',
               style: TextStyle(fontSize: 16, height: 1.5),
             ),
             Text(
               '• Send you technical notices and support messages',
               style: TextStyle(fontSize: 16, height: 1.5),
             ),
             Text(
               '• Respond to your comments and questions',
               style: TextStyle(fontSize: 16, height: 1.5),
             ),
             SizedBox(height: 20),
             Text(
               '3. Information Sharing',
               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0066FF)),
             ),
             Text(
               'We may share your information with:',
               style: TextStyle(fontSize: 16, height: 1.5),
               textAlign: TextAlign.justify,
             ),
             SizedBox(height: 10),
             Text(
               '• Other users as necessary to facilitate work relationships',
               style: TextStyle(fontSize: 16, height: 1.5),
             ),
             Text(
               '• Service providers who perform services on our behalf',
               style: TextStyle(fontSize: 16, height: 1.5),
             ),
             Text(
               '• Law enforcement when required by law or to protect our rights',
               style: TextStyle(fontSize: 16, height: 1.5),
             ),
             Text(
               '• Business transfers in connection with a merger or acquisition',
               style: TextStyle(fontSize: 16, height: 1.5),
             ),
             SizedBox(height: 20),
             Text(
               '4. Data Security',
               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0066FF)),
             ),
             Text(
               'We implement appropriate security measures to protect your personal information. However, no method of transmission over the Internet or electronic storage is 100% secure, so we cannot guarantee absolute security.',
               style: TextStyle(fontSize: 16, height: 1.5),
               textAlign: TextAlign.justify,
             ),
             SizedBox(height: 20),
             Text(
               '5. Your Choices',
               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0066FF)),
             ),
             Text(
               'You can update your account information by accessing your profile settings. You may also deactivate your account at any time by contacting us',
               style: TextStyle(fontSize: 16, height: 1.5),
               textAlign: TextAlign.justify,
             ),
             SizedBox(height: 20),
             Text(
               '6. Cookies and Tracking',
               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0066FF)),
             ),
             Text(
               'We use cookies and similar tracking technologies to track activity on our Service and hold certain information to improve user experience.',
               style: TextStyle(fontSize: 16, height: 1.5),
               textAlign: TextAlign.justify,
             ),
             SizedBox(height: 20),
             Text(
               '7. Children\'s Privacy',
               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0066FF)),
             ),
             Text(
               'Our Service is not intended for use by children under the age of 18. We do not knowingly collect personal information from children under 18.',
               style: TextStyle(fontSize: 16, height: 1.5),
               textAlign: TextAlign.justify,
             ),
             SizedBox(height: 20),
             Text(
               '8. Changes to This Policy',
               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0066FF)),
             ),
             Text(
               'We may update our Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page and updating the "Last Updated" date.',
               style: TextStyle(fontSize: 16, height: 1.5),
               textAlign: TextAlign.justify,
             ),
             SizedBox(height: 30),
             Text(
               'If you have any questions about this Privacy Policy, please contact us at privacy@workconnect.com.',
               style: TextStyle(fontStyle: FontStyle.italic),
             ),
           ],
         ),
       ),
     ),
   );
  }

}