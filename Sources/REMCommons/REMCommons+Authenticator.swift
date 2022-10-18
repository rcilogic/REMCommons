//
//  Created by Konstantin Gorshkov on 16.06.2022
//  Copyright (c) 2022 Konstantin Gorshkov. All Rights Reserved
//  See LICENSE.txt for license information
//
//  SPDX-License-Identifier: Apache-2.0
//


import Vapor
import Redis

extension REMCommons {
    
    public struct User: Authenticatable, Content {
        public var name: String
        public var displayName: String
        public var email: String
        public var groups: [String]
        
        public static var key = "USER_INFO"
        
        public init (name: String, displayName: String, email: String, groups: [String]) {
            self.name = name
            self.displayName = displayName
            self.email = email
            self.groups = groups
        }
        
        internal func isAuthorizedWithGroupFilter (_ groupFilter: String?) -> Bool {
            guard let groupFilter = groupFilter else {return true}
            if self.groups.contains(where: {$0.caseInsensitiveCompare(groupFilter) == .orderedSame}) {
                return true
            } else {
                return false
            }
        }
    }

    public struct AuthenticatorBearer: AsyncBearerAuthenticator {
        public typealias User = REMCommons.User
        
        public let group: String?
        
        public init (group: String? = nil) {
            self.group = group
        }
        
        public func authenticate(bearer: BearerAuthorization, for request: Request) async throws {
            let sessionKey: RedisKey = "\(REMCommons.sessionKeyPrefix)\(bearer.token)"
            if let sessionData = try await request.redis.get(sessionKey, asJSON: SessionData.self),
               let userData = sessionData[User.key]?.data(using: .utf8),
               let user = try? JSONDecoder().decode(User.self, from: userData)
            {
                if user.isAuthorizedWithGroupFilter(group) {
                    request.auth.login(user)
                } else {
                    throw Abort(.forbidden)
                }
            }
        }
    }

    public struct AuthenticatorSession: AsyncMiddleware {
        public typealias User = REMCommons.User
        
        public let group: String?
        
        public init (group: String? = nil) {
            self.group = group
        }
        
        public func respond(to request: Request, chainingTo next: AsyncResponder) async throws -> Response {
            if let userData = request.session.data[User.key]?.data(using: .utf8),
               let user = try? JSONDecoder().decode(User.self,from: userData)
            {
                if user.isAuthorizedWithGroupFilter(group) {
                    request.auth.login(user)
                } else {
                    throw Abort(.forbidden)
                }
            }
            
            return try await next.respond(to: request)
        }
    }
    
}
