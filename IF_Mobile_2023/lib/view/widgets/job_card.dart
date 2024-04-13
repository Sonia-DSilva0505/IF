import 'package:flutter/material.dart';
import 'package:internship_fair/view/jobdesc.dart';
import 'package:intl/intl.dart';

class JobCard extends StatelessWidget {
  final String? companyName;
  final String? duration;
  final String? stipend;
  final String? location;
  final String? position;
  final String? mode;
  final String? logo;
  final List<String>? requirements;
  final String? skills;
  final String? about;
  final String? jobid;
  final int? v;
  final String? deadline;

  const JobCard(
      {Key? key,
      required this.companyName,
      required this.duration,
      required this.stipend,
      required this.location,
      required this.position,
      required this.mode,
      required this.deadline,
      required this.about,
      required this.requirements,
      required this.skills,
      required this.jobid,
      this.logo,
      this.v})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
  return Container(
    padding: EdgeInsets.fromLTRB(
        MediaQuery.of(context).size.width * 0.058, 0, MediaQuery.of(context).size.width * 0.05, 0),
    width: MediaQuery.of(context).size.width * 0.85,
    margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height * 0.031,
        left: MediaQuery.of(context).size.width * 0.072,
        right: MediaQuery.of(context).size.width * 0.072),
    decoration: BoxDecoration(
      border: Border.all(width: 0.3),
      borderRadius: BorderRadius.circular(3),
      color: Colors.white,
    ),
    child: Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top:10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  position!,
                  style: const TextStyle(
                    fontFamily: 'poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                    color: Colors.teal,
                  ),
                ),
                const Spacer(),
                SizedBox(
                  // height: MediaQuery.of(context).size.width * 0.15,
                  width: MediaQuery.of(context).size.width * 0.15,
                  child: Image.network(
                          logo ?? "",
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(
                              child: Icon(Icons.error_outline, color: Colors.red),
                            );
                          },
                        ),
                )
              ],
            ),
            Text(
              companyName ?? "",
              style: const TextStyle(
                  fontFamily: 'poppins',
                  fontWeight: FontWeight.w500,
                  fontSize: 13),
            ),
            const SizedBox(height: 4),
            Text(
              location ?? "",
              style: const TextStyle(
                  fontFamily: 'poppins',
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                  color: Colors.grey),
            ),
            Row(
              children: [
                const Text(
                  'Deadline: ',
                  style: TextStyle(
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Colors.grey),
                ),
                Text(
                  DateFormat('MMM d, yyyy h:mm a')
                      .format(DateTime.parse(deadline ?? "")),
                  style: const TextStyle(
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: Colors.black),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Row(
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.01),
                  height: 15,
                  width: 15,
                  decoration: const BoxDecoration(
                    color: Colors.teal,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.location_pin,
                      color: Colors.white,
                      size: 12,
                    ),
                  ),
                ),
                Flexible(
                  child: FittedBox(
                    child: Container(
                      margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.0194),
                      child: const Text(
                        'MODE',
                        style: TextStyle(
                            fontFamily: 'poppins',
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.0115,
                      left: MediaQuery.of(context).size.width * 0.0194),
                  height: 15,
                  width: 15,
                  decoration: const BoxDecoration(
                    color: Colors.teal,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.currency_rupee_outlined,
                      color: Colors.white,
                      size: 12,
                    ),
                  ),
                ),
                Flexible(
                  child: FittedBox(
                    child: Container(
                      margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.0194),
                      child: const Text(
                        'STIPEND',
                        style: TextStyle(
                            fontFamily: 'poppins',
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.0115,
                      left: MediaQuery.of(context).size.height * 0.0165,
                      ),
                  height: 15,
                  width: 15,
                  decoration: const BoxDecoration(
                    color: Colors.teal,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.timelapse_outlined,
                      color: Colors.white,
                      size: 12,
                    ),
                  ),
                ),
                
                Flexible(
                  child: FittedBox(
                    child: Container(
                      margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.0194),
                      child: const Text(
                        'DURATION',
                        style: TextStyle(
                            fontFamily: 'poppins',
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: Colors.grey),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Flexible(
                  child: FittedBox(
                    child: Container(
                      margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.055),
                      child: Text(
                        mode ?? "",
                        style: const TextStyle(
                            fontFamily: 'poppins',
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: Colors.black),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: FittedBox(
                    child: Container(
                      margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.096),
                      child: Text(
                        stipend ?? "",
                        style: const TextStyle(
                            fontFamily: 'poppins',
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: Colors.black),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: FittedBox(
                    child: Container(
                      margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.138),
                      child: Text(
                        duration ?? "",
                        style: const TextStyle(
                            fontFamily: 'poppins',
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.005,
            ),
            Row(
              children: [
                const Spacer(),
                InkWell(
                  child: const SizedBox(
                      height: 18,
                      child: Text(
                        'View details >',
                        style: TextStyle(
                            fontFamily: 'poppins',
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                            color: Colors.teal),
                      )),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => JobDesc(
                                  companyName: companyName ?? "",
                                  duration: duration ?? "",
                                  jobid: jobid ?? "",
                                  jobPosition: position ?? "",
                                  minStipend: stipend ?? "",
                                  workfromHome: mode ?? "",
                                  about: about ?? "",
                                  skills: skills,
                                  requirements: requirements ?? [],
                                  logo: logo!,
                                  location: location ?? "",
                                  deadline: deadline ?? "",
                                  v: v ?? 0,
                                  applied: false,
                                )));
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    )
  );
  }
}
