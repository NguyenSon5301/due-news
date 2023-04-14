import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:cloudinary_public/cloudinary_public.dart';

import '../../common/common.dart';
import '../../models/firebaseuser.dart';
import '../../services/auth_services.dart';
import '../authentification/login/login_page.dart';
import '../main_tab_bar/main_tab_bar.dart';
import '../utils/utils.dart';

class SamplePage extends StatefulWidget {
  SamplePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _SamplePageState createState() => _SamplePageState();
}

class _SamplePageState extends State<SamplePage> {
  AuthService auth = AuthService();
  CloudinaryPublic cloudinary =
      CloudinaryPublic('dbprtaixx', '513497649735255', cache: true);
  final _email = TextEditingController();
  final _email1 = TextEditingController();
  final _email2 = TextEditingController();
  final _email3 = TextEditingController();
  final _email4 = TextEditingController();
  final _email5 = TextEditingController();
  final _email6 = TextEditingController();
  final _email7 = TextEditingController();
  final _email8 = TextEditingController();
  final _email9 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser?>(context);
    final userAuth = FirebaseAuth.instance.currentUser;

    return Background(
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.title,
                  style: SafeGoogleFont(
                    'Mulish',
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    height: 1.2575,
                    letterSpacing: 1,
                    color: Color(0xff1e2022),
                  ),
                ),
                if (widget.title.contains('Trang thông tin')) ...[
                  if (user != null) ...[
                    if (userAuth != null)
                      //   TextFormField(
                      //     controller: _email,
                      //     autofocus: false,
                      //     decoration: InputDecoration(
                      //       contentPadding:
                      //           const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      //       hintText: "iDSubject",
                      //       hintStyle: const TextStyle(color: AppColors.black),
                      //       border: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(32.0),
                      //       ),
                      //     ),
                      //   ),
                      // TextFormField(
                      //   controller: _email1,
                      //   autofocus: false,
                      //   decoration: InputDecoration(
                      //     contentPadding:
                      //         const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      //     hintText: "nameSubject",
                      //     hintStyle: const TextStyle(color: AppColors.black),
                      //     border: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(32.0),
                      //     ),
                      //   ),
                      // ),
                      // TextFormField(
                      //   controller: _email2,
                      //   autofocus: false,
                      //   decoration: InputDecoration(
                      //     contentPadding:
                      //         const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      //     hintText: "credit",
                      //     hintStyle: const TextStyle(color: AppColors.black),
                      //     border: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(32.0),
                      //     ),
                      //   ),
                      // ),
                      // TextFormField(
                      //   controller: _email3,
                      //   autofocus: false,
                      //   decoration: InputDecoration(
                      //     contentPadding:
                      //         const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      //     hintText: "score1",
                      //     hintStyle: const TextStyle(color: AppColors.black),
                      //     border: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(32.0),
                      //     ),
                      //   ),
                      // ),
                      // TextFormField(
                      //   controller: _email4,
                      //   autofocus: false,
                      //   decoration: InputDecoration(
                      //     contentPadding:
                      //         const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      //     hintText: "score2",
                      //     hintStyle: const TextStyle(color: AppColors.black),
                      //     border: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(32.0),
                      //     ),
                      //   ),
                      // ),
                      // TextFormField(
                      //   controller: _email5,
                      //   autofocus: false,
                      //   decoration: InputDecoration(
                      //     contentPadding:
                      //         const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      //     hintText: "score3",
                      //     hintStyle: const TextStyle(color: AppColors.black),
                      //     border: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(32.0),
                      //     ),
                      //   ),
                      // ),
                      // TextFormField(
                      //   controller: _email6,
                      //   autofocus: false,
                      //   decoration: InputDecoration(
                      //     contentPadding:
                      //         const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      //     hintText: "note",
                      //     hintStyle: const TextStyle(color: AppColors.black),
                      //     border: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(32.0),
                      //     ),
                      //   ),
                      // ),
                      // TextFormField(
                      //   controller: _email7,
                      //   autofocus: false,
                      //   decoration: InputDecoration(
                      //     contentPadding:
                      //         const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      //     hintText: "semester",
                      //     hintStyle: const TextStyle(color: AppColors.black),
                      //     border: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(32.0),
                      //     ),
                      //   ),
                      // ),
                      // TextFormField(
                      //   controller: _email8,
                      //   autofocus: false,
                      //   decoration: InputDecoration(
                      //     contentPadding:
                      //         const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      //     hintText: "Email",
                      //     hintStyle: const TextStyle(color: AppColors.black),
                      //     border: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(32.0),
                      //     ),
                      //   ),
                      // ),
                      // // CircleAvatar(
                      // //   radius: 50,
                      // //   backgroundColor: AppColors.lightGray,
                      // //   backgroundImage: userAuth.photoURL != null
                      // //       ? NetworkImage(
                      // //           userAuth.photoURL!,
                      // //         ) as ImageProvider
                      // //       : null,
                      // //   child: Stack(
                      // //     children: [
                      // //       Align(
                      // //         alignment: Alignment.center,
                      // //         child: CircleAvatar(
                      // //           radius: 25,
                      // //           backgroundColor: AppColors.transparent,
                      // //           child: InkWell(
                      // //             onTap: () async {
                      // //               // final cameraStatus =
                      // //               //     await _getCameraPermission();
                      // //               // if (!mounted) {
                      // //               //   return;
                      // //               // }
                      // //               // if (cameraStatus) {
                      // //               //   final checkTakePhoto = await takePhoto();
                      // //               //   if (checkTakePhoto != null) {
                      // //               //     final checkCropImage =
                      // //               //         await cropImage(checkTakePhoto);
                      // //               //     if (checkCropImage != null) {
                      // //               //       print(checkCropImage.path);
                      // //               //       // final converImageUrl =
                      // //               //       //     await cloudinary.uploadFile(
                      // //               //       //   CloudinaryFile.fromFile(
                      // //               //       //     checkCropImage.path,
                      // //               //       //     resourceType:
                      // //               //       //         CloudinaryResourceType.Image,
                      // //               //       //   ),
                      // //               //       // );
                      // //               //       // await userAuth.updatePhotoURL(
                      // //               //       //   converImageUrl.secureUrl,
                      // //               //       // );
                      // //               //     }
                      // //               //   }
                      // //               // }
                      // //             },
                      // //             child: Container(
                      // //               constraints: BoxConstraints.tight(
                      // //                 Size(50, 45),
                      // //               ),
                      // //               color: AppColors.transparent,
                      // //               child: const Icon(Icons.abc_outlined),
                      // //             ),
                      // //           ),
                      // //         ),
                      // //       )
                      // //     ],
                      // //   ),
                      // // ),
                      // TextButton(
                      //   onPressed: () async {
                      //     DocumentReference documentReference =
                      //         FirebaseFirestore.instance.collection('User').doc(
                      //               FirebaseAuth.instance.currentUser!.email
                      //                   .toString(),
                      //             );
                      //     // .collection('Subjects')
                      //     // .doc(_email.text);
                      //     List<String> newsList = ['16679', '16902'];
                      //     var add = <String, dynamic>{
                      //       // 'iDSubject': _email.text,
                      //       // 'nameSubject': _email1.text,
                      //       // 'credit': _email2.text,
                      //       // 'score1': _email3.text,
                      //       // 'score2': _email4.text,
                      //       // 'score3': _email5.text,
                      //       // 'note': _email6.text,
                      //       // 'semester': _email7.text,
                      //       'newsList': newsList,
                      //     };
                      //     await documentReference.set(add).then((value) {
                      //       ScaffoldMessenger.of(context).showSnackBar(
                      //         SnackBar(
                      //           content:
                      //               Text('${widget.title} is added to cart'),
                      //         ),
                      //       );
                      //       _email1.clear();
                      //       _email2.clear();
                      //       _email3.clear();
                      //       _email4.clear();
                      //       _email5.clear();
                      //       _email6.clear();
                      //     });
                      //     // await userAuth.updateDisplayName('Nguyen Hong Son');
                      //   },
                      //   child: const Text('Update Name'),
                      // ),
                      // if (userAuth != null) Text(userAuth.displayName.toString()),
                      // if (userAuth != null)
                      //   for (final providerProfile in userAuth.providerData) ...[
                      //     // ID of the provider (google.com, apple.cpm, etc.)
                      //     Text(providerProfile.providerId),

                      //     // UID specific to the provider

                      //     // Name, email address, and profile photo URL
                      //     Text(providerProfile.displayName.toString())
                      //   ],
                      // // TextButton(onPressed: ({

                      // // }), child: child),
                      CustomButton(
                        onPressed: () {
                          auth.signOut();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MainTabBar(),
                            ),
                          );
                        },
                        buttonLabel: 'Đăng xuất',
                        color: AppColors.red,
                      )
                  ] else
                    CustomButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Login(),
                          ),
                        );
                      },
                      buttonLabel: 'Đăng nhập',
                      color: AppColors.red,
                    )
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _getCameraPermission() async {
    final status = await Permission.camera.request();
    if (status == PermissionStatus.permanentlyDenied) {
      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(status.name),
          );
        },
      );
    }
    if (status == PermissionStatus.denied) {
      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(status.name),
          );
        },
      );
    }

    return status == PermissionStatus.granted;
  }

  Future<File?> takePhoto() async {
    try {
      final file = await ImagePicker().pickImage(source: ImageSource.camera);
      if (file != null) {
        return File(file.path);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<File?> cropImage(File input) async {
    try {
      if (input.path != null) {
        final file = await ImageCropper().cropImage(
          sourcePath: input.path,
          aspectRatioPresets: const [CropAspectRatioPreset.square],
          uiSettings: [
            AndroidUiSettings(
              toolbarTitle: 'Crop image',
              initAspectRatio: CropAspectRatioPreset.square,
              hideBottomControls: true,
            ),
            // IOSUiSettings(
            //   title: 'Crop image',
            // ),
          ],
        );
        if (file != null) {
          return File(file.path);
        }
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }
}
// import 'dart:io';
// import 'package:intl/intl.dart';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:cloudinary_public/cloudinary_public.dart';
// import 'package:flutter/material.dart';

// import '../../common/common.dart';
// import '../../models/firebaseuser.dart';
// import '../../services/auth_services.dart';
// import '../authentification/login/login_page.dart';
// import '../main_tab_bar/main_tab_bar.dart';
// import '../utils/utils.dart';

// class SamplePage extends StatefulWidget {
//   SamplePage({Key? key, required this.title}) : super(key: key);

//   final String title;

//   @override
//   _SamplePageState createState() => _SamplePageState();
// }

// class _SamplePageState extends State<SamplePage> {
//   AuthService auth = AuthService();
//   CloudinaryPublic cloudinary =
//       CloudinaryPublic('dbprtaixx', '513497649735255', cache: true);
//   final _email = TextEditingController();
//   final _email1 = TextEditingController();
//   final _email2 = TextEditingController();
//   final _email3 = TextEditingController();
//   final _email4 = TextEditingController();
//   final _email5 = TextEditingController();
//   final _email6 = TextEditingController();
//   final _email7 = TextEditingController();
//   final _email8 = TextEditingController();
//   final _email9 = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     final user = Provider.of<FirebaseUser?>(context);
//     final userAuth = FirebaseAuth.instance.currentUser;

//     return Background(
//       child: Scaffold(
//         backgroundColor: AppColors.transparent,
//         body: Center(
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Text(
//                   widget.title,
//                   style: SafeGoogleFont(
//                     'Mulish',
//                     fontSize: 17,
//                     fontWeight: FontWeight.w600,
//                     height: 1.2575,
//                     letterSpacing: 1,
//                     color: Color(0xff1e2022),
//                   ),
//                 ),
//                 if (widget.title.contains('Trang thông tin')) ...[
//                   if (user != null) ...[
//                     if (userAuth != null)
//                       TextFormField(
//                         controller: _email,
//                         autofocus: false,
//                         decoration: InputDecoration(
//                           contentPadding:
//                               const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//                           hintText: "iDSubject",
//                           hintStyle: const TextStyle(color: AppColors.black),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(32.0),
//                           ),
//                         ),
//                       ),
//                     TextFormField(
//                       controller: _email1,
//                       autofocus: false,
//                       decoration: InputDecoration(
//                         contentPadding:
//                             const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//                         hintText: "nameSubject",
//                         hintStyle: const TextStyle(color: AppColors.black),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(32.0),
//                         ),
//                       ),
//                     ),
//                     TextFormField(
//                       controller: _email2,
//                       autofocus: false,
//                       decoration: InputDecoration(
//                         contentPadding:
//                             const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//                         hintText: "credit",
//                         hintStyle: const TextStyle(color: AppColors.black),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(32.0),
//                         ),
//                       ),
//                     ),
//                     TextFormField(
//                       controller: _email3,
//                       autofocus: false,
//                       decoration: InputDecoration(
//                         contentPadding:
//                             const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//                         hintText: "score1",
//                         hintStyle: const TextStyle(color: AppColors.black),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(32.0),
//                         ),
//                       ),
//                     ),
//                     TextFormField(
//                       controller: _email4,
//                       autofocus: false,
//                       decoration: InputDecoration(
//                         contentPadding:
//                             const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//                         hintText: "score2",
//                         hintStyle: const TextStyle(color: AppColors.black),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(32.0),
//                         ),
//                       ),
//                     ),
//                     TextFormField(
//                       controller: _email5,
//                       autofocus: false,
//                       decoration: InputDecoration(
//                         contentPadding:
//                             const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//                         hintText: "score3",
//                         hintStyle: const TextStyle(color: AppColors.black),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(32.0),
//                         ),
//                       ),
//                     ),
//                     TextFormField(
//                       controller: _email6,
//                       autofocus: false,
//                       decoration: InputDecoration(
//                         contentPadding:
//                             const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//                         hintText: "note",
//                         hintStyle: const TextStyle(color: AppColors.black),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(32.0),
//                         ),
//                       ),
//                     ),
//                     TextFormField(
//                       controller: _email7,
//                       autofocus: false,
//                       decoration: InputDecoration(
//                         contentPadding:
//                             const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//                         hintText: "semester",
//                         hintStyle: const TextStyle(color: AppColors.black),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(32.0),
//                         ),
//                       ),
//                     ),
//                     TextFormField(
//                       controller: _email8,
//                       autofocus: false,
//                       decoration: InputDecoration(
//                         contentPadding:
//                             const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//                         hintText: "Email",
//                         hintStyle: const TextStyle(color: AppColors.black),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(32.0),
//                         ),
//                       ),
//                     ),
//                     // CircleAvatar(
//                     //   radius: 50,
//                     //   backgroundColor: AppColors.lightGray,
//                     //   backgroundImage: userAuth.photoURL != null
//                     //       ? NetworkImage(
//                     //           userAuth.photoURL!,
//                     //         ) as ImageProvider
//                     //       : null,
//                     //   child: Stack(
//                     //     children: [
//                     //       Align(
//                     //         alignment: Alignment.center,
//                     //         child: CircleAvatar(
//                     //           radius: 25,
//                     //           backgroundColor: AppColors.transparent,
//                     //           child: InkWell(
//                     //             onTap: () async {
//                     //               // final cameraStatus =
//                     //               //     await _getCameraPermission();
//                     //               // if (!mounted) {
//                     //               //   return;
//                     //               // }
//                     //               // if (cameraStatus) {
//                     //               //   final checkTakePhoto = await takePhoto();
//                     //               //   if (checkTakePhoto != null) {
//                     //               //     final checkCropImage =
//                     //               //         await cropImage(checkTakePhoto);
//                     //               //     if (checkCropImage != null) {
//                     //               //       print(checkCropImage.path);
//                     //               //       // final converImageUrl =
//                     //               //       //     await cloudinary.uploadFile(
//                     //               //       //   CloudinaryFile.fromFile(
//                     //               //       //     checkCropImage.path,
//                     //               //       //     resourceType:
//                     //               //       //         CloudinaryResourceType.Image,
//                     //               //       //   ),
//                     //               //       // );
//                     //               //       // await userAuth.updatePhotoURL(
//                     //               //       //   converImageUrl.secureUrl,
//                     //               //       // );
//                     //               //     }
//                     //               //   }
//                     //               // }
//                     //             },
//                     //             child: Container(
//                     //               constraints: BoxConstraints.tight(
//                     //                 Size(50, 45),
//                     //               ),
//                     //               color: AppColors.transparent,
//                     //               child: const Icon(Icons.abc_outlined),
//                     //             ),
//                     //           ),
//                     //         ),
//                     //       )
//                     //     ],
//                     //   ),
//                     // ),
//                     TextButton(
//                       onPressed: () async {
//                         final documentReference =
//                             FirebaseFirestore.instance.collection('User').doc(
//                                   FirebaseAuth.instance.currentUser!.email
//                                       .toString(),
//                                 );
//                         List<String> newsList = [
//                           '16679',
//                           '16902',
//                           '16934',
//                           '16932'
//                         ];
//                         var index = -1;
//                         var news = '16932';
//                         for (int i = 0; i < newsList.length; i++) {
//                           if (newsList[i] == news) {
//                             index = i;
//                           }
//                         }
//                         if (index > -1) {
//                           newsList.removeAt(index);
//                         } else {
//                           newsList.add(news);
//                         }
//                         final add = <String, dynamic>{
//                           // 'name': _email.text,
//                           // // 'birthDate': _email1.text,
//                           // 'class': _email2.text,
//                           // 'level': _email3.text,
//                           // 'field': _email4.text,
//                           // 'major': _email5.text,
//                           'newsCollection': newsList,
//                           // 'note': _email6.text,
//                           // 'semester': _email7.text,
//                         };
//                         await documentReference.update(add).then((value) {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(
//                               content: Text('${widget.title} is added to cart'),
//                             ),
//                           );
//                           _email1.clear();
//                           _email2.clear();
//                           _email3.clear();
//                           _email4.clear();
//                           _email5.clear();
//                           _email6.clear();
//                         });
//                         // await userAuth.updateDisplayName('Nguyen Hong Son');
//                       },
//                       child: const Text('Update Name'),
//                     ),
//                     if (userAuth != null) Text(userAuth.displayName.toString()),
//                     if (userAuth != null)
//                       for (final providerProfile in userAuth.providerData) ...[
//                         // ID of the provider (google.com, apple.cpm, etc.)
//                         Text(providerProfile.providerId),

//                         // UID specific to the provider

//                         // Name, email address, and profile photo URL
//                         Text(providerProfile.displayName.toString())
//                       ],
//                     // TextButton(onPressed: ({

//                     // }), child: child),
//                     CustomButton(
//                       onPressed: () {
//                         auth.signOut();
//                         Navigator.pushReplacement(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => const MainTabBar(),
//                           ),
//                         );
//                       },
//                       buttonLabel: 'Log out',
//                       color: AppColors.red,
//                     )
//                   ] else
//                     CustomButton(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => const Login(),
//                           ),
//                         );
//                       },
//                       buttonLabel: 'Log in',
//                       color: AppColors.red,
//                     )
//                 ]
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Future<bool> _getCameraPermission() async {
//     final status = await Permission.camera.request();
//     if (status == PermissionStatus.permanentlyDenied) {
//       await showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             content: Text(status.name),
//           );
//         },
//       );
//     }
//     if (status == PermissionStatus.denied) {
//       await showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             content: Text(status.name),
//           );
//         },
//       );
//     }

//     return status == PermissionStatus.granted;
//   }

//   Future<File?> takePhoto() async {
//     try {
//       final file = await ImagePicker().pickImage(source: ImageSource.camera);
//       if (file != null) {
//         return File(file.path);
//       }
//     } catch (e) {
//       rethrow;
//     }
//   }

//   Future<File?> cropImage(File input) async {
//     try {
//       if (input.path != null) {
//         final file = await ImageCropper().cropImage(
//           sourcePath: input.path,
//           aspectRatioPresets: const [CropAspectRatioPreset.square],
//           uiSettings: [
//             AndroidUiSettings(
//               toolbarTitle: 'Crop image',
//               initAspectRatio: CropAspectRatioPreset.square,
//               hideBottomControls: true,
//             ),
//             // IOSUiSettings(
//             //   title: 'Crop image',
//             // ),
//           ],
//         );
//         if (file != null) {
//           return File(file.path);
//         }
//       }
//       return null;
//     } catch (e) {
//       rethrow;
//     }
//   }
// }
