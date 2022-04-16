import 'package:bus_ticket_app/exports.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);
  static const String routeName = '/setting';
  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool nameEditable = true;
  late String name, oldPassword, newPassword;
  bool editPassword = true;
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool passwordLoader = false;

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<UserData>(context, listen: false);
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text('Setting'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                    child: TextFormField(
                      readOnly: nameEditable,
                      initialValue: data.name,
                      onChanged: (value) => name = value,
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  nameEditable
                      ? ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: kPrimaryColor,
                          ),
                          onPressed: () {
                            setState(() {
                              nameEditable = false;
                            });
                          },
                          child: const Text('Edit'))
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: kPrimaryColor,
                          ),
                          onPressed: () {
                            setState(() async {
                              final user = FirebaseAuth.instance.currentUser;
                              await user?.updateDisplayName(name);
                              await user?.reload();
                              setState(() {});
                            });
                          },
                          child: const Text('Confirm'))
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            if (editPassword)
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: kPrimaryColor,
                  ),
                  onPressed: () {
                    setState(() {
                      editPassword = false;
                    });
                  },
                  child: const Text("Change Password")),
            if (!editPassword)
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration:
                          const InputDecoration(labelText: 'Old Password'),
                      onChanged: (value) => oldPassword = value,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your old password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      decoration:
                          const InputDecoration(labelText: 'New Password'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your old password';
                        } else if (value.length < 7) {
                          return 'Password must be at least 7 characters';
                        } else if (newPassword == oldPassword) {
                          return "New password can't be the same as old password";
                        }
                        return null;
                      },
                      onChanged: (value) => newPassword = value,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: kPrimaryColor,
                      ),
                      onPressed: () async {
                        setState(() {
                          passwordLoader = true;
                        });
                        _formKey.currentState!.validate();
                        await _changePassword(oldPassword, newPassword);

                        setState(() {
                          passwordLoader = false;
                        });
                      },
                      child: passwordLoader
                          ? const CircularProgressIndicator(
                              color: Colors.red,
                            )
                          : const Text("Confirm"),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  _changePassword(String currentPassword, String newPassword) async {
    final user = FirebaseAuth.instance.currentUser;
    final cred = EmailAuthProvider.credential(
        email: user!.email.toString(), password: currentPassword);

    await user.reauthenticateWithCredential(cred).then((value) {
      user.updatePassword(newPassword).then((_) {
        print("Password changed");
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Password changed successfully")));
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Error changing password")));
      });
    }).catchError((err) {});
  }
}
