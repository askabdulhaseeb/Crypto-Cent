// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:flutter_html/flutter_html.dart';

// class UserTemp extends StatelessWidget {
//   const UserTemp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Center(
//           child: SingleChildScrollView(
//             child: Html(
//               data: """
//                 <div align="center">
//     <div align="center">
//         <div align="center">
//             <div align="center">
//                 <div align="center">
//                     <div align="center"><b>END USER&nbsp;LICENCE&nbsp;AGREEMENT<b></div>
//                 </div>
//             </div>
//             <div align="center"><br></div>
//             <div align="center"><strong>Last updated&nbsp;</strong><strong>February 06, 2023</strong></div>
//             <div align="center"><br></div>
//             <div align="center"><br></div>
//         </div>
//     </div>
//     <div align="center"><br></div>
//     <div align="center">
//         <div>Boloodo&nbsp;is licensed to You (End-User) by&nbsp;Boloodo, located&nbsp;and registered&nbsp;at&nbsp;unit 4 The Courtyard,&nbsp;Norfolk Street,&nbsp;Peterbortough,&nbsp;Cambridgeshire&nbsp;PE1 2NP, England&nbsp;(&apos;<strong>Licensor</strong>&apos;), for use only under the terms of this&nbsp;Licence&nbsp;Agreement.</div>
//     </div>
//     <div align="center"><br></div>
//     <div align="center">
//         <div>By downloading the Licensed Application from&nbsp;Apple&apos;s software distribution platform (&apos;App Store&apos;)&nbsp;and&nbsp;Google&apos;s software distribution platform (&apos;Play Store&apos;), and any update thereto (as permitted by this&nbsp;Licence&nbsp;Agreement), You indicate that You agree to be bound by all of the terms and conditions of this&nbsp;Licence&nbsp;Agreement, and that You accept this&nbsp;Licence&nbsp;Agreement.&nbsp;App Store and Play Store are&nbsp;referred to in this&nbsp;Licence&nbsp;Agreement as&nbsp;&apos;<strong>Services</strong>&apos;.</div>
//     </div>
//     <div align="center"><br></div>
//     <div align="center">
//         <div>The parties of this&nbsp;Licence&nbsp;Agreement acknowledge that the Services are not a Party to this&nbsp;Licence&nbsp;Agreement and are not bound by any provisions or obligations with regard to the Licensed Application, such as warranty, liability, maintenance and support thereof.&nbsp;Boloodo, not the Services, is solely responsible for the Licensed Application and the content thereof.</div>
//     </div>
//     <div align="center"><br></div>
//     <div align="center">
//         <div>This&nbsp;Licence&nbsp;Agreement may not provide for usage rules for the Licensed Application that are in conflict with the latest&nbsp;<a href="https://www.apple.com/legal/internet-services/itunes/us/terms.html" rel="noopener noreferrer" target="_blank">Apple Media Services Terms and Conditions</a> and&nbsp;<a href="https://play.google.com/intl/en_US/about/play-terms/" rel="noopener noreferrer" target="_blank">Google Play Terms of Service</a> (&apos;<strong>Usage Rules</strong>&apos;).&nbsp;Boloodo&nbsp;acknowledges that it had the opportunity to review the Usage Rules and this&nbsp;Licence&nbsp;Agreement is not conflicting with them.</div>
//         <div><br></div>
//         <div>Boloodo&nbsp;when purchased or downloaded through the Services, is licensed to You for use only under the terms of this&nbsp;Licence&nbsp;Agreement. The Licensor reserves all rights not expressly granted to You.&nbsp;Boloodo&nbsp;is to be used on devices that operate with&nbsp;Apple&apos;s operating systems (&apos;iOS&apos; and &apos;Mac OS&apos;)&nbsp;or&nbsp;Google&apos;s operating system (&apos;Android&apos;).</div>
//         <div><br></div>
//         <div><br></div>
//         <div><strong>TABLE OF CONTENTS</strong></div>
//         <div><br></div>
//         <div><a href="https://app.termly.io/document/eula/94b731e1-de93-46a6-959d-415d991a0404#application">1. THE APPLICATION</a></div>
//         <div><a href="https://app.termly.io/document/eula/94b731e1-de93-46a6-959d-415d991a0404#scope">2. SCOPE OF&nbsp;LICENCE</a></div>
//         <div><a href="https://app.termly.io/document/eula/94b731e1-de93-46a6-959d-415d991a0404#requirements">3. TECHNICAL REQUIREMENTS</a></div>
//         <div><a href="https://app.termly.io/document/eula/94b731e1-de93-46a6-959d-415d991a0404#support">4. MAINTENANCE AND SUPPORT</a></div>
//         <div><a href="https://app.termly.io/document/eula/94b731e1-de93-46a6-959d-415d991a0404#datause">5. USE OF DATA</a></div>
//         <div><a href="https://app.termly.io/document/eula/94b731e1-de93-46a6-959d-415d991a0404#ugc">6. USER-GENERATED CONTRIBUTIONS</a></div>
//         <div><a href="https://app.termly.io/document/eula/94b731e1-de93-46a6-959d-415d991a0404#contribution">7. CONTRIBUTION&nbsp;LICENCE</a></div>
//         <div><a href="https://app.termly.io/document/eula/94b731e1-de93-46a6-959d-415d991a0404#liability">8. LIABILITY</a></div>
//         <div><a href="https://app.termly.io/document/eula/94b731e1-de93-46a6-959d-415d991a0404#warranty">9. WARRANTY</a></div>
//         <div><a href="https://app.termly.io/document/eula/94b731e1-de93-46a6-959d-415d991a0404#productclaims">10. PRODUCT CLAIMS</a></div>
//         <div><a href="https://app.termly.io/document/eula/94b731e1-de93-46a6-959d-415d991a0404#compliance">11. LEGAL COMPLIANCE</a></div>
//         <div><a href="https://app.termly.io/document/eula/94b731e1-de93-46a6-959d-415d991a0404#contact">12. CONTACT INFORMATION</a></div>
//         <div><a href="https://app.termly.io/document/eula/94b731e1-de93-46a6-959d-415d991a0404#termination">13. TERMINATION</a></div>
//         <div><a href="https://app.termly.io/document/eula/94b731e1-de93-46a6-959d-415d991a0404#thirdparty">14. THIRD-PARTY TERMS OF AGREEMENTS AND BENEFICIARY</a></div>
//         <div><a href="https://app.termly.io/document/eula/94b731e1-de93-46a6-959d-415d991a0404#ipr">15. INTELLECTUAL PROPERTY RIGHTS</a></div>
//         <div><a href="https://app.termly.io/document/eula/94b731e1-de93-46a6-959d-415d991a0404#law">16. APPLICABLE LAW</a></div>
//         <div><a href="https://app.termly.io/document/eula/94b731e1-de93-46a6-959d-415d991a0404#misc">17. MISCELLANEOUS</a></div>
//         <div><br></div>
//         <div><br></div>
//     </div>
//     <div align="center">
//         <div id="application"><strong><strong>1.</strong><strong>&nbsp;THE APPLICATION</strong></strong></div>
//     </div>
//     <div align="center"><br></div>
//     <div align="center">
//         <div>Boloodo&nbsp;(&apos;<strong>Licensed Application</strong>&apos;) is a piece of software created to&nbsp;provide a platform for users to buy and sell goods and services using Bitcoin and Crypto&nbsp;&mdash; and&nbsp;customised&nbsp;for&nbsp;iOS&nbsp;and&nbsp;Android&nbsp;mobile devices (&apos;<strong>D</strong><strong>evices</strong>&apos;). It is used to&nbsp;connect users to transact in Bitcoin and Crypto.</div>
//         <div><br></div>
//         <div>All users take the liability to act within the laws of their countries</div>
//         <div><br></div>
//         <div><br></div>
//         <div id="scope"><strong><strong><strong>2. SCOPE OF&nbsp;LICENCE</strong></strong></strong></div>
//     </div>
//     <div align="center"><br></div>
//     <div align="center">
//         <div>2.1 &nbsp;You are given a non-transferable, non-exclusive, non-sublicensable&nbsp;licence&nbsp;to install and use the Licensed Application on any Devices that You (End-User) own or control and as permitted by the Usage Rules, with the exception that such Licensed Application may be accessed and used by other accounts associated with You (End-User, The Purchaser) via Family Sharing or volume purchasing.</div>
//         <div><br></div>
//         <div>2.2 &nbsp;This&nbsp;licence&nbsp;will also govern any updates of the Licensed Application provided by Licensor that replace, repair, and/or supplement the first Licensed Application, unless a separate&nbsp;licence&nbsp;is provided for such update, in which case the terms of that new&nbsp;licence&nbsp;will govern.</div>
//         <div><br></div>
//         <div>2.3 &nbsp;You may not share or make the Licensed Application available to third parties (unless to the degree allowed by the Usage Rules, and with&nbsp;Boloodo&apos;s prior written consent), sell, rent, lend, lease or otherwise redistribute the Licensed Application.</div>
//         <div><br></div>
//         <div>2.4 &nbsp;You may not reverse engineer, translate, disassemble, integrate, decompile, remove, modify, combine, create derivative works or updates of, adapt, or attempt to derive the source code of the Licensed Application, or any part thereof (except with&nbsp;Boloodo&apos;s prior written consent).</div>
//         <div><br></div>
//         <div>2.5 &nbsp;You may not copy (excluding when expressly&nbsp;authorised&nbsp;by this&nbsp;licence&nbsp;and the Usage Rules) or alter the Licensed Application or portions thereof. You may create and store copies only on devices that You own or control for backup keeping under the terms of this&nbsp;licence, the Usage Rules, and any other terms and conditions that apply to the device or software used. You may not remove any intellectual property notices. You acknowledge that no&nbsp;unauthorised&nbsp;third parties may gain access to these copies at any time. If you sell your Devices to a third party, you must remove the Licensed Application from the Devices before doing so.</div>
//         <div><br></div>
//         <div>2.6 &nbsp;Violations of the obligations mentioned above, as well as the attempt of such infringement, may be subject to prosecution and damages.</div>
//         <div><br></div>
//         <div>2.7 &nbsp;Licensor reserves the right to modify the terms and conditions of licensing.</div>
//         <div><br></div>
//         <div>2.8 &nbsp;Nothing in this&nbsp;licence&nbsp;should be interpreted to restrict third-party terms. When using the Licensed Application, You must ensure that You comply with applicable third-party terms and conditions.</div>
//     </div>
//     <div align="center"><br></div>
//     <div align="center">
//         <div><br></div>
//         <div id="requirements"><strong><strong><strong><strong>3. TECHNICAL REQUIREMENTS</strong></strong></strong></strong></div>
//         <div><br></div>
//         <div>3.1 &nbsp;Licensor attempts to keep the Licensed Application updated so that it complies with modified/new versions of the firmware and new hardware. You are not granted rights to claim such an update.</div>
//         <div><br></div>
//         <div>3.2 &nbsp;You acknowledge that it is Your responsibility to confirm and determine that the app end-user device on which You intend to use the Licensed Application satisfies the technical specifications mentioned above.</div>
//         <div><br></div>
//         <div>3.3 &nbsp;Licensor reserves the right to modify the technical specifications as it sees appropriate at any time.</div>
//         <div><br></div>
//         <div><br></div>
//         <div id="support"><strong><strong><strong><strong>4. MAINTENANCE AND SUPPORT</strong></strong></strong></strong></div>
//         <div><br></div>
//         <div>4.1 &nbsp;The Licensor is solely responsible for providing any maintenance and support services for this Licensed Application. You can reach the Licensor at the email address listed in the&nbsp;App Store&nbsp;or&nbsp;Play Store&nbsp;Overview for this Licensed Application.</div>
//         <div><br></div>
//         <div>4.2&nbsp;&nbsp;Boloodo&nbsp;and the End-User acknowledge that the Services have no obligation whatsoever to furnish any maintenance and support services with respect to the Licensed Application.</div>
//         <div><br></div>
//         <div><br></div>
//         <div id="datause"><strong><strong><strong><strong>5. USE OF DATA</strong></strong></strong></strong></div>
//         <div><br></div>
//         <div>You acknowledge that Licensor will be able to access and adjust Your downloaded Licensed Application content and Your personal information, and that Licensor&apos;s use of such material and information is subject to Your legal agreements with Licensor and Licensor&apos;s privacy policy, which can be accessed by&nbsp;Clicking more at the top of the page.</div>
//         <div><br></div>
//         <div>You acknowledge that the Licensor may periodically collect and use technical data and related information about your device, system, and application software, and peripherals, offer product support, facilitate the software updates, and for purposes of providing other services to you (if any) related to the Licensed Application. Licensor may also use this information to improve its products or to provide services or technologies to you, as long as it is in a form that does not personally identify you.</div>
//         <div><br></div>
//         <div><br></div>
//         <div id="ugc"><strong><strong><strong><strong>6. USER-GENERATED CONTRIBUTIONS</strong></strong></strong></strong></div>
//         <div><br></div>
//         <div>The Licensed Application may invite you to chat, contribute to, or participate in blogs, message boards, online forums, and other functionality, and may provide you with the opportunity to create, submit, post, display, transmit, perform, publish, distribute, or broadcast content and materials to us or in the Licensed Application, including but not limited to text, writings, video, audio, photographs, graphics, comments, suggestions, or personal information or other material (collectively,&nbsp;&apos;Contributions&apos;). Contributions may be viewable by other users of the Licensed Application and through third-party websites or applications. As such, any Contributions you transmit may be treated as non-confidential and non-proprietary. When you create or make available any Contributions, you thereby represent and warrant that:</div>
//         <div><br></div>
//         <div>1. The creation, distribution, transmission, public display, or performance, and the accessing, downloading, or copying of your Contributions do not and will not infringe the proprietary rights, including but not limited to the copyright, patent, trademark, trade secret, or moral rights of any third party.</div>
//         <div>2. You are the creator and owner of or have the necessary&nbsp;licences, rights, consents, releases, and permissions to use and to&nbsp;authorise&nbsp;us, the Licensed Application, and other users of the Licensed Application to use your Contributions in any manner contemplated by the Licensed Application and this&nbsp;Licence&nbsp;Agreement.</div>
//         <div>3. You have the written consent, release, and/or permission of each and every identifiable individual person in your Contributions to use the name or likeness or each and every such identifiable individual person to enable inclusion and use of your Contributions in any manner contemplated by the Licensed Application and this&nbsp;Licence&nbsp;Agreement.</div>
//         <div>4. Your Contributions are not false, inaccurate, or misleading.</div>
//         <div>5. Your Contributions are not unsolicited or&nbsp;unauthorised&nbsp;advertising, promotional materials, pyramid schemes, chain letters, spam, mass mailings, or other forms of solicitation.</div>
//         <div>6. Your Contributions are not obscene, lewd, lascivious, filthy, violent, harassing,&nbsp;libellous, slanderous, or otherwise objectionable (as determined by us).</div>
//         <div>7. Your Contributions do not ridicule, mock, disparage, intimidate, or abuse anyone.</div>
//         <div>8. Your Contributions are not used to harass or threaten (in the legal sense of those terms) any other person and to promote violence against a specific person or class of people.</div>
//         <div>9. Your Contributions do not violate any applicable law, regulation, or rule.</div>
//         <div>10. Your Contributions do not violate the privacy or publicity rights of any third party.</div>
//         <div>11. Your Contributions do not violate any applicable law concerning child pornography, or otherwise intended to protect the health or well-being of minors.</div>
//         <div>12. Your Contributions do not include any offensive comments that are connected to race, national origin, gender, sexual preference, or physical handicap.</div>
//         <div>13. Your Contributions do not otherwise violate, or link to material that violates, any provision of this&nbsp;Licence&nbsp;Agreement, or any applicable law or regulation.</div>
//         <div><br></div>
//         <div>Any use of the Licensed Application in violation of the foregoing violates this&nbsp;Licence&nbsp;Agreement and may result in, among other things, termination or suspension of your rights to use the Licensed Application.</div>
//         <div><br></div>
//         <div><br></div>
//         <div id="contribution"><strong><strong><strong><strong>7. CONTRIBUTION&nbsp;LICENCE</strong></strong></strong></strong></div>
//         <div><br></div>
//         <div>By posting your Contributions to any part of the Licensed Application or making Contributions accessible to the Licensed Application by linking your account from the Licensed Application to any of your social networking accounts, you automatically grant, and you represent and warrant that you have the right to grant, to us an unrestricted, unlimited, irrevocable, perpetual, non-exclusive, transferable, royalty-free, fully-paid, worldwide right, and&nbsp;licence&nbsp;to host, use copy, reproduce, disclose, sell, resell, publish, broad cast, retitle, archive, store, cache, publicly display, reformat, translate, transmit, excerpt (in whole or in part), and distribute such Contributions (including, without limitation, your image and voice) for any purpose, commercial advertising, or otherwise, and to prepare derivative works of, or incorporate in other works, such as Contributions, and grant and&nbsp;authorise sublicences&nbsp;of the foregoing. The use and distribution may occur in any media formats and through any media channels.</div>
//         <div><br></div>
//         <div>This&nbsp;licence&nbsp;will apply to any form, media, or technology now known or hereafter developed, and includes our use of your name, company name, and franchise name, as applicable, and any of the trademarks, service marks, trade names, logos, and personal and commercial images you provide. You waive all moral rights in your Contributions, and you warrant that moral rights have not otherwise been asserted in your Contributions.</div>
//         <div><br></div>
//         <div>We do not assert any ownership over your Contributions. You retain full ownership of all of your Contributions and any intellectual property rights or other proprietary rights associated with your Contributions. We are not liable for any statements or representations in your Contributions provided by you in any area in the Licensed Application. You are solely responsible for your Contributions to the Licensed Application and you expressly agree to exonerate us from any and all responsibility and to refrain from any legal action against us regarding your Contributions.</div>
//         <div><br></div>
//         <div>We have the right, in our sole and absolute discretion, (1) to edit, redact, or otherwise change any Contributions; (2) to&nbsp;recategorise&nbsp;any Contributions to place them in more appropriate locations in the Licensed Application; and (3) to prescreen or delete any Contributions at any time and for any reason, without notice. We have no obligation to monitor your Contributions.</div>
//         <div><br></div>
//         <div><br></div>
//         <div id="liability"><strong><strong><strong><strong>8. LIABILITY</strong></strong></strong></strong></div>
//         <div><br></div>
//         <div>8.1 &nbsp;Licensor takes no accountability or responsibility for any damages caused due to a breach of duties according to Section 2 of this&nbsp;Licence&nbsp;Agreement. To avoid data loss, You are required to make use of backup functions of the Licensed Application to the extent allowed by applicable third-party terms and conditions of use. You are aware that in case of alterations or manipulations of the Licensed Application, You will not have access to the Licensed Application.</div>
//         <div><br></div>
//         <div><br></div>
//         <div id="warranty"><strong><strong><strong><strong>9. WARRANTY</strong></strong></strong></strong></div>
//     </div>
// </div>
// <div><br></div>
// <div>9.1 &nbsp;Licensor warrants that the Licensed Application is free of spyware, trojan horses, viruses, or any other malware at the time of Your download. Licensor warrants that the Licensed Application works as described in the user documentation.</div>
// <div><br></div>
// <div>9.2 &nbsp;No warranty is provided for the Licensed Application that is not executable on the device, that has been&nbsp;unauthorisedly&nbsp;modified, handled inappropriately or culpably, combined or installed with inappropriate hardware or software, used with inappropriate accessories, regardless if by Yourself or by third parties, or if there are any other reasons outside of&nbsp;Boloodo&apos;s sphere of influence that affect the executability of the Licensed Application.</div>
// <div><br></div>
// <div>9.3 &nbsp;You are required to inspect the Licensed Application immediately after installing it and notify&nbsp;Boloodo&nbsp;about issues discovered without delay by email provided in&nbsp;<a href="https://app.termly.io/document/eula/94b731e1-de93-46a6-959d-415d991a0404#contact">Contact Information</a>. The defect report will be taken into consideration and further investigated if it has been emailed within a period of&nbsp;seven (7)&nbsp;days after discovery.</div>
// <div><br></div>
// <div>9.4 &nbsp;If we confirm that the Licensed Application is defective,&nbsp;Boloodo&nbsp;reserves a choice to remedy the situation either by means of solving the defect or substitute delivery.</div>
// <div><br></div>
// <div>
//     <div>9.5&nbsp;&nbsp;In the event of any failure of the Licensed Application to conform to any applicable warranty, You may notify the Services Store Operator, and Your Licensed Application purchase price will be refunded to You. To the maximum extent permitted by applicable law, the Services Store Operator will have no other warranty obligation whatsoever with respect to the Licensed Application, and any other losses, claims, damages, liabilities, expenses, and costs attributable to any negligence to adhere to any warranty.</div>
// </div>
// <div><br></div>
// <div>
//     <div>9.6&nbsp;&nbsp;If the user is an entrepreneur, any claim based on faults expires after a statutory period of limitation amounting to twelve (12) months after the Licensed Application was made available to the user. The statutory periods of limitation given by law apply for users who are consumers.</div>
// </div>
// <div>&nbsp; &nbsp;</div>
// <div><br></div>
// <div>
//     <div id="productclaims"><strong><span id="productclaims"><strong><strong><strong><strong><strong><strong><strong>10. PRODUCT CLAIMS</strong></strong></strong></strong></strong></strong></strong></span></strong></div>
// </div>
// <div><br></div>
// <div>
//     <div>Boloodo&nbsp;and the End-User acknowledge that&nbsp;Boloodo, and not the Services, is responsible for addressing any claims of the End-User or any third party relating to the Licensed Application or the End-User&rsquo;s possession and/or use of that Licensed Application, including, but not limited to:</div>
// </div>
// <div><br></div>
// <div>
//     <div>(i) product liability claims;</div>&nbsp; &nbsp;
// </div>
// <div>
//     <div>(ii) any claim that the Licensed Application fails to conform to any applicable legal or regulatory requirement; and</div>
// </div>
// <div><br></div>
// <div>
//     <div>(iii) claims arising under consumer protection, privacy, or similar legislation, including in connection with Your Licensed Application&rsquo;s use of the HealthKit and HomeKit.</div>
// </div>
// <div><br></div>
// <div><br></div>
// <div>
//     <div id="compliance"><strong><strong><strong><strong><strong><strong><strong><strong><strong>11. LEGAL COMPLIANCE</strong></strong></strong></strong></strong></strong></strong></strong></strong></div>
// </div>
// <div><br></div>
// <div>
//     <div>You represent and warrant that You are not located in a country that is subject to a US Government embargo, or that has been designated by the US Government as a&nbsp;&apos;terrorist supporting&apos;&nbsp;country; and that You are not listed on any US Government list of prohibited or restricted parties.</div>
// </div>
// <div><br></div>
// <div><br></div>
// <div>
//     <div id="contact"><strong><strong><strong><strong><strong><strong><strong><strong><strong><strong>12. CONTACT INFORMATION</strong></strong></strong></strong></strong></strong></strong></strong></strong></strong></div>
// </div>
// <div><br></div>
// <div>
//     <div>For general inquiries, complaints, questions or claims concerning the Licensed Application, please contact:</div>&nbsp; &nbsp; &nbsp; &nbsp;<div>Boloodo</div>
//     <div>unit 4 The Courtyard</div>
//     <div>Norfolk Street</div>
//     <div>Peterbortough,&nbsp;Cambridgeshire&nbsp;PE1 2NP</div>
//     <div>England</div>
// </div>
// <div>
//     <div>info@boloodo.com</div>
// </div>
// <div><br></div>
// <div><br></div>
// <div>
//     <div id="termination"><strong><strong><strong><strong><strong><strong><strong><strong><strong><strong><strong>13. TERMINATION</strong></strong></strong></strong></strong></strong></strong></strong></strong></strong></strong></div>
// </div>
// <div><br></div>
// <div>
//     <div>The&nbsp;licence&nbsp;is valid until terminated by&nbsp;Boloodo&nbsp;or by You. Your rights under this&nbsp;licence&nbsp;will terminate automatically and without notice from&nbsp;Boloodo&nbsp;if You fail to adhere to any term(s) of this&nbsp;licence. Upon&nbsp;Licence&nbsp;termination, You shall stop all use of the Licensed Application, and destroy all copies, full or partial, of the Licensed Application.</div>
// </div>
// <div>&nbsp;&nbsp; &nbsp; &nbsp;<div><br></div>
// </div>
// <div>
//     <div id="thirdparty"><strong><strong><strong><strong><strong><strong><strong><strong><strong><strong><strong><strong>14. THIRD-PARTY TERMS OF AGREEMENTS AND BENEFICIARY</strong></strong></strong></strong></strong></strong></strong></strong></strong></strong></strong></strong></div>
// </div>
// <div><br></div>
// <div>
//     <div>Boloodo&nbsp;represents and warrants that&nbsp;Boloodo&nbsp;will comply with applicable third-party terms of agreement when using Licensed Application.</div>
// </div>
// <div><br></div>
// <div>
//     <div>In Accordance with Section 9 of the&nbsp;&apos;Instructions for Minimum Terms of Developer&apos;s End-User Licence Agreement&apos;,&nbsp;both Apple and Google and their&nbsp;subsidiaries shall be third-party beneficiaries of this End User&nbsp;Licence&nbsp;Agreement and &mdash; upon Your acceptance of the terms and conditions of this&nbsp;Licence&nbsp;Agreement,&nbsp;both Apple and Google&nbsp;will have the right (and will be deemed to have accepted the right) to enforce this End User&nbsp;Licence&nbsp;Agreement against You as a third-party beneficiary thereof.</div>
// </div>
// <div><br></div>
// <div>
//     <div><br></div>
//     <div id="ipr"><strong><strong><strong><strong><strong><strong><strong><strong><strong><strong><strong><strong><strong>15. INTELLECTUAL PROPERTY RIGHTS</strong></strong></strong></strong></strong></strong></strong></strong></strong></strong></strong></strong></strong></div>
// </div>
// <div><br></div>
// <div>
//     <div>Boloodo&nbsp;and the End-User acknowledge that, in the event of any third-party claim that the Licensed Application or the End-User&apos;s possession and use of that Licensed Application infringes on the third party&apos;s intellectual property rights,&nbsp;Boloodo, and not the Services, will be solely responsible for the investigation,&nbsp;defence, settlement, and discharge or any such intellectual property infringement claims.</div>
// </div>
// <div><br></div>
// <div>
//     <div><br></div>
//     <div id="law"><strong><strong><strong><strong><strong><strong><strong><strong><strong><strong><strong><strong><strong><strong>16. APPLICABLE LAW</strong></strong></strong></strong></strong></strong></strong></strong></strong></strong></strong></strong></strong></strong></div>
// </div>
// <div><br></div>
// <div>
//     <div>This&nbsp;Licence&nbsp;Agreement is governed by the laws of&nbsp;England and Wales, English law,&nbsp;excluding its conflicts of law rules.</div>
// </div>
// <div><br></div>
// <div>
//     <div><br></div>
//     <div id="misc"><strong><strong><strong><strong><strong><strong><strong><strong><strong><strong><strong><strong><strong><strong><strong>17. MISCELLANEOUS</strong></strong></strong></strong></strong></strong></strong></strong></strong></strong></strong></strong></strong></strong></strong></div>
//     <div><br></div>
//     <div>
//         <div>17.1&nbsp;&nbsp;If any of the terms of this agreement should be or become invalid, the validity of the remaining provisions shall not be affected. Invalid terms will be replaced by valid ones formulated in a way that will achieve the primary purpose.</div>&nbsp; &nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp;<div>17.2 &nbsp;Collateral agreements, changes and amendments are only valid if laid down in writing. The preceding clause can only be waived in writing.</div>
//     </div>
// </div>
//                 """,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
