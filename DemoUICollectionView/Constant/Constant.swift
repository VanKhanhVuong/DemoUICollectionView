//
//  Constant.swift
//  DemoUICollectionView
//
//  Created by admin on 24/03/2022.
//

import Foundation

let baseUrlNews: String = "https://newsapi.org/v2/everything?"
let baseUrlWeather: String = "https://api.openweathermap.org/data/2.5/weather?"

let apiKeyNews: String = "d9f5d5ed4a84439d970ca1c7d8c9135d"
let apiKeyWeather: String = "e2232f667c7658ccdcd6e08226497583"


let textDisconnet = "Internet Connection not Available!"
let homeTitle = "Home"
let detailTilte = "Detail"
let whiteSpaces = ""

let date = Date()
let calendar = Calendar.current
let day = calendar.component(.day, from: date)
let month = calendar.component(.month, from: date) - 01
let year = calendar.component(.year, from: date)

