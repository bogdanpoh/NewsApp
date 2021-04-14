//
//  Logger.ConsoleOutput.swift
//  NewsApp
//
//  Created by Bogdan Pohidnya on 02.04.2021.
//

import Foundation

extension Logger {

    final class ConsoleOutput: LogOutput {

        func log(level: Level, message: @autoclosure () -> String) {
            #if DEBUG
                let threadName = Thread.current.isMainThread ?  "[main]" : "[background]"
            print(level.icon, Date.now.formattedNow, "thread: \(threadName)")
                print(message())
            #endif
        }

    }

}

private extension Date {

    var formattedNow: String {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let today = Date()
        return df.string(from: today)
    }

}
