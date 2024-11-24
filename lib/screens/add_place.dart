import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/providers/user_places.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  ConsumerState<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  final _formKey = GlobalKey<FormState>();
  String _enteredTitle = '';

  void _savePlace() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      ref.read(userPlaceProvider.notifier).addPlace(_enteredTitle);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Place"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Theme.of(context).colorScheme.onSurface),
                maxLength: 20,
                validator: (value) {
                  if (value == null ||
                      value.trim().length <= 1 ||
                      value.isEmpty) {
                    return "Must be between 1 and 20 characters";
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    _enteredTitle = value!;
                  });
                },
                decoration: const InputDecoration(label: Text("Title")),
              ),
              ElevatedButton.icon(
                onPressed: _savePlace,
                icon: Icon(
                  Icons.add,
                  color: Theme.of(context).colorScheme.primary,
                ),
                label: const Text("Add Item"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
