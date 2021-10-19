import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart';
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:teoria_dos_jogos/app_localizations.dart';
import 'package:teoria_dos_jogos/public_goods/classes/publicGoodsVariables.dart';
import 'package:teoria_dos_jogos/public_goods/store/round_data_store.dart';

class Excelfile {
  var excel = Excel.createExcel();
  var context;
  Excelfile(this.context);

  createSheetPublicGoods(
      List<RoundData> gameRounds, PublicGoodsVariables goodsVariables) {
    Sheet sheetObject =
        excel[AppLocalizations.of(context).translate('publicGoods')];

    List<String> dataList = [
      "Rodada",
      "Fator",
      "Carteira",
      "Contribuição",
      "Posição da Ficha",
      "earning",
      "Rib",
      "distribuição",
      "eleição",
      "suspenso"
    ]; //, "J1","J2","J3","J4","J5"];
    for (int i = 0; i < goodsVariables.notRealPlayers; i++) {
      dataList.add("J" + (i + 1).toString());
    }

    sheetObject.insertRowIterables(dataList, 0);

    gameRounds.forEach((element) {
      List<String> rowList = [];

      rowList.add(element.id.toString());
      rowList.add(goodsVariables.factor.toString());
      rowList.add(element.wallet.toString());
      rowList.add(element.investment.toString());
      rowList.add(element.positionToken.toString());
      rowList.add(element.earning.toString());
      rowList.add(element.rib.toString());
      rowList.add(element.distribution.toString());
      rowList.add(element.electionCount.toString());
      rowList.add(element.suspended.toString());

      for (int i = 0; i < goodsVariables.notRealPlayers; i++) {
        rowList.add(element.playersInvestiment![i].toString());
      }
      sheetObject.insertRowIterables(rowList, gameRounds.indexOf(element) + 1);
    });
    excel
        .setDefaultSheet(AppLocalizations.of(context).translate('publicGoods'));
    saveExcel(AppLocalizations.of(context).translate('publicGoods'));
  }

  saveExcel(String name) async {
    final dir = await getExternalStorageDirectory();
    print("Directoryyyyyyyyy:${dir!.path}");
    final String path = dir.path + "/" + name + ".xlsx";

    excel.encode();
    /*.then((onValue) {
        File(join(path))
        ..createSync(recursive: true)
        ..writeAsBytesSync(onValue);
    });*/
    await OpenFile.open(path,
        type:
            "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
  }
}
