//
//  Created by Konstantin Gorshkov on 02.08.2022
//  Copyright (c) 2022 Konstantin Gorshkov. All Rights Reserved
//  See LICENSE.txt for license information
//
//  SPDX-License-Identifier: Apache-2.0
//


import Foundation

public extension REMCommons {
    static func loadJSON<T: Decodable> (from path: String, as type: T.Type) throws -> T {
        let fileContent = try String(contentsOfFile: path)
        guard let fileData = fileContent.data(using: .utf8) else { throw JSONLoadError.unableToDecodeFileUsingUTF8 }
        return try JSONDecoder().decode(type, from: fileData)
    }

    enum JSONLoadError: Error {
        case unableToDecodeFileUsingUTF8
    }
    
}
