import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CostumTextInput extends StatefulWidget {
  const CostumTextInput({
    super.key,
    required this.controller,
    required this.hintText,
    required this.keyboardType,
    this.secureText = false,
  });

  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final bool secureText;

  @override
  State<CostumTextInput> createState() => _CostumTextInputState();
}

class _CostumTextInputState extends State<CostumTextInput> {
  bool? secureText;
  @override
  void initState() {
    super.initState();
    secureText = widget.secureText;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.02,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            offset: Offset(0.0, 1.0), //(x,y)
            blurRadius: 1.0,
            color: Colors.grey,
          ),
        ],
      ),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: widget.hintText,
          contentPadding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.025,
          ),
          border: InputBorder.none,
          suffixIcon: (widget.hintText == "Password" ||
                  widget.hintText == "Confirm Password" ||
                  widget.hintText == "Ulangi Password Baru" ||
                  widget.hintText == "Konfirmasi Password")
              ? InkWell(
                  onTap: () {
                    setState(() {
                      secureText = !secureText!;
                    });
                  },
                  child: Icon(
                    secureText! ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                    color: Colors.grey,
                  ),
                )
              : const SizedBox.shrink(),
        ),
        controller: widget.controller,
        textCapitalization: TextCapitalization.sentences,
        keyboardType: widget.keyboardType,
        obscureText: secureText!,
        style: GoogleFonts.roboto(
          fontSize: 14,
        ),
      ),
    );
  }
}
