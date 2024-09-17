import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pets_app/cubit/pets_cubit.dart';
import 'package:flutter_pets_app/cubit/user_cubit.dart';
import 'package:flutter_pets_app/models/pet_details_model.dart';
import 'package:flutter_pets_app/models/user_details_model.dart';
import 'package:flutter_pets_app/widgets/custom_button.dart';
import 'package:flutter_pets_app/widgets/custom_text_field.dart';
import 'package:image_picker/image_picker.dart';

class AddNewPet extends StatefulWidget {
  const AddNewPet({super.key});

  @override
  State<AddNewPet> createState() => _AddNewPetState();
}

class _AddNewPetState extends State<AddNewPet> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  String? _selectedValue;
  final List<String> _dropdownOptions = ['Dogs', 'Cats', 'Birds', 'Fish'];

  @override
  void initState() {
    super.initState();
    _categoryController.addListener(_updateTextController);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _colorController.dispose();
    _ageController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  void _updateTextController() {
    if (_selectedValue != null) {
      _categoryController.text = _selectedValue!;
    }
  }

  FirebaseAuth user = FirebaseAuth.instance;

  XFile? _image;
  String? _base64Image;

  final picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _image = XFile(pickedFile.path);

      final bytes = await pickedFile.readAsBytes();
      _base64Image = base64Encode(bytes);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Add Pet",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: FutureBuilder<UserDetails?>(
              future: context
                  .read<UserCubit>()
                  .getUserDetails(user.currentUser!.uid.toString()),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData && snapshot.data != null) {
                  UserDetails userDetails = snapshot.data!;
                  return Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.04,
                      ),
                      const Text(
                          "Please fill the required details to continue"),
                      const SizedBox(
                        height: 24,
                      ),
                      GestureDetector(
                        onTap: _pickImage,
                        child: _image == null
                            ? const CircleAvatar(
                                radius: 50,
                                child: Icon(Icons.image),
                              )
                            : CircleAvatar(
                                radius: 50,
                                child: Image.file(File(_image!.path)),
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: TextField(
                          controller: _categoryController,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                            hintText: 'Select or Type',
                            suffixIcon: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: _selectedValue,
                                hint: const Text('Select an option'),
                                items: _dropdownOptions.map((String option) {
                                  return DropdownMenuItem<String>(
                                    value: option,
                                    child: Text(option),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _selectedValue = newValue;
                                    _updateTextController();
                                  });
                                },
                              ),
                            ),
                          ),
                          onChanged: (text) {
                            setState(() {
                              _selectedValue = null;
                            });
                          },
                        ),
                      ),
                      CustomTextField(
                        controller: _nameController,
                        icon: Icons.pets,
                        hintText: 'Name',
                      ),
                      CustomTextField(
                        controller: _descriptionController,
                        icon: Icons.description,
                        hintText: 'Description',
                        maxLines: 3,
                      ),
                      CustomTextField(
                        controller: _colorController,
                        icon: Icons.color_lens,
                        hintText: 'Color',
                      ),
                      CustomTextField(
                        controller: _ageController,
                        icon: Icons.calendar_month,
                        hintText: 'Age',
                        keyBoardType: TextInputType.number,
                      ),
                      CustomTextField(
                        readOnly: true,
                        icon: Icons.person,
                        hintText: userDetails.name.toString(),
                      ),
                      CustomTextField(
                        readOnly: true,
                        icon: Icons.phone,
                        hintText: userDetails.phone.toString(),
                      ),
                      CustomButton(
                        text: 'Add Pet',
                        onTap: () async {
                          final PetDetails petDetails = PetDetails(
                              petName: _nameController.text,
                              petDescription: _descriptionController.text,
                              petColor: _colorController.text,
                              petAge: _ageController.text,
                              petCategory: _categoryController.text,
                              petImage: _base64Image);
                          context.read<PetCubit>().addPetDetails(
                              user.currentUser!.uid.toString(), petDetails);
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Added Successfully")));
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                } else {
                  return const Center(child: Text('No user details found'));
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
