import 'package:flutter/material.dart';

class MyRoundedButton extends StatelessWidget {
  final Function onPress;
  final String label;
  final Color color;
  final bool disabled;
  final bool outline;
  MyRoundedButton(
      {@required this.color,
      @required this.label,
      @required this.onPress,
      this.disabled = false,
      this.outline = false});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: disabled ? () {} : onPress,
      child: Container(
        width: double.infinity,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
              border: outline
                  ? Border.all(
                      color: color,
                      width: 2.0,
                    )
                  : null,
              color: disabled
                  ? Colors.grey[400]
                  : outline
                      ? Colors.white
                      : color,
              borderRadius: BorderRadius.circular(50.0)),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                  color: !outline ? Colors.white : color,
                  fontWeight: FontWeight.w500,
                  fontSize: 20.0),
            ),
          ),
        ),
      ),
    );
  }
}

// class MyRoundedButton extends StatelessWidget {
//   final Function onPress;
//   final String label;
//   final Color color;
//   final bool disabled;
//   MyRoundedButton(
//       {@required this.color,
//       @required this.label,
//       @required this.onPress,
//       this.disabled=false});
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: disabled ? () {} : onPress,
//       child: Container(
//         padding: EdgeInsets.all(15.0),
//         decoration: BoxDecoration(
//             color: disabled ? Colors.grey[400] : color,
//             borderRadius: BorderRadius.all(Radius.circular(25.0))),
//         margin: EdgeInsets.all(15.0),
//         height: 60.0,
//         child: Text(
//           label,
//           textAlign: TextAlign.center,
//           style: TextStyle(
//             fontSize: 25.0,
//             color: Colors.white,
//             fontFamily: 'Ubuntu',
//           ),
//         ),
//         width: double.infinity,
//       ),
//     );
//   }
// }
