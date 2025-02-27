/*
 *  This file is part of BoxBox (https://github.com/BrightDV/BoxBox).
 * 
 * BoxBox is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * BoxBox is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with BoxBox.  If not, see <http://www.gnu.org/licenses/>.
 * 
 * Copyright (c) 2022-2023, BrightDV
 */

import 'package:boxbox/helpers/loading_indicator_util.dart';
import 'package:boxbox/helpers/request_error.dart';
import 'package:boxbox/scraping/formula_one.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HallOfFameScreen extends StatelessWidget {
  const HallOfFameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool useDarkMode =
        Hive.box('settings').get('darkMode', defaultValue: true) as bool;
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.hallOfFame),
      ),
      backgroundColor: useDarkMode
          ? Theme.of(context).scaffoldBackgroundColor
          : Colors.white,
      body: FutureBuilder<List<HallOfFameDriver>>(
        future: FormulaOneScraper().scrapeHallOfFame(),
        builder: (context, snapshot) => snapshot.hasError
            ? RequestErrorWidget(
                snapshot.error.toString(),
              )
            : snapshot.hasData
                ? ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HallOfFameDriverDetailsScreen(
                            snapshot.data![index].detailsPageUrl,
                            snapshot.data![index].driverName,
                          ),
                        ),
                      ),
                      child: Card(
                        elevation: 10.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        color: useDarkMode
                            ? const Color(0xff1d1d28)
                            : Colors.white,
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(15.0),
                                topRight: Radius.circular(15.0),
                              ),
                              child: Image(
                                image: NetworkImage(
                                  snapshot.data![index].imageUrl,
                                ),
                              ),
                            ),
                            ListTile(
                              title: Text(
                                snapshot.data![index].driverName,
                                style: TextStyle(
                                  color:
                                      useDarkMode ? Colors.white : Colors.black,
                                ),
                              ),
                              subtitle: Text(
                                snapshot.data![index].years,
                                style: TextStyle(
                                  color:
                                      useDarkMode ? Colors.white : Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : const LoadingIndicatorUtil(),
      ),
    );
  }
}

class HallOfFameDriverDetailsScreen extends StatelessWidget {
  final String pageUrl;
  final String driverName;
  const HallOfFameDriverDetailsScreen(this.pageUrl, this.driverName, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool useDarkMode =
        Hive.box('settings').get('darkMode', defaultValue: true) as bool;
    return Scaffold(
      appBar: AppBar(
        title: Text(driverName),
      ),
      backgroundColor: useDarkMode
          ? Theme.of(context).scaffoldBackgroundColor
          : Colors.white,
      body: FutureBuilder<Map>(
        future: FormulaOneScraper().scrapeHallOfFameDriverDetails(pageUrl),
        builder: (context, snapshot) => snapshot.hasError
            ? RequestErrorWidget(
                snapshot.error.toString(),
              )
            : snapshot.hasData
                ? SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: [
                          Text(
                            driverName,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: useDarkMode ? Colors.white : Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 10,
                            ),
                            child: Image(
                              image: NetworkImage(
                                'https://www.formula1.com/content/fom-website/en/drivers/hall-of-fame/${driverName.replaceAll(' ', '_')}/jcr:content/featureContent/manual_gallery/image1.img.1920.medium.jpg/1421331223448.jpg',
                              ),
                            ),
                          ),
                          Text(
                            snapshot.data!['metaDescription'],
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              color: useDarkMode ? Colors.white : Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          for (String textParagraph in snapshot.data!['parts'])
                            Text(
                              textParagraph,
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                color:
                                    useDarkMode ? Colors.white : Colors.black,
                                fontSize: 14,
                              ),
                            ),
                        ],
                      ),
                    ),
                  )
                : const LoadingIndicatorUtil(),
      ),
    );
  }
}
