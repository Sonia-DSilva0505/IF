// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internship_fair/constants/constants.dart';
import 'package:internship_fair/controller/apply_job.dart';
import 'package:intl/intl.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:url_launcher/url_launcher.dart';

class JobDesc extends StatefulWidget {
  final String? jobPosition,
      companyName,
      minStipend,
      duration,
      workfromHome,
      about,
      logo,
      location,
      skills,
      link,
      deadline;
  final List<String> requirements;
  final int? v;
  final bool applied;

  final String jobid;
  const JobDesc(
      {Key? key,
      required this.jobid,
      required this.link,
      required this.jobPosition,
      required this.companyName,
      required this.minStipend,
      required this.duration,
      required this.workfromHome,
      required this.about,
      required this.location,
      required this.requirements,
      required this.deadline,
      required this.applied,
      this.v,
      this.logo,
      required this.skills})
      : super(key: key);

  @override
  State<JobDesc> createState() => _JobDescState();
}

class _JobDescState extends State<JobDesc> {
  bool abtcomp = false;
  bool jd = false;
  bool whocan = false;
  bool perks = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double sizefont = size.width * 0.04;

    void cartAdd() async {
      Loader.show(context,
          progressIndicator: CircularProgressIndicator(color: blackTeal));
      String status = '';
      try {
        status = await addCart(widget.jobid);
      } on Exception {
        Loader.hide();
      }
      Loader.hide();

      if (status == "Successfully applied for Job.") {
        MotionToast.success(
          toastDuration: const Duration(milliseconds: 2000),
          width: size.width * 0.7,
          height: 65,
          borderRadius: 10,
          padding: EdgeInsets.zero,
          title: Text(
            "Internship added",
            style: TextStyle(
                color: whiteColor, fontWeight: FontWeight.bold, fontSize: 16),
          ),
          description: Text(
            "Added successfully",
            style: TextStyle(
              color: Colors.white,
              fontSize: sizefont * 0.7,
            ),
          ),
        ).show(context);
      } else if (status == "Already applied for Job") {
        MotionToast(
          toastDuration: const Duration(milliseconds: 2000),
          primaryColor: darkgrey,
          width: size.width * 0.7,
          height: 65,
          borderRadius: 10,
          padding: EdgeInsets.zero,
          title: Text(
            "Already applied",
            style: TextStyle(
              fontFamily: "Poppins",
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: sizefont * 0.8,
            ),
          ),
          description: Text(
            "Apply for other options",
            style: TextStyle(
              fontFamily: "Poppins",
              color: Colors.black,
              fontSize: sizefont * 0.7,
            ),
          ),
        ).show(context);
      } else {
        MotionToast.error(
          toastDuration: const Duration(milliseconds: 2000),
          height: sizefont * 5,
          borderRadius: 10,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          title: Row(
            children: [
              Text(
                "Error in applying",
                style: TextStyle(
                  fontFamily: "Poppins",
                  color: whiteColor,
                  fontWeight: FontWeight.bold,
                  fontSize: sizefont * 0.9,
                ),
              ),
            ],
          ),
          description: Text(
            "Please check your internet connection and try again",
            style: TextStyle(
              fontFamily: "Poppins",
              color: whiteColor,
              fontSize: sizefont * 0.7,
            ),
          ),
        ).show(context);
      }
    }

    final jobDetails = SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: sizefont * 0.2),
                child: CircleAvatar(
                  radius: sizefont * 0.6,
                  backgroundColor: textgreen,
                  child: Icon(
                    Icons.location_on_sharp,
                    color: whiteColor,
                    size: sizefont,
                  ),
                ),
              ),
              SizedBox(width: sizefont * 0.5), // Use SizedBox for spacing
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'MODE',
                    style: TextStyle(
                      color: darkgrey,
                      fontFamily: "poppins",
                      fontSize: sizefont,
                    ),
                  ),
                  Text(
                    widget.workfromHome ?? "",
                    style: TextStyle(
                      color: blackColor,
                      fontFamily: "poppins",
                      fontSize: sizefont * 0.8,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: sizefont * 0.2),
                child: CircleAvatar(
                  radius: sizefont * 0.6,
                  backgroundColor: textgreen,
                  child: Icon(
                    Icons.currency_rupee_outlined,
                    color: whiteColor,
                    size: sizefont,
                  ),
                ),
              ),
              SizedBox(width: sizefont * 0.5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'STIPEND',
                    style: TextStyle(
                      color: darkgrey,
                      fontFamily: "poppins",
                      fontSize: sizefont,
                    ),
                  ),
                  Text(
                    widget.minStipend ?? "",
                    style: TextStyle(
                      color: blackColor,
                      fontFamily: "poppins",
                      fontSize: sizefont * 0.8,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: sizefont * 0.2),
                child: CircleAvatar(
                  radius: sizefont * 0.6,
                  backgroundColor: textgreen,
                  child: Icon(
                    Icons.timer,
                    color: whiteColor,
                    size: sizefont,
                  ),
                ),
              ),
              SizedBox(width: sizefont * 0.5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'DURATION',
                    style: TextStyle(
                      color: darkgrey,
                      fontFamily: "poppins",
                      fontSize: sizefont,
                    ),
                  ),
                  Text(
                    widget.duration ?? "",
                    style: TextStyle(
                      color: blackColor,
                      fontFamily: "poppins",
                      fontSize: sizefont * 0.8,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
    final aboutComp = ExpansionPanelList(
      expansionCallback: (panelIndex, isExpanded) {
        setState(() {
          abtcomp = !abtcomp;
        });
      },
      dividerColor: greyColor,
      animationDuration: const Duration(milliseconds: 500),
      children: [
        ExpansionPanel(
          backgroundColor: Colors.white,
          headerBuilder: (context, isExpanded) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: ListTile(
                tileColor: Colors.white,
                title: Text(
                  'About the Company',
                  style: TextStyle(
                    color: blackColor,
                    fontFamily: "poppins",
                    fontSize: sizefont,
                  ),
                ),
              ),
            );
          },
          body: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 8.0),
              child: Text(
                widget.about ?? "",
                style: TextStyle(
                  color: blackColor,
                  fontFamily: "poppins",
                  fontSize: sizefont * 0.8,
                ),
              ),
            ),
          ),
          isExpanded: abtcomp,
          canTapOnHeader: true,
        ),
      ],
    );

    final jD = ExpansionPanelList(
      expansionCallback: (panelIndex, isExpanded) {
        setState(() {
          jd = !jd;
        });
      },
      dividerColor: greyColor,
      animationDuration: const Duration(milliseconds: 500),
      children: [
        ExpansionPanel(
          backgroundColor: Colors.white,
          headerBuilder: (context, isExpanded) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: ListTile(
                title: Text(
                  'Job Description',
                  style: TextStyle(
                    color: blackColor,
                    fontFamily: "poppins",
                    fontSize: sizefont,
                  ),
                ),
              ),
            );
          },
          body: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 8.0),
              child: Text(
                widget.skills ?? "",
                style: TextStyle(
                  color: blackColor,
                  fontFamily: "poppins",
                  fontSize: sizefont * 0.8,
                ),
              ),
            ),
          ),
          isExpanded: jd,
          canTapOnHeader: true,
        ),
      ],
    );

    final whoCan = ExpansionPanelList(
      expansionCallback: (panelIndex, isExpanded) {
        setState(() {
          whocan = !whocan;
        });
      },
      dividerColor: greyColor,
      animationDuration: const Duration(milliseconds: 500),
      children: [
        ExpansionPanel(
          backgroundColor: Colors.white,
          headerBuilder: (context, isExpanded) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: ListTile(
                title: Text(
                  'Requirements',
                  style: TextStyle(
                    color: blackColor,
                    fontFamily: "poppins",
                    fontSize: sizefont,
                  ),
                ),
              ),
            );
          },
          body: Wrap(
            children: widget.requirements.map((e) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        left: 15, bottom: 8, top: sizefont * 0.4),
                    height: sizefont * 0.4,
                    width: sizefont * 0.4,
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 8, bottom: 8),
                      child: Text(
                        e,
                        style: TextStyle(
                          color: blackColor,
                          fontFamily: "poppins",
                          fontSize: sizefont * 0.8,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
          isExpanded: whocan,
          canTapOnHeader: true,
        ),
      ],
    );

    final applyButton = Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(5),
        color: blackTeal,
        child: Container(
          height: sizefont * 3,
          padding: EdgeInsets.symmetric(vertical: sizefont * 0.5),
          child: MaterialButton(
              onPressed: () {
                cartAdd();
              },
              child: SizedBox(
                width: size.width,
                child: Text(
                  "Apply",
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
      appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_outlined, color: blackColor),
            iconSize: sizefont * 1.5,
            onPressed: () => Navigator.pop(context),
          ),
          centerTitle: true,
          backgroundColor: whiteColor,
          title: Text(
            'Job Description',
            style: TextStyle(
                fontFamily: 'poppins',
                fontSize: sizefont * 1.5,
                color: blackColor),
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.symmetric(vertical: 27, horizontal: size.width * 0.06),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: size.width * 0.65,
                          child: Text(
                            widget.jobPosition ?? "",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: textgreen,
                              fontFamily: "poppins",
                              fontSize: sizefont * 1.35,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(height: 0.003 * size.height),
                        SizedBox(
                          width: size.width * 0.65,
                          child: Text(
                            widget.companyName ?? "",
                            style: TextStyle(
                              color: blackColor,
                              fontFamily: "poppins",
                              fontSize: sizefont * 1.2,
                            ),
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    SizedBox(
                      width: 0.2 * size.width,
                      child: Image.network(
                        widget.logo ?? "",
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(
                            child: Icon(Icons.error_outline, color: Colors.red),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 0.003 * size.height),
                Text(
                  widget.location ?? "",
                  style: TextStyle(
                    color: darkgrey,
                    fontFamily: "poppins",
                    fontSize: sizefont,
                  ),
                ),
                SizedBox(
                  height: size.width * 0.01,
                ),
                Row(
                  children: [
                    const Text(
                      'Deadline: ',
                      style: TextStyle(
                          fontFamily: 'poppins',
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Colors.grey),
                    ),
                    Text(
                      DateFormat('MMM d, yyyy h:mm a')
                          .format(DateTime.parse(widget.deadline ?? "")),
                      style: const TextStyle(
                          fontFamily: 'poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Colors.black),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.width * 0.01,
                ),
                if (widget.link != null)
                  GestureDetector(
                    onTap: () async {
                      final Uri website =
                          Uri.parse(widget.link ?? "https://www.google.com");
                      await launchUrl(website);
                    },
                    child: Text(
                      widget.link ?? "https://www.google.com",
                      style: TextStyle(
                          fontFamily: 'poppins',
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: textgreen),
                    ),
                  ),
                SizedBox(
                  height: size.width * 0.03,
                ),
                jobDetails,
                SizedBox(
                  height: size.width * 0.03,
                ),
                aboutComp,
                SizedBox(
                  height: size.width * 0.03,
                ),
                jD,
                SizedBox(
                  height: size.width * 0.03,
                ),
                whoCan,
                SizedBox(
                  height: size.width * 0.05,
                ),
                if ((DateFormat("yyyy-MM-ddTHH:mm:ss.SSSZ")
                            .parse(widget.deadline ?? ""))
                        .isAfter(DateTime.now()) &&
                    !widget.applied)
                  applyButton
                else if (!widget.applied)
                  SizedBox(
                    width: size.width * 0.9,
                    height: sizefont * 3,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: textgreen,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text(
                          "Applications Closed",
                          style: TextStyle(
                              fontFamily: 'poppins',
                              fontSize: sizefont,
                              color: whiteColor),
                        ),
                      ),
                    ),
                  )
                else
                  const SizedBox.shrink()
              ]),
        ),
      ),
    );
  }
}
