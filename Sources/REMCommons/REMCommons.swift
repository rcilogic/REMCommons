//
//  Created by Konstantin Gorshkov on 16.06.2022
//  Copyright (c) 2022 Konstantin Gorshkov. All Rights Reserved
//  See LICENSE.txt for license information
//
//  SPDX-License-Identifier: Apache-2.0
//


import Vapor

public struct REMCommons {
    public static var sessionCookieName = "__HOST-rem_session"
    public static var sessionKeyPrefix = "session:"
    
}

extension Response {
    
    public func setErrorCookie (error: HTTPResponseStatus, description: String?) {
        self.cookies["rem_error_code"] = remErrorCookie(String(error.code).base64String())
        self.cookies["rem_error_text"] = remErrorCookie(error.reasonPhrase.base64String())
        
        if let description = description {
            self.cookies["rem_error_description"] = remErrorCookie(description.base64String())
        }
        
    }
    
    internal func remErrorCookie (_ value: String) -> HTTPCookies.Value {
        HTTPCookies.Value (
            string: value,
            maxAge: 60,
            isHTTPOnly: false,
            sameSite: HTTPCookies.SameSitePolicy.none
        )
    }
    
}
