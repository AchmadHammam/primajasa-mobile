import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:primajasa/component/costum_button.dart';
import 'package:primajasa/component/costum_text_input.dart';
import 'package:primajasa/controller/checklist.dart';

class ChecklistCreatePage extends StatefulWidget {
  const ChecklistCreatePage({super.key});

  @override
  State<ChecklistCreatePage> createState() => _ChecklistCreatePageState();
}

class _ChecklistCreatePageState extends State<ChecklistCreatePage> {
  TextEditingController titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.1,
          horizontal: MediaQuery.of(context).size.width * 0.05,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.1,
                ),
                child: Center(
                  child: Text(
                    'Create Check List',
                    style: GoogleFonts.roboto(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              CostumTextInput(
                controller: titleController,
                hintText: "Title",
                keyboardType: TextInputType.text,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.1,
                ),
                child: ButtonInput(
                  onPressed: () {
                    createCheckList(titleController.text).then((value) {
                      if (value == 200) {
                        Navigator.pop(context);
                      }
                    });
                  },
                  text: 'Submit',
                ),
              )
            ],
          ),
        ),
     
      ),
    );
  }
}
