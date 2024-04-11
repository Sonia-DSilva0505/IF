import 'package:flutter/material.dart';
import 'package:internship_fair/constants/constants.dart';
import 'package:internship_fair/controller/apply_job.dart';
import 'package:intl/intl.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';

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
      deadline;
  final List<String> requirements;
  final int? v;

  final String jobid;
  const JobDesc(
      {Key? key,
      required this.jobid,
      required this.jobPosition,
      required this.companyName,
      required this.minStipend,
      required this.duration,
      required this.workfromHome,
      required this.about,
      required this.location,
      required this.requirements,
      required this.deadline,
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
          toastDuration: const Duration(milliseconds: 500),
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
          toastDuration: const Duration(milliseconds: 500),
          primaryColor: darkgrey,
          width: size.width * 0.7,
          height: 65,
          borderRadius: 10,
          padding: EdgeInsets.zero,
          title: Text(
            "Already applied for Job",
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
          toastDuration: const Duration(milliseconds: 500),
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

    final jobPosn = Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.jobPosition ?? "",
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: textgreen,
                  fontFamily: "poppins",
                  fontSize: sizefont * 1.5,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 0.003 * size.height,
            ),
            Text(
              widget.companyName ?? "",
              style: TextStyle(
                color: blackColor,
                fontFamily: "poppins",
                fontSize: sizefont * 1.2,
              ),
            ),
            SizedBox(
              height: 0.003 * size.height,
            ),
            Text(
              widget.location ?? "",
              style: TextStyle(
                color: darkgrey,
                fontFamily: "poppins",
                fontSize: sizefont,
              ),
            ),
          ],
        ),
        SizedBox(
          width: size.width * 0.2,
        ),
        Container(
          width: size.width * 0.1,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(widget.logo ?? ""),
              fit: BoxFit.cover,
            ),
          ),
        )
      ],
    );

    final jobDetails = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
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
            SizedBox(
              width: sizefont * 0.5,
            ),
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
                  widget.workfromHome!,
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
        SizedBox(
          width: size.width * 0.05,
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
            SizedBox(
              width: sizefont * 0.5,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'MIN STIPEND',
                  style: TextStyle(
                    color: darkgrey,
                    fontFamily: "poppins",
                    fontSize: sizefont,
                  ),
                ),
                Text(
                  widget.minStipend!,
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
        SizedBox(
          width: size.width * 0.05,
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
            SizedBox(
              width: sizefont * 0.5,
            ),
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
                  widget.duration!,
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
          headerBuilder: (context, isExpanded) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'About The Company',
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
          headerBuilder: (context, isExpanded) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
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
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 15, bottom: 8),
                    height: 5.0,
                    width: 5.0,
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Container(
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
                jobPosn,
                SizedBox(
                  height: size.width * 0.05,
                ),
                jobDetails,
                SizedBox(
                  height: size.width * 0.05,
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
                (DateFormat("yyyy-MM-ddTHH:mm:ss.SSSZ")
                            .parse(widget.deadline ?? ""))
                        .isAfter(DateTime.now())
                    ? applyButton
                    : const SizedBox.shrink()
              ]),
        ),
      ),
    );
  }
}
