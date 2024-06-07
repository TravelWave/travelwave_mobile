import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:travelwave_mobile/blocs/vehicles/vehicles_bloc.dart';
import 'package:travelwave_mobile/constants.dart';
import 'package:travelwave_mobile/models/driver_model.dart';

class DriverFormScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormBuilderState>();

  DriverFormScreen({super.key});
  final TextEditingController nameController = TextEditingController();
  final TextEditingController makeController = TextEditingController();
  final TextEditingController modelController = TextEditingController();
  final TextEditingController colorController = TextEditingController();
  final TextEditingController plateController = TextEditingController();
  final TextEditingController seatController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController licenseController = TextEditingController();
  final TextEditingController driverLicenseController = TextEditingController();
  final TextEditingController driverLicenseExpController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Driver's Vehicle Information Form",
          style: TextStyle(fontSize: 15),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: FormBuilder(
          key: _formKey,
          child: ListView(
            children: [
              const Text(
                  "Provide the following information to register your vehicle and become a driver once approved by the admin."),
              SizedBox(height: 10.v),
              FormBuilderTextField(
                name: 'Vehicle name',
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Vehicle Name',
                  border: OutlineInputBorder(),
                ),
                validator: FormBuilderValidators.required(),
              ),
              SizedBox(height: 16.0),
              FormBuilderTextField(
                name: 'Vehicle make',
                controller: makeController,
                decoration: InputDecoration(
                  labelText: 'Vehicle Make',
                  border: OutlineInputBorder(),
                ),
                validator: FormBuilderValidators.required(),
              ),
              SizedBox(height: 16.0),
              FormBuilderTextField(
                name: 'Vehicle model',
                controller: modelController,
                decoration: InputDecoration(
                  labelText: 'Vehicle Model',
                  border: OutlineInputBorder(),
                ),
                validator: FormBuilderValidators.required(),
              ),
              SizedBox(height: 16.0),
              FormBuilderTextField(
                name: 'Vehicle color',
                controller: colorController,
                decoration: InputDecoration(
                  labelText: 'Vehicle Color',
                  border: OutlineInputBorder(),
                ),
                validator: FormBuilderValidators.required(),
              ),
              SizedBox(height: 16.0),
              FormBuilderTextField(
                name: 'license_plate',
                controller: plateController,
                decoration: InputDecoration(
                  labelText: 'License Plate',
                  border: OutlineInputBorder(),
                ),
                validator: FormBuilderValidators.required(),
              ),
              SizedBox(height: 16.0),
              FormBuilderTextField(
                name: 'number_of_seats',
                controller: seatController,
                decoration: InputDecoration(
                  labelText: 'Number of Seats',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.numeric(),
                ]),
              ),
              SizedBox(height: 16.0),
              FormBuilderTextField(
                name: 'year',
                controller: yearController,
                decoration: InputDecoration(
                  labelText: 'Year',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.numeric(),
                  FormBuilderValidators.min(1900),
                  FormBuilderValidators.max(2100),
                ]),
              ),
              SizedBox(height: 16.0),
              FormBuilderTextField(
                name: 'driver_license',
                controller: licenseController,
                decoration: InputDecoration(
                  labelText: 'Driver License',
                  border: OutlineInputBorder(),
                ),
                validator: FormBuilderValidators.required(),
              ),
              SizedBox(height: 16.0),
              FormBuilderDateTimePicker(
                name: 'driver_license_expiration_date',
                initialDate: DateTime.now(),
                controller: driverLicenseExpController,
                fieldHintText: 'Driver License Expiration Date',
                inputType: InputType.date,
                format: DateFormat('yyyy-MM-dd'),
                decoration: InputDecoration(
                  labelText: 'Driver License Expiration Date',
                  border: OutlineInputBorder(),
                ),
                validator: FormBuilderValidators.required(),
              ),
              SizedBox(height: 32.v),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.saveAndValidate() ?? false) {
                    final val = _formKey.currentState?.value;

                    BlocProvider.of<VehiclesBloc>(context).add(
                      CreateVehiclesByDriver(
                        vehicle: DriverModel(
                          isBusy: false,
                          isVerified: false,
                          name: val?['Vehicle name'],
                          make: val?['Vehicle make'],
                          model: val?['Vehicle model'],
                          color: val?['Vehicle color'],
                          licensePlate: val?['license_plate'],
                          numberOfSeats: int.parse(val?['number_of_seats']),
                          year: int.parse(val?['year']),
                          driverLicense: val?['driver_license'],
                          driverLicenseExpirationDate:
                              val?['driver_license_expiration_date']
                                      .toString() ??
                                  "",
                        ),
                      ),
                    );
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
