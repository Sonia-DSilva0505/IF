// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:internship_fair/controller/auth.dart';
import 'package:internship_fair/constants/constants.dart';
import 'package:file_picker/file_picker.dart';
import 'package:internship_fair/view/job_profile.dart';
import 'package:motion_toast/motion_toast.dart';
import 'dart:io';

class InfoPage extends StatefulWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController sapidController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController whatsappController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpasswordController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();
  AuthController authController = AuthController();

  bool _isHidden1 = true;
  bool _isHidden2 = true;

  List<String> genders = <String>['Male', 'Female', 'Prefer not to say'];
  String genderval = 'Male';
  List<String> years = <String>['FE', 'SE', 'TE'];
  String yearval = 'FE';
  List<String> grads = <String>['2027', '2025', '2026'];
  String gradval = '2027';
  List<String> depts = <String>[
    'CE',
    'IT',
    'CSE DS',
    'AI/ML',
    'AI/DS',
    'ICB',
    'EXTC',
    'MECH'
  ];
  String deptval = 'CE';
  String resume = "";
  PlatformFile? pickedfile;
  File? pdf;
  String? fileName;

  Future selectPDF() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        allowMultiple: false,
      );
      if (result != null) {
        pickedfile = result.files.first;
        resume = result.files.first.path!;
        File selectedFile = File(result.files.single.path!);

        setState(() {
          pdf = File(result.files.single.path!);
          var lastSeperator =
              selectedFile.path.lastIndexOf(Platform.pathSeparator);
          fileName = selectedFile.path.substring(lastSeperator + 1);
        });
      }
    } catch (e) {
      log(e.toString());
    }
  }

  void register(
      String name,
      String sap,
      String gender,
      String email,
      String whatsapp,
      String dept,
      String academicYear,
      String graduationYear,
      String password,
      String confirmPassword,
      File pdf,
      BuildContext context) async {
    if (formKey.currentState!.validate()) {
      Loader.show(context,
          progressIndicator: CircularProgressIndicator(color: blackTeal));
      String status = '';

      try {
        status = await authController.register(
            name,
            sap,
            gender,
            email,
            whatsapp,
            dept,
            academicYear,
            graduationYear,
            password,
            confirmPassword,
            pdf);
      } on Exception {
        Loader.hide();
      }
      Loader.hide();

      if (status == "Success") {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: ((context) => const JobProfile())));
      } else {
        MotionToast.error(
                toastDuration: const Duration(milliseconds: 2000),
                height: 65,
                borderRadius: 10,
                // width: 400,
                padding: EdgeInsets.zero,
                title: Text(
                  "Error",
                  style: TextStyle(
                      color: whiteColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                description: Text(status))
            .show(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double sizefont = size.width * 0.04;

    final nameField = Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        style: TextStyle(fontSize: sizefont),
        autofocus: false,
        controller: nameController,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please enter your Name");
          }
          if (!RegExp(r"[a-zA-Z+' ]").hasMatch(value)) {
            return ("Please Enter a valid Name");
          }
          return null;
        },
        onSaved: (value) {
          nameController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          suffixIcon: nameController.text.isEmpty
              ? Container(
                  width: 0,
                )
              : IconButton(
                  icon: Icon(
                    Icons.close,
                    size: sizefont,
                  ),
                  onPressed: () => nameController.clear(),
                ),
          contentPadding: EdgeInsets.symmetric(
              vertical: size.width * 0.01, horizontal: size.width * 0.03),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: greyColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: blackTeal, width: 2.0)),
          isDense: true,
        ),
      ),
    );

    final sapidField = Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        keyboardType: TextInputType.number,
        style: TextStyle(fontSize: sizefont),
        autofocus: false,
        controller: sapidController,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please enter your SAPID");
          }
          if (!RegExp(r"^[0-9]{11}$").hasMatch(value)) {
            return ("Please Enter a valid SAPID");
          }
          return null;
        },
        onSaved: (value) {
          sapidController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          suffixIcon: sapidController.text.isEmpty
              ? Container(
                  width: 0,
                )
              : IconButton(
                  icon: Icon(
                    Icons.close,
                    size: sizefont,
                  ),
                  onPressed: () => sapidController.clear(),
                ),
          contentPadding: EdgeInsets.symmetric(
              vertical: size.width * 0.01, horizontal: size.width * 0.03),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: greyColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: blackTeal, width: 2.0)),
          isDense: true,
        ),
      ),
    );

    final emailField = Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        style: TextStyle(fontSize: sizefont),
        autofocus: false,
        controller: emailController,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please enter your Email ID");
          }
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9,-]+.[a-z]")
              .hasMatch(value)) {
            return ("Please Enter a valid Email");
          }
          return null;
        },
        onSaved: (value) {
          emailController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          suffixIcon: emailController.text.isEmpty
              ? Container(
                  width: 0,
                )
              : IconButton(
                  icon: Icon(
                    Icons.close,
                    size: sizefont,
                  ),
                  onPressed: () => emailController.clear(),
                ),
          contentPadding: EdgeInsets.symmetric(
              vertical: size.width * 0.005, horizontal: size.width * 0.03),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: greyColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: blackTeal, width: 2.0)),
          isDense: true,
        ),
      ),
    );

    final whatsappField = Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        keyboardType: TextInputType.phone,
        style: TextStyle(fontSize: sizefont),
        autofocus: false,
        controller: whatsappController,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please enter your WhatsApp Number");
          }
          if (!RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)').hasMatch(value)) {
            return ("Please Enter a valid WhatsApp Number");
          }
          return null;
        },
        onSaved: (value) {
          whatsappController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          suffixIcon: whatsappController.text.isEmpty
              ? Container(
                  width: 0,
                )
              : IconButton(
                  icon: Icon(
                    Icons.close,
                    size: sizefont,
                  ),
                  onPressed: () => whatsappController.clear(),
                ),
          contentPadding: EdgeInsets.symmetric(
              vertical: size.width * 0.01, horizontal: size.width * 0.03),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: greyColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: blackTeal, width: 2.0)),
          isDense: true,
        ),
      ),
    );

    final gender = Row(
      children: [
        Flexible(
          flex: 1,
          fit: FlexFit.loose,
          child: Text(
            'Gender',
            style: TextStyle(
                fontFamily: 'poppins', color: textgreen, fontSize: sizefont),
          ),
        ),
        SizedBox(
          width: 0.05 * size.width,
        ),
        Flexible(
          flex: 1,
          fit: FlexFit.loose,
          child: SizedBox(
            child: DropdownButton<String>(
              value: genderval,
              isExpanded: true,
              elevation: 16,
              icon: const Icon(Icons.arrow_drop_down),
              iconSize: 24,
              dropdownColor: whiteColor,
              style: TextStyle(
                  color: textgreen, fontFamily: 'poppins', fontSize: sizefont),
              underline: Container(
                height: 2,
                color: darkgrey,
              ),
              onChanged: (String? value) {
                setState(() {
                  genderval = value!;
                });
              },
              items: genders.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );

    final year = Row(
      children: [
        Flexible(
          flex: 1,
          fit: FlexFit.loose,
          child: Text(
            'Academic Year',
            style: TextStyle(
                fontFamily: 'poppins', color: textgreen, fontSize: sizefont),
          ),
        ),
        SizedBox(
          width: 0.05 * size.width,
        ),
        Flexible(
          flex: 1,
          fit: FlexFit.loose,
          child: DropdownButton<String>(
            value: yearval,
            elevation: 16,
            icon: const Icon(Icons.arrow_drop_down),
            iconSize: 24,
            dropdownColor: whiteColor,
            style: TextStyle(
                color: textgreen, fontFamily: 'poppins', fontSize: sizefont),
            underline: Container(
              height: 2,
              color: darkgrey,
            ),
            onChanged: (String? value) {
              setState(() {
                yearval = value!;
              });
            },
            items: years.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ],
    );

    final department = Row(
      children: [
        Flexible(
          flex: 1,
          fit: FlexFit.loose,
          child: Text(
            'Department',
            style: TextStyle(
                fontFamily: 'poppins', color: textgreen, fontSize: sizefont),
          ),
        ),
        SizedBox(
          width: 0.05 * size.width,
        ),
        Flexible(
          flex: 1,
          fit: FlexFit.loose,
          child: DropdownButton<String>(
            value: deptval,
            elevation: 16,
            icon: const Icon(Icons.arrow_drop_down),
            iconSize: 24,
            dropdownColor: whiteColor,
            style: TextStyle(
                color: textgreen, fontFamily: 'poppins', fontSize: sizefont),
            underline: Container(
              height: 2,
              color: darkgrey,
            ),
            onChanged: (String? value) {
              setState(() {
                deptval = value!;
              });
            },
            items: depts.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ],
    );

    final gradyear = Row(
      children: [
        Flexible(
          flex: 1,
          fit: FlexFit.loose,
          child: Text(
            'Graduation Year',
            style: TextStyle(
                fontFamily: 'poppins', color: textgreen, fontSize: sizefont),
          ),
        ),
        SizedBox(
          width: 0.05 * size.width,
        ),
        Flexible(
          flex: 1,
          fit: FlexFit.loose,
          child: DropdownButton<String>(
            value: gradval,
            elevation: 16,
            icon: const Icon(Icons.arrow_drop_down),
            iconSize: 24,
            dropdownColor: whiteColor,
            style: TextStyle(
                color: textgreen, fontFamily: 'poppins', fontSize: sizefont),
            underline: Container(
              height: 2,
              color: darkgrey,
            ),
            onChanged: (String? value) {
              setState(() {
                gradval = value!;
              });
            },
            items: grads.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ],
    );

    final uploadButton = Row(
      children: [
        Flexible(
          flex: 1,
          fit: FlexFit.loose,
          child: Text(
            'Resume',
            style: TextStyle(
                fontFamily: 'poppins', color: textgreen, fontSize: sizefont),
          ),
        ),
        SizedBox(
          width: 0.05 * size.width,
        ),
        fileName == null
            ? Flexible(
                flex: 1,
                fit: FlexFit.loose,
                child: SizedBox(
                  height: sizefont * 2.6,
                  width: size.width * 0.3,
                  child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(5),
                    color: whiteColor,
                    child: MaterialButton(
                      padding: EdgeInsets.symmetric(vertical: sizefont * 0.8),
                      onPressed: () {
                        selectPDF();
                      },
                      child: Text.rich(
                        TextSpan(
                          children: [
                            WidgetSpan(
                                child: Icon(
                              Icons.file_upload_outlined,
                              color: darkgrey,
                              size: sizefont * 0.9,
                            )),
                            WidgetSpan(
                                child: SizedBox(
                              width: size.width * 0.01,
                            )),
                            TextSpan(
                              text: "Add File",
                              style: TextStyle(
                                  fontFamily: 'poppins',
                                  fontSize: sizefont * 0.8,
                                  color: darkgrey),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : Text(
                fileName!,
                style: TextStyle(
                  color: blackTeal,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ],
    );

    final passwordField = Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        style: TextStyle(fontSize: sizefont),
        obscureText: _isHidden1,
        autofocus: false,
        controller: passwordController,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Enter your Password");
          }
          if (!RegExp(r'^.{8,}$').hasMatch(value)) {
            return ("Password must be at least 8 characters long");
          }
          if (!RegExp(r'[a-z]').hasMatch(value)) {
            return ("Password must contain at least one lowercase letter");
          }
          if (!RegExp(r'[A-Z]').hasMatch(value)) {
            return ("Password must contain at least one uppercase letter");
          }
          if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
            return ("Password must contain at least one symbol");
          }
          return null;
        },
        onSaved: (value) {
          passwordController.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              vertical: size.width * 0.01, horizontal: size.width * 0.03),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: greyColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: blackTeal, width: 2.0)),
          isDense: true,
          suffixIcon: InkWell(
            onTap: () {
              setState(() {
                _isHidden1 = !_isHidden1;
              });
            },
            child: FittedBox(
              alignment: Alignment.center,
              fit: BoxFit.fitHeight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  _isHidden1 ? Icons.visibility_off : Icons.visibility,
                ),
              ),
            ),
          ),
        ),
      ),
    );

    final confirmPasswordField = Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        style: TextStyle(fontSize: sizefont),
        obscureText: _isHidden2,
        autofocus: false,
        controller: confirmpasswordController,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Renter your Password");
          }
          if (!RegExp(r'^.{8,}$').hasMatch(value)) {
            return ("Password must be at least 8 characters long");
          }
          if (!RegExp(r'[a-z]').hasMatch(value)) {
            return ("Password must contain at least one lowercase letter");
          }
          if (!RegExp(r'[A-Z]').hasMatch(value)) {
            return ("Password must contain at least one uppercase letter");
          }
          if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
            return ("Password must contain at least one symbol");
          }
          return null;
        },
        onSaved: (value) {
          confirmpasswordController.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(10),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: greyColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: blackTeal, width: 2.0)),
          isDense: true,
          suffixIcon: InkWell(
            onTap: () {
              setState(() {
                _isHidden2 = !_isHidden2;
              });
            },
            child: FittedBox(
              alignment: Alignment.center,
              fit: BoxFit.fitHeight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  _isHidden2 ? Icons.visibility_off : Icons.visibility,
                ),
              ),
            ),
          ),
        ),
      ),
    );

    Widget submitButton = Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: blackTeal,
        ),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: sizefont * 0.7),
          child: InkWell(
              onTap: () {
                if (pdf == null) {
                  MotionToast.error(
                      toastDuration: const Duration(milliseconds: 2000),
                      height: 65,
                      borderRadius: 10,
                      // width: 400,
                      padding: EdgeInsets.zero,
                      title: Text(
                        "Error",
                        style: TextStyle(
                            color: whiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      description: Text(
                        "Enter all your details",
                        style: TextStyle(
                          color: whiteColor,
                        ),
                      )).show(context);
                } else {
                  register(
                      nameController.text,
                      sapidController.text,
                      genderval,
                      emailController.text,
                      whatsappController.text,
                      deptval,
                      yearval,
                      gradval,
                      passwordController.text,
                      confirmpasswordController.text,
                      pdf!,
                      context);
                }
              },
              child: SizedBox(
                width: size.width,
                child: Text(
                  "Register",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'poppins',
                      fontSize: sizefont,
                      color: whiteColor),
                ),
              )),
        ));

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.symmetric(vertical: 27, horizontal: size.width * 0.06),
          child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "SIGN UP",
                    style: TextStyle(
                      fontFamily: 'alumni',
                      color: blackTeal,
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text("Already have an Account? Login Here",
                        style: TextStyle(
                            fontFamily: 'poppins',
                            fontSize: sizefont,
                            decoration: TextDecoration.underline)),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text("Full Name",
                      style: TextStyle(
                          fontFamily: 'poppins',
                          fontSize: sizefont,
                          color: textgreen)),
                  nameField,
                  Text("SAPID",
                      style: TextStyle(
                          fontFamily: 'poppins',
                          fontSize: sizefont,
                          color: textgreen)),
                  sapidField,
                  Text("Email ID",
                      style: TextStyle(
                          fontFamily: 'poppins',
                          fontSize: sizefont,
                          color: textgreen)),
                  emailField,
                  Text("Password",
                      style: TextStyle(
                          fontFamily: 'poppins',
                          fontSize: sizefont,
                          color: textgreen)),
                  passwordField,
                  Text("Confirm Password",
                      style: TextStyle(
                          fontFamily: 'poppins',
                          fontSize: sizefont,
                          color: textgreen)),
                  confirmPasswordField,
                  Text("Phone Number (WhatsApp)",
                      style: TextStyle(
                          fontFamily: 'poppins',
                          fontSize: sizefont,
                          color: textgreen)),
                  whatsappField,
                  gender,
                  year,
                  department,
                  gradyear,
                  const SizedBox(
                    height: 12,
                  ),
                  uploadButton,
                  const SizedBox(
                    height: 30,
                  ),
                  submitButton,
                ],
              )),
        ),
      ),
    );
  }
}
