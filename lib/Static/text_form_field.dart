// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//import '../../theme_singleton.dart';

class CustomEntryField extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final TextInputType type;
  final bool autofocus;
  final Iterable<String>? autoHints;
  final double? radius;
  final int limit;
  final bool? obscure;
  final bool enabled;
  final String? Function(BuildContext context)? validation;
  final Function()? toggleVisibility;
  final Function(BuildContext context)? onChanged;
  final FontWeight fontWeight;
  final FocusNode? focusNode;
  final GlobalKey<FormState>? formKey;
  final AllowedEntryInputType allowedType;
  final TextInputAction textInputAction;
  final bool? isPrefixIcon;
  final Icon? prefixIcon;
  final bool? isSmall;

  const CustomEntryField(
      {Key? key,
      required this.controller,
      required this.hint,
      required this.allowedType,
      this.autofocus = false,
      this.autoHints,
      this.limit = 100,
      this.radius,
      this.type = TextInputType.emailAddress,
      this.validation,
      this.obscure,
      this.enabled = true,
      this.toggleVisibility,
      this.onChanged,
      this.fontWeight = FontWeight.w400,
      this.focusNode,
      this.formKey,
      this.textInputAction = TextInputAction.next,
      this.isPrefixIcon,
      this.prefixIcon,
      this.isSmall})
      : super(key: key);

  @override
  State<CustomEntryField> createState() => _CustomEntryFieldState();
}

class _CustomEntryFieldState extends State<CustomEntryField> {
  var autoValMode = AutovalidateMode.disabled;

  @override
  void initState() {
    preventDoubleSpaces();
    widget.focusNode?.addListener(() {
      if (widget.focusNode != null && !widget.focusNode!.hasFocus) {
        // formKey.currentState?.validate();
        setState(() {
          autoValMode = AutovalidateMode.onUserInteraction;
        });
        removeTrailingSpaces();
      }
    });
    super.initState();
  }

  void preventDoubleSpaces() {
    widget.controller.addListener(() {
      var currentText = widget.controller.text;
      if (currentText.endsWith("  ")) {
        widget.controller.text =
            currentText.substring(0, currentText.length - 1);
        // Set cursor position to end again
        widget.controller.selection = TextSelection.fromPosition(
            TextPosition(offset: widget.controller.text.length));
      }
    });
  }

  void removeTrailingSpaces() {
    var t = widget.controller.text;
    if (t.endsWith(" ")) {
      widget.controller.text = t.substring(0, t.length - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    List<TextInputFormatter> inputFormatters = [
      LengthLimitingTextInputFormatter(widget.limit)
    ];

    switch (widget.allowedType) {
      case AllowedEntryInputType.onlyNumber:
        var numRegex = RegExp("[0-9]");
        inputFormatters.add(FilteringTextInputFormatter.allow(numRegex));
        break;
      case AllowedEntryInputType.onlyChars:
        var charRegex = RegExp("[a-zA-ZçÇğĞıİöÖşŞüÜ ]");
        inputFormatters.add(FilteringTextInputFormatter.allow(charRegex));
        break;
      case AllowedEntryInputType.bothNumberAndChars:
        var regex = RegExp("[0-9a-zA-zçÇğĞıİöÖşŞüÜ ]");
        inputFormatters.add(FilteringTextInputFormatter.allow(regex));
        break;
      case AllowedEntryInputType.email:
        break;
      case AllowedEntryInputType.address:
        var regex = RegExp("[0-9a-zA-zçÇğĞıİöÖşŞüÜ .,:;\(\)\/-]");
        inputFormatters.add(FilteringTextInputFormatter.allow(regex));
        break;
      case AllowedEntryInputType.phone:
        var numRegex = RegExp("[0-9]");
        inputFormatters.add(FilteringTextInputFormatter.allow(numRegex));
        break;
      case AllowedEntryInputType.mersis:
        var numRegex = RegExp("[0-9-]");
        inputFormatters.add(FilteringTextInputFormatter.allow(numRegex));
        break;
      case AllowedEntryInputType.kycDate:
        // TODO: Handle this case.
        break;
      case AllowedEntryInputType.any:
        break;
    }

    // Prevent leading space
    inputFormatters.add(FilteringTextInputFormatter.deny(
      RegExp(r'^ +'), //users can't type 0 at 1st position
    ));

// Prevent emojis
    final RegExp emojiRegexp = RegExp(
        r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])');
    inputFormatters.add(FilteringTextInputFormatter.deny(emojiRegexp));

    return Semantics(
      enabled: true,
      excludeSemantics: true,
      label: widget.hint,
      child: Container(
          //color: Colors.amber,
          width: screenWidth * 0.8,
          height: screenHeight * 0.08,
          child: TextField(
            textInputAction: widget.textInputAction,
            //autovalidateMode: autoValMode,
            focusNode: widget.focusNode,
            autofillHints: widget.autoHints,
            autofocus: widget.autofocus,
            enabled: widget.enabled,

            onChanged: (value) {
              if (widget.onChanged != null) {
                widget.onChanged!(context);
              }
            },
            /* textAlign:
                widget.isSmall != null ? TextAlign.center : TextAlign.start, */
            maxLines: widget.obscure != null ? 1 : 1,
            cursorColor: const Color.fromRGBO(232, 232, 232, 100),
            controller: widget.controller,
            inputFormatters: inputFormatters,
            keyboardType: widget.type,
            style: widget.enabled == true ? TextStyle() : TextStyle(),

            obscureText: widget.obscure ?? false,
            decoration: InputDecoration(
              prefixIcon: widget.prefixIcon,
              fillColor: Colors.blue.shade100,
              filled: true,
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                borderSide: BorderSide(
                  width: 1,
                  color: Color.fromRGBO(188, 187, 187, 0.612),
                ),
              ),
              errorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                borderSide: BorderSide(
                  width: 1,
                  color: Color.fromRGBO(188, 187, 187, 0.612),
                ),
              ),
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                borderSide: BorderSide(
                  width: 1,
                  color: Color.fromRGBO(188, 187, 187, 0.612),
                ),
              ),
              disabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                borderSide: BorderSide(
                  width: 1,
                  color: Color.fromRGBO(188, 187, 187, 0.612),
                ),
              ),
              focusedErrorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                borderSide: BorderSide(
                  width: 1,
                  color: Color.fromRGBO(188, 187, 187, 0.612),
                ),
              ),
              /* contentPadding: widget.isSmall != null
                  ? const EdgeInsets.fromLTRB(0.0, 1.0, 0.0, 1.0)
                  : const EdgeInsets.fromLTRB(30.0, 14.0, 30.0, 14.0), */
              hintStyle: TextStyle(),
              hintText: widget.hint,
              //labelText: widget.hint,
              labelStyle: TextStyle(),
              border: InputBorder.none,
              suffixIcon: widget.obscure != null
                  ? IconButton(
                      icon: Icon(
                        widget.obscure!
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: Colors.blue,
                        size: 20,
                      ),
                      onPressed: widget.toggleVisibility,
                    )
                  : const SizedBox(),
            ),
          )),
    );
  }
}

enum AllowedEntryInputType {
  onlyNumber,
  onlyChars,
  bothNumberAndChars,
  email,
  address,
  phone,
  mersis,
  kycDate,
  any
}
