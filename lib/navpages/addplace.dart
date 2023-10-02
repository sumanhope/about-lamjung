import 'dart:io';
import 'package:aboutlamjung/theme/color.dart';
import 'package:aboutlamjung/theme/texts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'dart:math';

class AddPlacePage extends StatefulWidget {
  const AddPlacePage({super.key});

  @override
  State<AddPlacePage> createState() => _AddPlacePageState();
}

class _AddPlacePageState extends State<AddPlacePage> {
  final placenamecontroller = TextEditingController();
  final placeaddresscontroller = TextEditingController();
  final placedescriptioncontroller = TextEditingController();
  final placeopentimecontroller = TextEditingController();

  File? pickedImage;

  String generateUniqueId(int length) {
    const String characters =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final Random random = Random.secure();
    final StringBuffer buffer = StringBuffer();

    for (int i = 0; i < length; i++) {
      final int randomIndex = random.nextInt(characters.length);
      buffer.write(characters[randomIndex]);
    }

    return buffer.toString();
    //0.00000000000000000000000000000287
  }

  Future errorDialog(String error) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          backgroundColor: AppColor.selectedItemColor,
          elevation: 5,
          title: Text(
            error,
            style: AppTexts.basicText,
          ),
        );
      },
    );
  }

  Future imagePicker() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      pickedImage = File(returnedImage!.path);
    });
  }

  bool checkfield() {
    if (placenamecontroller.text.trim().isNotEmpty &&
        placeaddresscontroller.text.trim().isNotEmpty &&
        placedescriptioncontroller.text.trim().isNotEmpty &&
        placeopentimecontroller.text.trim().isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Widget buildTextfield(
      TextEditingController controller, IconData icons, String hint) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: SizedBox(
        child: TextField(
          controller: controller,
          cursorColor: AppColor.primaryColor,
          maxLength: 250,
          maxLines: null,
          buildCounter: (BuildContext context,
                  {int? currentLength, int? maxLength, bool? isFocused}) =>
              null,
          enableSuggestions: false,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColor.fillColor,
            hintText: hint,
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 2),
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 2),
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            prefixIcon: Icon(
              icons,
              size: 25,
              color: AppColor.primaryColor,
            ),
          ),
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          style: AppTexts.basicText,
        ),
      ),
    );
  }

  Future submitplace(
    String placeid,
    String placename,
    String placeaddress,
    String placedescription,
    String opentime,
  ) async {
    try {
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColor.primaryColor,
              ),
            );
          });
      FirebaseFirestore.instance
          .collection('place')
          .doc(placeid)
          .get()
          .then((docSnapshot) {
        if (docSnapshot.exists) {
          // Document with the same ID already exists; handle it here
          Navigator.pop(context);
          errorDialog(
              'Incredible! A Duplicate ID($placeid) Has Been Unearthed! (Chance of This Happening: 0.00000000000000000000000000000287)');
        } else {
          // Document with the same ID does not exist; proceed to add it
          FirebaseFirestore.instance.collection('place').doc(placeid).set({
            'placeid': placeid,
            'placename': placename,
            'placeaddress': placeaddress,
            'placedescription': placedescription,
            'opentime': opentime,
            'placerating': [],
            'averagerating': 0,
            'totalreviews': 0,
            'imagelink': "",
            'contactno': "",
            'addedby': "",
          }).then(
            (value) {
              Navigator.pop(context);
              errorDialog("Place Added");
            },
          );
        }
      });
    } on Exception catch (e) {
      Navigator.pop(context);
      errorDialog(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return KeyboardDismisser(
      gestures: const [GestureType.onPanUpdateAnyDirection, GestureType.onTap],
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(226, 231, 231, 1),
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          toolbarHeight: 65,
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 10, bottom: 10),
            child: Container(
              height: 45,
              width: 49,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: AppColor.shadowColor,
                  width: 1.5,
                ),
              ),
              child: IconButton(
                padding: const EdgeInsets.only(left: 10),
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 25,
                  color: AppColor.secondaryColor,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          title: const Text(
            "Add Place ",
            style: AppTexts.appbarText,
          ),
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10, right: 10),
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: AppColor.shadowColor,
                    width: 1.5,
                  ),
                ),
                child: IconButton(
                  padding: const EdgeInsets.only(right: 1),
                  icon: const Icon(
                    Icons.help_sharp,
                    size: 25,
                    color: AppColor.secondaryColor,
                  ),
                  onPressed: () {},
                ),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: size.height * 0.4,
                  width: size.width,
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: AppColor.shadowColor,
                        blurRadius: 4,
                        offset: Offset(1, 8), // Shadow position
                      ),
                    ],
                  ),
                  child: pickedImage != null
                      ? Image.file(
                          pickedImage!,
                          fit: BoxFit.cover,
                        )
                      : const Center(
                          child: Text(
                            "Please select an image.",
                            style: AppTexts.basicText,
                          ),
                        ),
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Container(
                height: size.height * 0.08,
                width: size.width * 0.45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: const [
                    BoxShadow(
                      color: AppColor.shadowColor,
                      blurRadius: 4,
                      offset: Offset(1, 8), // Shadow position
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: imagePicker,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1B1B1B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Select Photo",
                    style: AppTexts.whitebasicText,
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              buildTextfield(
                placenamecontroller,
                Icons.abc,
                "Place Name",
              ),
              buildTextfield(
                placeaddresscontroller,
                Icons.place,
                "Street name",
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: size.height * 0.5,
                ),
                child: buildTextfield(
                  placedescriptioncontroller,
                  Icons.description,
                  "Describe the place (250 max)",
                ),
              ),
              buildTextfield(
                placeopentimecontroller,
                Icons.schedule,
                "6am - 8pm",
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: size.height * 0.08,
                    width: size.width * 0.45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: const [
                        BoxShadow(
                          color: AppColor.shadowColor,
                          blurRadius: 4,
                          offset: Offset(1, 8), // Shadow position
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        placeaddresscontroller.clear();
                        placenamecontroller.clear();
                        placedescriptioncontroller.clear();
                        placeopentimecontroller.clear();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        "Clear all",
                        style: AppTexts.whitebasicText,
                      ),
                    ),
                  ),
                  Container(
                    height: size.height * 0.08,
                    width: size.width * 0.45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: const [
                        BoxShadow(
                          color: AppColor.shadowColor,
                          blurRadius: 4,
                          offset: Offset(1, 8), // Shadow position
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        if (checkfield()) {
                          submitplace(
                            generateUniqueId(21),
                            placenamecontroller.text.trim(),
                            placeaddresscontroller.text.trim(),
                            placedescriptioncontroller.text.trim(),
                            placeopentimecontroller.text.trim(),
                          );
                        } else {
                          errorDialog("Please fill all fields");
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.secondaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        "Submit",
                        style: AppTexts.whitebasicText,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
