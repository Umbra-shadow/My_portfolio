import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../design/color.dart';
import '../design/model.dart';
import '../tools/countries.dart';
import '../tools/validators.dart';

class FormLink extends StatelessWidget {
  final String text1;
  final String text2;
  final VoidCallback onPressed;

  const FormLink({
    super.key,
    required this.text1,
    required this.text2,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text1,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: AppColors.textSecondaryBlack,
            letterSpacing: 0.1,
          ),
        ),
        TextButton(
          onPressed: onPressed, // The action happens here.
          style: TextButton.styleFrom(
            foregroundColor: AppColors.textPrimaryBlack,
            padding: const EdgeInsets.all(2), // Keep padding small.
          ),
          child: Text(
            text2,
            style: GoogleFonts.poppins(
              fontSize: 15,
              color: AppColors.textPrimaryBlack,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

// Okay, this is my simple, reusable widget for the links at the bottom of forms,
class FormHeader extends StatelessWidget {
  final String text1;
  final String text2;
  final String text3;

  const FormHeader({
    super.key,
    required this.text1,
    required this.text2,
    required this.text3,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      // color: Colors.white,
      child: Column(
        children: [
          const SizedBox(height: 10),
          Text(
            text1,
            style: GoogleFonts.poppins(
              fontSize: 35,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimaryWhite,
            ),
          ),
          Text(
            text2,
            style: GoogleFonts.poppins(
              color: AppColors.textPrimaryWhite,
              fontSize: 35,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            text3,
            style: GoogleFonts.poppins(
              color: AppColors.textSecondaryWhite,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class SpecialTextField extends StatefulWidget {
  final TextEditingController controller; // For the phone number itself
  final TextEditingController
  countryNameController; // To pass the selected country name back up

  const SpecialTextField({
    super.key,
    required this.controller,
    required this.countryNameController,
  });

  @override
  State<SpecialTextField> createState() => _SpecialTextFieldState();
}

class _SpecialTextFieldState extends State<SpecialTextField> {
  // We now store the full Country object, not just the code string.
  Country? _selectedCountry;

  // The country list is no longer defined here. It's imported.

  @override
  void initState() {
    super.initState();

    // Set the initial country to Kenya, or the first in the list as a fallback.
    // This uses the global 'allSupportedCountries' list.
    var initialCountry = allSupportedCountries.firstWhere(
      (country) => country.name == 'Kenya',
      orElse: () => allSupportedCountries.first,
    );

    // Set the initial state using the full object.
    setState(() {
      _selectedCountry = initialCountry;
    });

    // Update the parent controllers with the initial values.
    widget.countryNameController.text = initialCountry.name;

    // Pre-fill the phone number controller with the country code if it's empty.
    if (widget.controller.text.isEmpty) {
      widget.controller.text = initialCountry.code;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<Country>> dropdownItems =
        allSupportedCountries.map((country) {
          return DropdownMenuItem<Country>(
            value: country,
            child: Row(
              children: [
                Text(
                  country.isoCode!.toCountryFlag(),
                  style: const TextStyle(fontSize: 17),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    country.name,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      color: AppColors.textPrimaryBlack,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList();

    return Container(
      width: 380,
      decoration: BoxDecoration(
        color: AppColors.cardDark.withOpacity(0.02),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.borderMuted, width: 1),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 3, // Give more space to the country dropdown
              child: DropdownButtonHideUnderline(
                child: DropdownButtonFormField<Country>(
                  value: _selectedCountry,
                  items: dropdownItems,
                  onChanged: (Country? newCountry) {
                    if (newCountry != null) {
                      setState(() {
                        _selectedCountry = newCountry;
                        widget.countryNameController.text = newCountry.name;
                        String nationalPart = '';
                        String currentPhoneText = widget.controller.text;
                        if (currentPhoneText.isNotEmpty) {
                          bool knownPrefixStripped = false;
                          // Use the global list to check for any existing prefix
                          for (var countryData in allSupportedCountries) {
                            if (currentPhoneText.startsWith(countryData.code)) {
                              nationalPart = currentPhoneText.substring(
                                countryData.code.length,
                              );
                              knownPrefixStripped = true;
                              break;
                            }
                          }
                          if (!knownPrefixStripped) {
                            nationalPart = currentPhoneText;
                          }
                        }
                        nationalPart = nationalPart.replaceAll(
                          RegExp(r'[^0-9]'),
                          '',
                        );
                        widget.controller.text = newCountry.code + nationalPart;
                        widget
                            .controller
                            .selection = TextSelection.fromPosition(
                          TextPosition(offset: widget.controller.text.length),
                        );
                      });
                    }
                  },
                  isExpanded: true,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 18,
                      horizontal: 10,
                    ),
                  ),
                  dropdownColor: AppColors.backgroundCream,
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: AppColors.textSecondaryBlack,
                  ),
                ),
              ),
            ),
            const VerticalDivider(
              width: 1,
              thickness: 1,
              color: AppColors.borderDark,
            ),
            Expanded(
              flex: 6, // Give slightly more space to the number input
              child: TextFormField(
                controller: widget.controller,
                validator:
                    (value) =>
                        Validators.phone(value, _selectedCountry?.code ?? ''),
                keyboardType: TextInputType.phone,
                style: GoogleFonts.poppins(
                  color: AppColors.textPrimaryBlack,
                  fontSize: 16,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Phone number",
                  hintStyle: GoogleFonts.poppins(
                    color: AppColors.textSecondaryBlack,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 18,
                    horizontal: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// An extension to convert a 2-letter ISO code to a flag emoji
extension on String {
  String toCountryFlag() {
    if (isEmpty) return '';
    return toUpperCase()
        .split('')
        .map((char) => String.fromCharCode(char.codeUnitAt(0) + 127397))
        .join();
  }
}

class HomeHeader extends StatelessWidget {
  final String text1;
  final String text2;

  const HomeHeader({super.key, required this.text1, required this.text2});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Column(
        children: [
          Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text1,
                style: GoogleFonts.poppins(
                  fontSize: 25,
                  color: AppColors.textPrimaryBlack,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 05),
              Text(
                text2,
                style: GoogleFonts.poppins(color: AppColors.textSecondaryBlack),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
