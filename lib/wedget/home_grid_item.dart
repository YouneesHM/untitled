import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeGridItem extends StatelessWidget{
  final String label;
  final String coverPath;
  final IconData icon;

  const HomeGridItem({Key? key,
    required this.label, required this.coverPath, required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          color: Colors.grey.shade800),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(6),
                    topRight: Radius.circular(6),
                  ),
                  child: SizedBox(
                    height: double.maxFinite,
                    child: Stack(
                      children: [
                        Image.asset(coverPath,
                            width: 60,
                            fit: BoxFit.cover),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Icon(
                                CupertinoIcons.person_2_alt, size: 18,
                                color: Colors.tealAccent.shade700)
                          ],
                        ),

                      ],
                    ),


                  ),
                ),

                const SizedBox(
                  width: 20,
                ),
                Text(label, style: const TextStyle(color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 12)),


              ],
            ),
          ]),
    );
  }
}