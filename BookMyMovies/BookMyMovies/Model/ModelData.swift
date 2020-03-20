//
//  ModelData.swift
//  BookMyMovies
//
//  Created by Yamini Koli on 18/03/20.
//  Copyright © 2020 Yamini Koli. All rights reserved.
//

import UIKit

class ModelData: NSObject {
    static let shared: ModelData = ModelData()
    var Title:[String] = []
    var Image:[String] = []
    var Rating:[Double] = []
    var ReleaseDate:[String] = []
}
