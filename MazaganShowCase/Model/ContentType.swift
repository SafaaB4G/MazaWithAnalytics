//
//  ContentType.swift
//  MazaganShowCase
//
//  Created by Nabil Alaoui on 2/11/17.
//  Copyright © 2017 B4E. All rights reserved.
//

import UIKit
import Foundation

enum ContentType: String {
    case Music = "content_music"
    case Films = "content_films"
}

prefix func ! (value: ContentType) -> ContentType {
    switch value {
    case .Music:
        return .Films
    case .Films:
        return .Music
    }
}
