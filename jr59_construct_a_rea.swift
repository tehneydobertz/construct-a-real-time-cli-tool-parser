```Swift
import Foundation

// Define parser enum with possible states
enum ParserState {
    case idle
    case parsingArgument
    case parsingOption
}

// CLI tool parser class
class CLIAParser {
    var currentState: ParserState = .idle
    var argument: String = ""
    var options: [String: String] = [:]

    // Function to parse CLI arguments
    func parse(_ input: String?) {
        guard let input = input else { return }
        let parts = input.components(separatedBy: " ")
        
        for part in parts {
            switch currentState {
            case .idle:
                if part.hasPrefix("-") {
                    // Starting to parse an option
                    self.currentState = .parsingOption
                    self.argument = part.replacingOccurrences(of: "-", with: "")
                } else {
                    // Starting to parse an argument
                    self.currentState = .parsingArgument
                    self.argument = part
                }
            case .parsingArgument:
                // Parsing an argument, simply store it
                if !part.hasPrefix("-") {
                    print("Parsed argument: \(part)")
                    self.argument = ""
                } else {
                    self.argument = part.replacingOccurrences(of: "-", with: "")
                }
            case .parsingOption:
                // Parsing an option, store value if provided
                if part.hasPrefix("-") {
                    let key = part.replacingOccurrences(of: "-", with: "")
                    print("Parsed option: \(key)")
                } else {
                    self.options[self.argument] = part
                    self.argument = ""
                    print("Parsed option value: \(part)")
                }
            }
        }
    }
}

// Test case
func main() {
    let parser = CLIAParser()
    let input = "arg1 -o value1 arg2 -o value2 -t flag"
    print("Input: \(input)")
    parser.parse(input)
}

main()