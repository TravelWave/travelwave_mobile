import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:travelwave_mobile/constants.dart';

class DriverFormScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormBuilderState>();

  DriverFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Driver Information Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormBuilder(
          key: _formKey,
          child: ListView(
            children: [
              SizedBox(height: 7.v),
              FormBuilderTextField(
                name: 'name',
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                validator: FormBuilderValidators.required(),
              ),
              SizedBox(height: 16.0),
              FormBuilderTextField(
                name: 'make',
                decoration: InputDecoration(
                  labelText: 'Make',
                  border: OutlineInputBorder(),
                ),
                validator: FormBuilderValidators.required(),
              ),
              SizedBox(height: 16.0),
              FormBuilderTextField(
                name: 'model',
                decoration: InputDecoration(
                  labelText: 'Model',
                  border: OutlineInputBorder(),
                ),
                validator: FormBuilderValidators.required(),
              ),
              SizedBox(height: 16.0),
              FormBuilderTextField(
                name: 'color',
                decoration: InputDecoration(
                  labelText: 'Color',
                  border: OutlineInputBorder(),
                ),
                validator: FormBuilderValidators.required(),
              ),
              SizedBox(height: 16.0),
              FormBuilderTextField(
                name: 'license_plate',
                decoration: InputDecoration(
                  labelText: 'License Plate',
                  border: OutlineInputBorder(),
                ),
                validator: FormBuilderValidators.required(),
              ),
              SizedBox(height: 16.0),
              FormBuilderTextField(
                name: 'number_of_seats',
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
                    print(_formKey.currentState?.value);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Form submitted successfully!')),
                    );
                  } else {
                    print('Validation failed');
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
