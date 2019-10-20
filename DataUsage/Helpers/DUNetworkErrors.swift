//
//  DUNetworkErrors.swift
//  DataUsage
//
//  Created by Suri,Sai Sailesh Kumar on 20/10/19.
//  Copyright © 2019 Sailesh. All rights reserved.
//

import Foundation

public struct DUNetWorkErrors {
    
    var validStatusCodes: IndexSet = {
        let range = 200..<228
        var codes = IndexSet(integersIn: range)
        codes.insert(304)
        return codes
    }()
        
    /// checks for the valid status of code
    ///
    /// - Parameter statusCode: status code
    /// - Returns: value status true or false
    func checkValidStatusCode(statusCode: Int) -> Bool {
        return self.validStatusCodes.contains(statusCode)
    }
    /// Get Error Title
    ///
    /// - Parameter statusCode: Status code
    /// - Returns: error Titile
    func errorTitle(statusCode: Int) -> String {
        var errorTitle = ""
        switch statusCode {
        case 400...417:
            errorTitle = self.clientErrorTitle(statusCode: statusCode)
        case 500...505:
            errorTitle = self.serverErrorTitle(statusCode: statusCode)
        default:
            errorTitle = ""
        }
        return errorTitle
    }
    
    /// Get Error Message
    ///
    /// - Parameter statusCode: Statuscode
    /// - Returns: error message
    func errorMessage(statusCode: Int) -> String {
        var errorMessage = ""
        switch statusCode {
        case 400...417:
            errorMessage = self.clientErrorMessage(statusCode: statusCode)
        case 500...505:
            errorMessage = self.serverErrorMessage(statusCode: statusCode)
        default:
            errorMessage = ""
        }
        return errorMessage
    }
    
    /// Client Error Title
    ///
    /// - Parameter statusCode: Statuscode
    /// - Returns: error Title
    private func clientErrorTitle(statusCode: Int) -> String {
        var errorTitle = ""
        switch statusCode {
        case 400:
            errorTitle = "Bad Request"
        case 401:
            errorTitle = "Unauthorized"
        case 403:
            errorTitle = "Forbidden"
        case 404:
            errorTitle = "Not Found"
        case 408:
            errorTitle = "Request Timeout "
        case 417:
            errorTitle = "Expectation Failed"
        default :
            errorTitle = ""
        }
        return errorTitle
    }
    
    /// Server Error Title
    ///
    /// - Parameter statusCode: Statuscode
    /// - Returns: error title
    private func serverErrorTitle(statusCode: Int) -> String {
        var errorTitle = ""
        switch statusCode {
        case 500:
            errorTitle = "Internal Server Error"
        case 501:
            errorTitle = "Not Implemented"
        case 502:
            errorTitle = "Bad Gateway"
        case 503:
            errorTitle = "Service Unavailable"
        case 504:
            errorTitle = "Gateway Timeout"
        case 505:
            errorTitle = "HTTP Version Not Supported "
        default :
            errorTitle = ""
        }
        return errorTitle
    }
    
    /// Client Error Message
    ///
    /// - Parameter statusCode: Statuscode
    /// - Returns: client error message
    private func clientErrorMessage(statusCode: Int) -> String {
        var errorMessage = ""
        switch statusCode {
        case 400:
            errorMessage = "The server did not understand the request."
        case 401:
            errorMessage = "The requested page needs a username and a password."
        case 403:
            errorMessage = "Access is forbidden to the requested page."
        case 404:
            errorMessage = "The server can not find the requested page."
        case 408:
            errorMessage = "The request took longer than the server was prepared to wait."
        case 417:
            errorMessage = "The expectation given in an Expect request-header field could not be met by this server."
        default :
            errorMessage = ""
        }
        
        return errorMessage
    }
    
    /// Server Error Message
    ///
    /// - Parameter statusCode: Statuscode
    /// - Returns: server error message
    private func serverErrorMessage(statusCode: Int) -> String {
        var errorMessage = ""
        
        switch statusCode {
        case 501:
            errorMessage = "The request was not completed. The server did not support the functionality required."
        case 502:
            errorMessage = "The request was not completed. The server received an invalid response from the upstream server."
        case 503:
            errorMessage = "The request was not completed. The server is temporarily overloading or down."
        case 504:
            errorMessage = "The gateway has timed out."
        case 505:
            errorMessage = "The server does not support the \"http protocol\" version."
        default:
            errorMessage = ""
        }
        return errorMessage
    }
}
