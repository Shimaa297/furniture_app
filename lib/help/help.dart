import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:untitled/help/constants/constant.dart';


const defaultColor = Color(0xFF93D8F8);


// 1. TextFormField
// 2. Button
// 3. Navigation
// 4. helpContainerShadow
// 5. ListTileSetting
// 6. Width
// 7. height
// 8. Loading
// 9. Network Image
// 10. Address(location)

//List<Address> address;
Widget helpTextField({
  String labelText,
  validator,
  Color fillColor = Colors.white,
  double radius,
  TextInputType textInputType,
  Function onSave,
  TextEditingController controller,
  bool isPassword = false,
  Widget prefixIcon,
}) =>
    TextFormField(
      controller: controller,
      obscureText: isPassword,
      decoration: new InputDecoration(
        labelText: labelText,
        fillColor: fillColor,
        prefixIcon: prefixIcon,
        filled: true,
        enabledBorder: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(radius),
          borderSide: new BorderSide(color: Colors.white),
        ),
      ),
      validator: (val) {
        if (val.length == 0) {
          return validator;
        } else {
          return null;
        }
      },
      keyboardType: textInputType,
      style: new TextStyle(
        fontFamily: "Cairo",
      ),
      onSaved: onSave,
    );

Widget helpButton({
  @required String text,
  IconData icon,
  @required Function function,
  Color background = defaultColor,
  borderColor = defaultColor,
  textColor,
  double width = double.infinity,
  radius,
  elevation,
  fontSize = 15.0,
}) {
  return Container(
    width: width,
    decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: borderColor)),
    child: MaterialButton(
      onPressed: function,
      elevation: elevation,
      child: Text(
        text,
        style: GoogleFonts.cairo(
          color: textColor,
          fontWeight: FontWeight.w600,
          fontSize: fontSize,
        ),
      ),
    ),
  );
}

void helpNavigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

Widget helpContainerShadow(Widget content) => Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.16),
              spreadRadius: 2,
              blurRadius: 3,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ]),
      child: content,
    );

Widget helpSetting({
  IconData icon,
  String text,
  Function function,
  Color iconColor = Colors.black,
  iconC,
  textColor,
}) =>
    Column(
      children: [
        ListTile(
          onTap: function,
          leading: Icon(
            icon,
            color: iconColor,
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 20,
            color: iconC,
          ),
          title: Text(
            text,
            style: GoogleFonts.cairo(
              color: textColor,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
        Divider(
          color: Colors.grey[400],
        )
      ],
    );

double helpWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double helpHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

Widget helpLoading() {
  return Center(
    child: Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
         // Image.asset('assets/logo.png'),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 60,
            child: LoadingIndicator(
              indicatorType: Indicator.ballPulseSync,
              color: defaultColor,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget helpImage(String image, double radius) {
  return image != null
      ? CachedNetworkImage(
          imageUrl: image,
          fit: BoxFit.contain,
          httpHeaders: {
            'Content-Type': 'application/json;charset=UTF-8',
            'Charset': 'utf-8'
          },
          imageBuilder: (
            ctx,
            image,
          ) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius),
                image: DecorationImage(
                  image: image,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
          placeholder: (_, __) => Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radius),
              // gradient: LinearGradient(
              //     begin: Alignment(-2, 0),
              //     end: Alignment(1, 0),
              //     colors: [Colors.white, Colors.green])
            ),
            // child: Padding(
            //   padding: const EdgeInsets.all(24.0),
            //   child:
            //   //Image.asset('assets/logo.png'),
            // ),
          ),
          errorWidget: (context, url, error) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              color: Colors.white,
              // gradient: LinearGradient(
              //     begin: Alignment(-2, 0),
              //     end: Alignment(1, 0),
              //     colors: [Colors.white, Colors.green]
              // )
            ),
            // child: Padding(
            //     padding: const EdgeInsets.all(24.0),
            //     child: Image.asset('assets/logo.png')),
          ),
        )
      : Container(
          decoration: BoxDecoration(
              color: Color(0xffE61368),
              borderRadius: BorderRadius.circular(radius),
              gradient: LinearGradient(
                  begin: Alignment(-2, 0),
                  end: Alignment(1, 0),
                  colors: [Color(0xffE61368), Color(0xff412A44)])),
          // child: Padding(
          //   padding: const EdgeInsets.all(24.0),
          //   child: Image.asset('assets/logo.png'),
          // ),
        );
}

Widget helpIconButton(
    Color background,
    BoxShape boxShape,
    Function function,
    IconData icon,
    Color iconColor,
    )=>  Container(
  decoration: BoxDecoration(
    shape: boxShape,
    borderRadius: boxShape== BoxShape.circle ? null : BorderRadius.circular(15),
    gradient: LinearGradient(
        begin: Alignment(-2, 0),
        end: Alignment(1, 0),
        colors: [Colors.white, background])
  ),
  child: IconButton(
      icon: Icon(
        icon,
        color: iconColor),
      onPressed: function,
  ),
);
