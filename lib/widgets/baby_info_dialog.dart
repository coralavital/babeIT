import 'package:fluttertoast/fluttertoast.dart';
import '../resources/firestore_service.dart';
import 'package:flutter/material.dart';
import '../theme/theme_colors.dart';
import '../utils/dimensions.dart';
import 'custom_button.dart';
import 'custom_loader.dart';

class BabyDialog extends StatefulWidget {
  String babyAge;
  String babyHeight;
  String babyWeight;
  String babyName;
  String babyIcon;

  BabyDialog(
      {super.key,
      required this.babyAge,
      required this.babyHeight,
      required this.babyIcon,
      required this.babyName,
      required this.babyWeight});

  @override
  State<BabyDialog> createState() => _BabyDialog();
}

class _BabyDialog extends State<BabyDialog> {
  bool editFields = false;
  String buttonText = "Edit";
  bool showAgeError = false;
  bool showHeigthError = false;
  bool showWeightError = false;

  bool showCancelBottun = false;

  final TextEditingController _age = TextEditingController();
  final TextEditingController _height = TextEditingController();
  final TextEditingController _weight = TextEditingController();
  final CustomLoader _loader = CustomLoader();


  updateBabyInformation(String age, String height, String weight) async {
    String res = await FirebaseFirestoreService().updateBabyInfo(
      age,
      height,
      weight,
    );
    if (res == 'success') {
      _loader.hideLoader();
      setState(() {
        
      });
      buttonText = 'Edit';
      editFields = false;
      showCancelBottun = false;

      
    } else {
      _loader.hideLoader();
      Fluttertoast.showToast(
        msg: res,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: Dimensions.size15,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        content: SingleChildScrollView(
            child: Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            alignment: Alignment.topRight,
            onPressed: () => Navigator.pop(context, 'Cancel'),
            icon: const Icon(Icons.close_rounded),
            color: Colors.black54,
            iconSize: Dimensions.size20,
          ),
        ],
      ),
      SizedBox(
        height: Dimensions.size10,
      ),
      Text(
        'Baby ${widget.babyName}',
        style: TextStyle(
            fontSize: Dimensions.size30,
            color: ThemeColors().color1,
            fontWeight: FontWeight.w600),
      ),
      SizedBox(
        height: Dimensions.size20,
      ),
      Image.network(
        widget.babyIcon,
        height: Dimensions.size120,
        width: Dimensions.size120,
      ),
      SizedBox(
        height: Dimensions.size30,
      ),
      TextField(
        controller: _age,
        enabled: editFields,
        cursorColor: ThemeColors().color2,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: widget.babyAge,
            prefixIcon: const Icon(Icons.numbers_outlined)),
      ),
      TextField(
        controller: _height,
        enabled: editFields,
        cursorColor: ThemeColors().color2,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: widget.babyHeight,
            prefixIcon: const Icon(Icons.height_outlined)),
      ),
      TextField(
        controller: _weight,
        enabled: editFields,
        cursorColor: ThemeColors().color2,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: widget.babyWeight,
            prefixIcon: const Icon(Icons.line_weight_outlined)),
      ),
      SizedBox(
        height: Dimensions.size40,
      ),
      Column(children: [
        CustomButton(
          text: buttonText,
          onTap: () {
            if (buttonText == 'Edit') {
              buttonText = 'Save';
              editFields = true;
              showCancelBottun = true;
              setState(() {});
            } else {
              String age = _age.text.toString().trim();
              String height = _height.text.toString().trim();
              String weight = _weight.text.toString().trim();
         
        
                updateBabyInformation(age, height, weight);
              
            }
          },
        ),
        SizedBox(
          height: Dimensions.size5,
        ),
        showCancelBottun == true
            ? CustomButton(
                text: 'Cancel',
                onTap: () {
                  Navigator.pop(context, 'Cancel');
                },
              )
            : const SizedBox()
      ])
    ])));
  }
}
