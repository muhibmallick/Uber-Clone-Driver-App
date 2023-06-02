import 'package:divers_app/Global/global.dart';
import 'package:divers_app/SplashScreen/splash_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CarInfoScreen extends StatefulWidget {
  const CarInfoScreen({super.key});

  @override
  State<CarInfoScreen> createState() => _CarInfoScreenState();
}

class _CarInfoScreenState extends State<CarInfoScreen> {
  TextEditingController carModelTextEditingController = TextEditingController();
  TextEditingController carNumberTextEditingController =
      TextEditingController();
  TextEditingController carColorTextEditingController = TextEditingController();

  List<String> cartypesList = ["uber-x", "uber-go", "bike"];
  String? selectedCartype;

  saveCarInfo() {
    Map DriverCarInfoMap = {
      "car_color": carColorTextEditingController.text.trim(),
      "car_number": carNumberTextEditingController.text.trim(),
      "car_model": carModelTextEditingController.text.trim(),
      "type": selectedCartype,
    };
    // refrence create a section subtree in a firebase having name (drivers)and being parent one
    DatabaseReference driversRef =
        FirebaseDatabase.instance.ref().child("drivers");
    // another refrence create another subsection in parent filling car details
    driversRef
        .child(currentFirebaseUser!.uid)
        .child("car_details")
        .set(DriverCarInfoMap);

    Fluttertoast.showToast(msg: "Car detail has successfully been saved.");
    Navigator.push(context,
        MaterialPageRoute(builder: ((context) => const MySplashScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(
                height: 24,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset("assets/logo1.png"),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Fill Your Car Details",
                style: TextStyle(
                  fontSize: 26,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),

              TextField(
                controller: carModelTextEditingController,
                style: const TextStyle(
                  color: Colors.grey,
                ),
                decoration: const InputDecoration(
                  labelText: "Car Model",
                  hintText: "Car Model",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              //********Textfield END**********
              TextField(
                controller: carNumberTextEditingController,
                style: const TextStyle(
                  color: Colors.grey,
                ),
                decoration: const InputDecoration(
                  labelText: "Car Number",
                  hintText: "Car Number",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              //********Textfield END**********
              TextField(
                controller: carColorTextEditingController,
                style: const TextStyle(
                  color: Colors.grey,
                ),
                decoration: const InputDecoration(
                  labelText: "Car Color",
                  hintText: "Car Color",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              DropdownButton(
                iconSize: 20,
                dropdownColor: Colors.black54,
                value: selectedCartype,
                items: cartypesList.map((car) {
                  return DropdownMenuItem(
                    value: car,
                    child: Text(
                      car,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  );
                }).toList(),
                hint: const Text(
                  "Please Choose Your Car Type",
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey,
                  ),
                ),
                onChanged: (newValue) {
                  setState(() {
                    selectedCartype = newValue.toString();
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              //*****************Elevatedbutton****************
              ElevatedButton(
                onPressed: () {
                  if (carColorTextEditingController.text.isNotEmpty &&
                      carModelTextEditingController.text.isNotEmpty &&
                      carNumberTextEditingController.text.isNotEmpty &&
                      selectedCartype != null) {
                    saveCarInfo();
                  }
                },
                style:
                    ElevatedButton.styleFrom(primary: Colors.lightGreenAccent),
                child: const Text(
                  "Save Now",
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
