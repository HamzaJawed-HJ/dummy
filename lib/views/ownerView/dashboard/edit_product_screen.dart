import 'package:flutter/material.dart';
import 'package:fyp_renterra_frontend/core/utlis/helper_functions.dart';
import 'package:fyp_renterra_frontend/data/models/product_model.dart';
import 'package:fyp_renterra_frontend/data/networks/api_client.dart';
import 'package:fyp_renterra_frontend/generic_widgets/custom_input_field_widget.dart';
import 'package:fyp_renterra_frontend/viewModel/renter_viewModel/productViewModel.dart';
import 'package:fyp_renterra_frontend/views/renterView/auth/renter_signUp_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:provider/provider.dart';

class EditProductScreen extends StatefulWidget {
  ProductModel obj;
  EditProductScreen({required this.obj, super.key});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _formKey = GlobalKey<FormState>();

  String? _image;
  final picker = ImagePicker();
  String? selectedCategory;

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();

  final priceController = TextEditingController();
  final rentForDaysController = TextEditingController();

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = pickedFile.path;
      });
      print(_image);
      print(_image);
    }
  }

  @override
  void initState() {
    setControllers();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productVM = Provider.of<ProductViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Edit Product',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue[800],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),

              Center(
                child: GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    width: double.infinity,
                    height: 180,
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: _image != null
                        ? _image!.split(":")[0] == "http"
                            ? Image.network(
                                _image!,
                                errorBuilder: (_, __, ___) => Container(
                                  height: 160,
                                  width: double.infinity,
                                  color: Colors.grey[200],
                                  child: Icon(Icons.broken_image, size: 60, color: Colors.grey),
                                ),
                              )
                            : Image.file(File(_image!), fit: BoxFit.cover)
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Icon(Icons.add_a_photo, size: 40, color: Colors.blue), SizedBox(height: 10), Text("Add Product Photo")],
                          ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ContainerText(padding: EdgeInsets.zero, stringText: "Product Name"),

              CustomInputField(
                title: "Enter product name",
                controller: nameController,
                icon: Icons.text_fields_rounded,
                inputType: TextInputType.text,
                validation_text: 'Enter Name',
              ),
              // TextField(
              //   controller: nameController,
              //   decoration: InputDecoration(hintText: 'Enter product name'),
              // ),
              SizedBox(height: 20),
              Text(
                "Category",
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Wrap(
                  spacing: 20,
                  children: ["Sedans", "SUVs", "MPVs"].map((cat) {
                    return ChoiceChip(
                      label: Text(cat),
                      selected: selectedCategory == cat,
                      selectedColor: Colors.blue[200],
                      onSelected: (_) {
                        setState(() {
                          selectedCategory = cat;
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 20),
              ContainerText(padding: EdgeInsets.zero, stringText: "Description"),

              CustomInputField(
                maxLine: 4,
                title: "Enter Description",
                controller: descriptionController,
                icon: Icons.donut_large,
                inputType: TextInputType.text,
                validation_text: 'Enter Description',
              ),

              SizedBox(
                height: 20,
              ),
              ContainerText(padding: EdgeInsets.zero, stringText: "Price"),

              CustomInputField(
                title: "Enter product Price",
                controller: priceController,
                icon: Icons.text_fields_rounded,
                inputType: TextInputType.text,
                validation_text: 'Enter Price',
              ),

              SizedBox(
                height: 20,
              ),

              ContainerText(padding: EdgeInsets.zero, stringText: "Days for Rent"),

              CustomInputField(
                title: "Enter Days for rent",
                controller: rentForDaysController,
                icon: Icons.text_fields_rounded,
                inputType: TextInputType.text,
                validation_text: 'Enter Days',
              ),

              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  // String? accessToken = await SessionManager.getAccessToken();
                  // Map<String, String?> userInfo =
                  //     await SessionManager.getUserInfo();

                  // final location = userInfo['area'];

                  // print("Print LOcation" + location.toString());

//                  print(userInfo['area']);

                  // inside your form submit button:
                  if (_formKey.currentState!.validate() && _image != null && selectedCategory != null) {
                    print("category " + selectedCategory!);
                    print("image path " + _image!);
                    productVM.editProduct(
                      productId: widget.obj.id,
                      category: selectedCategory!.trim(),
                      name: nameController.text.trim(),
                      description: descriptionController.text.trim(),
                      price: priceController.text.trim(),
                      timePeriod: rentForDaysController.text.trim(),
                      imageFile: _image!,
                      context: context,
                    );
                    // Future.delayed(
                    //   Duration(seconds: 1),
                    //   () {
                    //   },
                    // );

                    // print(productVM.)
                  } else {
                    HelperFunctions.showErrorSnackbar(context, 'Please fill all fields and select an image.');
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 55,
                  decoration: BoxDecoration(color: Colors.blue.shade600, borderRadius: BorderRadius.circular(14)),
                  child: productVM.isLoading
                      ? CircularProgressIndicator(
                          strokeWidth: 4,
                          color: Colors.white,
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.check,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Submit",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void setControllers() {
    _image = ApiClient.baseImageUrl + widget.obj.image;
    print(_image);
    print(_image);
    selectedCategory = widget.obj.category;
    print(selectedCategory);
    nameController.text = widget.obj.name;
    descriptionController.text = widget.obj.description;
    priceController.text = widget.obj.price.toString();
    rentForDaysController.text = widget.obj.timePeriod;
  }
}
