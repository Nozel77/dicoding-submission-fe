import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// color
const Color primaryColor = Color(0xFF14131b);
const Color primaryText = Color(0xFFFFFFFF);
const Color bgForm = Color(0xFF25212F);
const Color bgButton = Color(0xFF6A69F3);
const Color textGrey = Color(0xFF7E7D83);
const Color disable = Color(0xFFB0B0B0);

// text style
TextStyle tsTitleRegularWhite = GoogleFonts.poppins(
  color: primaryText,
  fontWeight: FontWeight.w400,
  fontSize: 32,
);

TextStyle tsSubtitleRegularWhite = GoogleFonts.poppins(
  color: primaryText,
  fontWeight: FontWeight.w400,
  fontSize: 20
);

TextStyle tsTextRegularWhite = GoogleFonts.poppins(
  color: primaryText,
  fontWeight: FontWeight.w400,
  fontSize: 12
);

TextStyle tsTextFormRegularWhite = GoogleFonts.poppins(
    color: primaryText,
    fontWeight: FontWeight.w400,
    fontSize: 16
);

TextStyle tsTextRegularPurple = GoogleFonts.poppins(
    color: bgButton,
    fontWeight: FontWeight.w400,
    fontSize: 12
);

TextStyle tsTextMediumGrey = GoogleFonts.poppins(
    color: textGrey,
    fontWeight: FontWeight.w400,
    fontSize: 12
);

TextStyle tsTextMediumWhite = GoogleFonts.poppins(
    color: primaryText,
    fontWeight: FontWeight.w400,
    fontSize: 12
);

TextStyle tsTextSemiBoldWhite = GoogleFonts.poppins(
    color: primaryText,
    fontWeight: FontWeight.w600,
    fontSize: 16
);

TextStyle tsTextSemiBoldWhite20 = GoogleFonts.poppins(
    color: primaryText,
    fontWeight: FontWeight.w600,
    fontSize: 20
);

TextStyle tsBoldPurple = GoogleFonts.poppins(
    color: bgButton,
    fontWeight: FontWeight.w700,
    fontSize: 20
);

TextStyle tsBoldWhite = GoogleFonts.poppins(
    color: primaryText,
    fontWeight: FontWeight.w700,
    fontSize: 20
);