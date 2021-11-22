import 'package:flutter/material.dart';
import 'package:teoria_dos_jogos/app_localizations.dart';
import 'package:teoria_dos_jogos/classes/resize.dart';
import 'package:teoria_dos_jogos/prisoners_dilemma/classes/dilemmaVariables.dart';
import 'package:teoria_dos_jogos/prisoners_dilemma/widgets/dilemmaCard.dart';
import 'package:teoria_dos_jogos/prisoners_dilemma/widgets/resultsMatrix.dart';

class MatrixExample extends StatelessWidget {
  DilemmaVariables variables;

  MatrixExample(this.variables);
  @override
  Widget build(BuildContext context) {
    double fontSize = Resize.getHeight(context) / 18;
    double width = MediaQuery.of(context).size.aspectRatio * 150;
    double screenH = Resize.getHeight(context);
    double p = 0.4;
    p = MediaQuery.of(context).size.aspectRatio > 2.0 ? p / 2 : p;
    double longestSide = MediaQuery.of(context).size.longestSide;
    double fontsize = Resize.getWidth(context) * 0.02;
    // longestSide == width ? longestSide * 0.02 : longestSide * 0.04;
    List<MatrixCase> cases = [
      MatrixCase(Colors.red, Colors.red, "dMatrixResult1"),
      MatrixCase(Colors.black, Colors.black, "dMatrixResult2"),
      MatrixCase(Colors.black, Colors.red, "dMatrixResult3"),
      MatrixCase(Colors.red, Colors.black, "dMatrixResult4"),
    ];
    if (true)
      return
          //  ResultsMatrix(p, "", false,variables);
          Container(
              margin: EdgeInsets.symmetric(horizontal: width * 0.4),
              child: Row(children: [
                Text(
                  AppLocalizations.of(context).translate('summarize'),
                  style: TextStyle(fontSize: fontsize),
                ),
                Expanded(flex: 1, child: ResultsMatrix(p, "", false, variables))
              ]));
    else
      return Container(
          margin: EdgeInsets.only(bottom: screenH / 10),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: cases.map((c) {
                return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      DilemmaCard(
                        color: c.you,
                        proportion: p,
                      ),
                      Icon(
                        Icons.add,
                        color: Colors.blueAccent,
                        size: fontSize * 3,
                      ),
                      DilemmaCard(color: c.other, proportion: p),
                      Text("=",
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: fontSize * 3)),
                      Container(
                        width: width,
                        child: Text(
                          AppLocalizations.of(context).translate(c.result),
                          style: TextStyle(fontSize: fontSize),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ]);
              }).toList()));
  }
}

class MatrixCase {
  Color you;
  Color other;
  String result;
  MatrixCase(this.you, this.other, this.result);
}
