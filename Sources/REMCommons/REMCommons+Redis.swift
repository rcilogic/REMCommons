//
//  Created by Konstantin Gorshkov on 02.08.2022
//  Copyright (c) 2022 Konstantin Gorshkov. All Rights Reserved
//  See LICENSE.txt for license information
//
//  SPDX-License-Identifier: Apache-2.0
//


import Vapor
import Redis

public extension REMCommons {
    static func getRedisConfiguration() throws -> RedisConfiguration  {
        return try RedisConfiguration(
            hostname: Environment.get(.redisHost) ?? "localhost",
            port: Environment.get(.redisPort).flatMap{ Int.init($0) } ?? RedisConnection.Configuration.defaultPort,
            password: Environment.get(.redisPassword),
            pool: .init(connectionRetryTimeout: .seconds(5))
        )
    }
    
    
}
