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

class ScheduleLands {
  final Map<String, String> lands = {
    "Australia": "Australie",
    "Bahrain": "Bahrain",
    "Italy": "Italie",
    "Portugal": "Portugal",
    "United States": "États-Unis",
    "Canada": "Canada",
    "Spain": "Espagne",
    "Monaco": "Monaco",
    "Azerbaijan": "Azerbaïdjan",
    "France": "France",
    "Austria": "Autriche",
    "UK": "Grande-Bretagne",
    "Hungary": "Hongrie",
    "Belgium": "Belgique",
    "Netherlands": "Pays-Bas",
    "Russia": "Russie",
    "Turkey": "Turquie",
    "Singapore": "Singapour",
    "Japan": "Japon",
    "USA": "États-Unis",
    "Mexico": "Mexique",
    "Brazil": "Brésil",
    "Qatar": "Quatar",
    "Saudi Arabia": "Arabie Saoudite",
    "UAE": "Émirats Arabes Unis",
  };
  String getLandName(String oldName) {
    String newName = lands[oldName]!;
    return newName;
  }
}
