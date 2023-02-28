import 'package:flutter/material.dart';

import '../utilities/user_license_constant.dart';

class UserLicensePage extends StatelessWidget {
  const UserLicensePage({super.key});
  static const String routeName = '/user-license';

  @override
  Widget build(BuildContext context) {
    List<TextSpan> children = [
      headingText('END USER LICENCE AGREEMENT\n\n'),
      headingText2('Last updated February 06, 2023\n\n\n\n'),
      regularText(
          'Boloodo is licensed to You (End-User) by Boloodo, located and registered at unit 4 The Courtyard, Norfolk Street, Peterbortough, Cambridgeshire PE1 2NP, England ('),
      regularTextBold('Licensor'),
      regularText('''), for use only under the terms of this Licence Agreement.

By downloading the Licensed Application from Apple's software distribution platform ('App Store') and Google's software distribution platform ('Play Store'), and any update thereto (as permitted by this Licence Agreement), You indicate that You agree to be bound by all of the terms and conditions of this Licence Agreement, and that You accept this Licence Agreement. App Store and Play Store are referred to in this Licence Agreement as '''),
      regularTextBold('Services\n\n'),
      regularText(
          '''The parties of this Licence Agreement acknowledge that the Services are not a Party to this Licence Agreement and are not bound by any provisions or obligations with regard to the Licensed Application, such as warranty, liability, maintenance and support thereof. Boloodo, not the Services, is solely responsible for the Licensed Application and the content thereof.

This Licence Agreement may not provide for usage rules for the Licensed Application that are in conflict with the latest'''),
      onTapText('Apple Media Services Terms and Conditions'),
      regularText('and '),
      onTapText('Google Play Terms of Service'),
      regularTextBold('Usage Rules'),
      regularText(
          '''. Boloodo acknowledges that it had the opportunity to review the Usage Rules and this Licence Agreement is not conflicting with them.

Boloodo when purchased or downloaded through the Services, is licensed to You for use only under the terms of this Licence Agreement. The Licensor reserves all rights not expressly granted to You. Boloodo is to be used on devices that operate with Apple's operating systems ('iOS' and 'Mac OS') or Google's operating system ('Android').'''),
      headingText('\n\nTABLE OF CONTENTS\n\n'),
      tableofContentText('1. THE APPLICATION'),
      tableofContentText('2. SCOPE OF LICENCE'),
      tableofContentText('3. TECHNICAL REQUIREMENTS'),
      tableofContentText('4. MAINTENANCE AND SUPPORT'),
      tableofContentText('5. USE OF DATA'),
      tableofContentText('6. USER-GENERATED CONTRIBUTIONS'),
      tableofContentText('7. CONTRIBUTION LICENCE'),
      tableofContentText('8. LIABILITY'),
      tableofContentText('9. WARRANTY'),
      tableofContentText('10. PRODUCT CLAIMS'),
      tableofContentText('11. LEGAL COMPLIANCE'),
      tableofContentText('12. CONTACT INFORMATION'),
      tableofContentText('13. TERMINATION'),
      tableofContentText('14. THIRD-PARTY TERMS OF AGREEMENTS AND BENEFICIARY'),
      tableofContentText('15. INTELLECTUAL PROPERTY RIGHTS'),
      tableofContentText('16. APPLICABLE LAW'),
      tableofContentText('17. MISCELLANEOUS'),
      headingText('\n\n1. THE APPLICATION\n\n'),
      regularText(
          '''Boloodo ('Licensed Application') is a piece of software created to provide a platform for users to buy and sell goods and services using Bitcoin and Crypto — and customised for iOS and Android mobile devices ('Devices'). It is used to connect users to transact in Bitcoin and Crypto.

All users take the liability to act within the laws of their countries'''),
      headingText('\n\n2. SCOPE OF LICENCE\n\n'),
      regularText(
          '''2.1  You are given a non-transferable, non-exclusive, non-sublicensable licence to install and use the Licensed Application on any Devices that You (End-User) own or control and as permitted by the Usage Rules, with the exception that such Licensed Application may be accessed and used by other accounts associated with You (End-User, The Purchaser) via Family Sharing or volume purchasing.

2.2  This licence will also govern any updates of the Licensed Application provided by Licensor that replace, repair, and/or supplement the first Licensed Application, unless a separate licence is provided for such update, in which case the terms of that new licence will govern.

2.3  You may not share or make the Licensed Application available to third parties (unless to the degree allowed by the Usage Rules, and with Boloodo's prior written consent), sell, rent, lend, lease or otherwise redistribute the Licensed Application.

2.4  You may not reverse engineer, translate, disassemble, integrate, decompile, remove, modify, combine, create derivative works or updates of, adapt, or attempt to derive the source code of the Licensed Application, or any part thereof (except with Boloodo's prior written consent).

2.5  You may not copy (excluding when expressly authorised by this licence and the Usage Rules) or alter the Licensed Application or portions thereof. You may create and store copies only on devices that You own or control for backup keeping under the terms of this licence, the Usage Rules, and any other terms and conditions that apply to the device or software used. You may not remove any intellectual property notices. You acknowledge that no unauthorised third parties may gain access to these copies at any time. If you sell your Devices to a third party, you must remove the Licensed Application from the Devices before doing so.

2.6  Violations of the obligations mentioned above, as well as the attempt of such infringement, may be subject to prosecution and damages.

2.7  Licensor reserves the right to modify the terms and conditions of licensing.

2.8  Nothing in this licence should be interpreted to restrict third-party terms. When using the Licensed Application, You must ensure that You comply with applicable third-party terms and conditions.'''),
      headingText('\n\n3. TECHNICAL REQUIREMENTS\n\n'),
      regularText(
          '''3.1  Licensor attempts to keep the Licensed Application updated so that it complies with modified/new versions of the firmware and new hardware. You are not granted rights to claim such an update.

3.2  You acknowledge that it is Your responsibility to confirm and determine that the app end-user device on which You intend to use the Licensed Application satisfies the technical specifications mentioned above.

3.3  Licensor reserves the right to modify the technical specifications as it sees appropriate at any time.'''),
      headingText('\n\n4. MAINTENANCE AND SUPPORT\n\n'),
      regularText(
          '''4.1  The Licensor is solely responsible for providing any maintenance and support services for this Licensed Application. You can reach the Licensor at the email address listed in the App Store or Play Store Overview for this Licensed Application.

4.2  Boloodo and the End-User acknowledge that the Services have no obligation whatsoever to furnish any maintenance and support services with respect to the Licensed Application.'''),
      headingText('\n\n5. USE OF DATA\n\n'),
      regularText(
          '''You acknowledge that Licensor will be able to access and adjust Your downloaded Licensed Application content and Your personal information, and that Licensor's use of such material and information is subject to Your legal agreements with Licensor and Licensor's privacy policy, which can be accessed by Clicking more at the top of the page.

You acknowledge that the Licensor may periodically collect and use technical data and related information about your device, system, and application software, and peripherals, offer product support, facilitate the software updates, and for purposes of providing other services to you (if any) related to the Licensed Application. Licensor may also use this information to improve its products or to provide services or technologies to you, as long as it is in a form that does not personally identify you.'''),
      headingText('\n\n6. USER-GENERATED CONTRIBUTIONS\n\n'),
      regularText(
          '''The Licensed Application may invite you to chat, contribute to, or participate in blogs, message boards, online forums, and other functionality, and may provide you with the opportunity to create, submit, post, display, transmit, perform, publish, distribute, or broadcast content and materials to us or in the Licensed Application, including but not limited to text, writings, video, audio, photographs, graphics, comments, suggestions, or personal information or other material (collectively, 'Contributions'). Contributions may be viewable by other users of the Licensed Application and through third-party websites or applications. As such, any Contributions you transmit may be treated as non-confidential and non-proprietary. When you create or make available any Contributions, you thereby represent and warrant that:

1. The creation, distribution, transmission, public display, or performance, and the accessing, downloading, or copying of your Contributions do not and will not infringe the proprietary rights, including but not limited to the copyright, patent, trademark, trade secret, or moral rights of any third party.
2. You are the creator and owner of or have the necessary licences, rights, consents, releases, and permissions to use and to authorise us, the Licensed Application, and other users of the Licensed Application to use your Contributions in any manner contemplated by the Licensed Application and this Licence Agreement.
3. You have the written consent, release, and/or permission of each and every identifiable individual person in your Contributions to use the name or likeness or each and every such identifiable individual person to enable inclusion and use of your Contributions in any manner contemplated by the Licensed Application and this Licence Agreement.
4. Your Contributions are not false, inaccurate, or misleading.
5. Your Contributions are not unsolicited or unauthorised advertising, promotional materials, pyramid schemes, chain letters, spam, mass mailings, or other forms of solicitation.
6. Your Contributions are not obscene, lewd, lascivious, filthy, violent, harassing, libellous, slanderous, or otherwise objectionable (as determined by us).
7. Your Contributions do not ridicule, mock, disparage, intimidate, or abuse anyone.
8. Your Contributions are not used to harass or threaten (in the legal sense of those terms) any other person and to promote violence against a specific person or class of people.
9. Your Contributions do not violate any applicable law, regulation, or rule.
10. Your Contributions do not violate the privacy or publicity rights of any third party.
11. Your Contributions do not violate any applicable law concerning child pornography, or otherwise intended to protect the health or well-being of minors.
12. Your Contributions do not include any offensive comments that are connected to race, national origin, gender, sexual preference, or physical handicap.
13. Your Contributions do not otherwise violate, or link to material that violates, any provision of this Licence Agreement, or any applicable law or regulation.

Any use of the Licensed Application in violation of the foregoing violates this Licence Agreement and may result in, among other things, termination or suspension of your rights to use the Licensed Application.'''),
      headingText('\n\n7. CONTRIBUTION LICENCE\n\n'),
      regularText(
          '''By posting your Contributions to any part of the Licensed Application or making Contributions accessible to the Licensed Application by linking your account from the Licensed Application to any of your social networking accounts, you automatically grant, and you represent and warrant that you have the right to grant, to us an unrestricted, unlimited, irrevocable, perpetual, non-exclusive, transferable, royalty-free, fully-paid, worldwide right, and licence to host, use copy, reproduce, disclose, sell, resell, publish, broad cast, retitle, archive, store, cache, publicly display, reformat, translate, transmit, excerpt (in whole or in part), and distribute such Contributions (including, without limitation, your image and voice) for any purpose, commercial advertising, or otherwise, and to prepare derivative works of, or incorporate in other works, such as Contributions, and grant and authorise sublicences of the foregoing. The use and distribution may occur in any media formats and through any media channels.

This licence will apply to any form, media, or technology now known or hereafter developed, and includes our use of your name, company name, and franchise name, as applicable, and any of the trademarks, service marks, trade names, logos, and personal and commercial images you provide. You waive all moral rights in your Contributions, and you warrant that moral rights have not otherwise been asserted in your Contributions.

We do not assert any ownership over your Contributions. You retain full ownership of all of your Contributions and any intellectual property rights or other proprietary rights associated with your Contributions. We are not liable for any statements or representations in your Contributions provided by you in any area in the Licensed Application. You are solely responsible for your Contributions to the Licensed Application and you expressly agree to exonerate us from any and all responsibility and to refrain from any legal action against us regarding your Contributions.

We have the right, in our sole and absolute discretion, (1) to edit, redact, or otherwise change any Contributions; (2) to recategorise any Contributions to place them in more appropriate locations in the Licensed Application; and (3) to prescreen or delete any Contributions at any time and for any reason, without notice. We have no obligation to monitor your Contributions.'''),
      headingText('\n\n8. LIABILITY\n\n'),
      regularText(
          '''8.1  Licensor takes no accountability or responsibility for any damages caused due to a breach of duties according to Section 2 of this Licence Agreement. To avoid data loss, You are required to make use of backup functions of the Licensed Application to the extent allowed by applicable third-party terms and conditions of use. You are aware that in case of alterations or manipulations of the Licensed Application, You will not have access to the Licensed Application.'''),
      headingText('\n\n9. WARRANTY\n\n'),
      regularText(
          '''9.1  Licensor warrants that the Licensed Application is free of spyware, trojan horses, viruses, or any other malware at the time of Your download. Licensor warrants that the Licensed Application works as described in the user documentation.

9.2  No warranty is provided for the Licensed Application that is not executable on the device, that has been unauthorisedly modified, handled inappropriately or culpably, combined or installed with inappropriate hardware or software, used with inappropriate accessories, regardless if by Yourself or by third parties, or if there are any other reasons outside of Boloodo's sphere of influence that affect the executability of the Licensed Application.

9.3  You are required to inspect the Licensed Application immediately after installing it and notify Boloodo about issues discovered without delay by email provided in Contact Information. The defect report will be taken into consideration and further investigated if it has been emailed within a period of seven (7) days after discovery.

9.4  If we confirm that the Licensed Application is defective, Boloodo reserves a choice to remedy the situation either by means of solving the defect or substitute delivery.

9.5  In the event of any failure of the Licensed Application to conform to any applicable warranty, You may notify the Services Store Operator, and Your Licensed Application purchase price will be refunded to You. To the maximum extent permitted by applicable law, the Services Store Operator will have no other warranty obligation whatsoever with respect to the Licensed Application, and any other losses, claims, damages, liabilities, expenses, and costs attributable to any negligence to adhere to any warranty.

9.6  If the user is an entrepreneur, any claim based on faults expires after a statutory period of limitation amounting to twelve (12) months after the Licensed Application was made available to the user. The statutory periods of limitation given by law apply for users who are consumers.'''),
      headingText('\n\n10. PRODUCT CLAIMS\n\n'),
      regularText(
          '''Boloodo and the End-User acknowledge that Boloodo, and not the Services, is responsible for addressing any claims of the End-User or any third party relating to the Licensed Application or the End-User’s possession and/or use of that Licensed Application, including, but not limited to:

(i) product liability claims;
   
(ii) any claim that the Licensed Application fails to conform to any applicable legal or regulatory requirement; and

(iii) claims arising under consumer protection, privacy, or similar legislation, including in connection with Your Licensed Application’s use of the HealthKit and HomeKit.'''),
      headingText('\n\n11. LEGAL COMPLIANCE\n\n'),
      regularText(
          '''You represent and warrant that You are not located in a country that is subject to a US Government embargo, or that has been designated by the US Government as a 'terrorist supporting' country; and that You are not listed on any US Government list of prohibited or restricted parties.'''),
      headingText('\n\n12. CONTACT INFORMATION\n\n'),
      regularText(
          '''For general inquiries, complaints, questions or claims concerning the Licensed Application, please contact:
       
Boloodo
unit 4 The Courtyard
Norfolk Street
Peterbortough, Cambridgeshire PE1 2NP
England
info@boloodo.com'''),
      headingText('\n\n13. TERMINATION\n\n'),
      regularText(
          'The licence is valid until terminated by Boloodo or by You. Your rights under this licence will terminate automatically and without notice from Boloodo if You fail to adhere to any term(s) of this licence. Upon Licence termination, You shall stop all use of the Licensed Application, and destroy all copies, full or partial, of the Licensed Application.'),
      headingText(
          '\n\n14. THIRD-PARTY TERMS OF AGREEMENTS AND BENEFICIARY\n\n'),
      regularText(
          '''Boloodo represents and warrants that Boloodo will comply with applicable third-party terms of agreement when using Licensed Application.

In Accordance with Section 9 of the 'Instructions for Minimum Terms of Developer's End-User Licence Agreement', both Apple and Google and their subsidiaries shall be third-party beneficiaries of this End User Licence Agreement and — upon Your acceptance of the terms and conditions of this Licence Agreement, both Apple and Google will have the right (and will be deemed to have accepted the right) to enforce this End User Licence Agreement against You as a third-party beneficiary thereof.'''),
      headingText('\n\n15. INTELLECTUAL PROPERTY RIGHTS\n\n'),
      regularText(
          '''Boloodo and the End-User acknowledge that, in the event of any third-party claim that the Licensed Application or the End-User's possession and use of that Licensed Application infringes on the third party's intellectual property rights, Boloodo, and not the Services, will be solely responsible for the investigation, defence, settlement, and discharge or any such intellectual property infringement claims.'''),
      headingText('\n\n16. APPLICABLE LAW\n\n'),
      regularText(
          '''This Licence Agreement is governed by the laws of England and Wales, English law, excluding its conflicts of law rules.'''),
      headingText('\n\n17. MISCELLANEOUS\n\n'),
      regularText(
          '''17.1  If any of the terms of this agreement should be or become invalid, the validity of the remaining provisions shall not be affected. Invalid terms will be replaced by valid ones formulated in a way that will achieve the primary purpose.
               
17.2  Collateral agreements, changes and amendments are only valid if laid down in writing. The preceding clause can only be waived in writing.''')
    ];
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 30),
          child: RichText(
            text: TextSpan(
              children: children,
            ),
          ),
        ),
      ),
    );
  }

  TextSpan headingText(String Text) {
    return TextSpan(
        text: Text,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24));
  }

  TextSpan headingText2(String Text) {
    return TextSpan(
        text: Text, style: const TextStyle(fontSize: 14, color: Colors.grey));
  }

  TextSpan regularText(String Text) {
    return TextSpan(text: Text, style: const TextStyle(fontSize: 16));
  }

  TextSpan onTapText(String Text) {
    return TextSpan(
        text: Text,
        style: const TextStyle(
            color: Colors.blue,
            decoration: TextDecoration.underline,
            fontSize: 16));
  }

  TextSpan tableofContentText(String Text) {
    return TextSpan(
        text: '$Text\n\n',
        style: const TextStyle(
            color: Colors.blue,
            decoration: TextDecoration.underline,
            fontSize: 16));
  }

  TextSpan regularTextBold(String Text) {
    return TextSpan(
        text: Text,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16));
  }
}
