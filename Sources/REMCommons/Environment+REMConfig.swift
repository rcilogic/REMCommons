//
//  Created by Konstantin Gorshkov on 16.06.2022
//  Copyright (c) 2022 Konstantin Gorshkov. All Rights Reserved
//  See LICENSE.txt for license information
//
//  SPDX-License-Identifier: Apache-2.0
//


import Vapor

public extension Environment {
    
    static func get (_ key: REMCommonEnvKey) -> String? { Self.get(key.rawValue) }
    
    enum REMCommonEnvKey: String {
        case redisHost = "REM_COMMONS_REDIS_HOST"
        case redisPort = "REM_COMMONS_REDIS_PORT"
        case redisUsername = "REM_COMMONS_REDIS_USERNAME"
        case redisPassword = "REM_COMMONS_REDIS_PASSWORD"
    }
    
}
