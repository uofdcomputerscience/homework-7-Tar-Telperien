import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

// For this homework project, we'll be connecting to the "TLDR" server
// to add a few books. The first thing you need to do is create an object
// that we'll upload to the server.

// MARK: - STEP ONE

// Implement a struct that defines a book. A book consists of the following
// items:
// A title, which is a string
// An author, which is a string
// The publication year, as a string (because dates are hard)
// A string for the URL for an image for the book cover
//
// Remember that this structure needs to conform to the `Encodable` protocol.
// Using `Codable` more generally will be useful, as by doing this you'll
// be able to reuse this struct in Project Three.

struct Book: Codable {
    var title: String
    var author: String
    var pubYear: String
    var coverURL: String
}

// MARK: - STEP TWO

// Once you've defined this structure, you'll need to define a couple of
// book objects that you can insert into the database. In order or us to
// have an amusing dataset to work with, each student is requested to
// create five different books for this database.

let fellowship = Book(title: "The Fellowship of the Ring", author: "JRR Tolkien", pubYear: "29 July 1954", coverURL: "https://vignette.wikia.nocookie.net/lotr/images/6/64/The_Fellowship_of_the_Ring_1st_edition_cover.jpg/revision/latest?cb=20190917135720")

let towers = Book(title: "The Two Towers", author: "JRR Tolkien", pubYear: "11 November 1054", coverURL: "https://vignette.wikia.nocookie.net/lotr/images/9/9b/The_Two_Towers_1st_edition_cover.jpg/revision/latest/scale-to-width-down/682?cb=20190917134803")

let king = Book(title: "The Return of the King", author: "JRR Tolkien", pubYear: "20 November 1955", coverURL: "https://vignette.wikia.nocookie.net/lotr/images/0/03/The_Return_of_the_King_1st_edition_cover.jpg/revision/latest?cb=20190917140338")

let silmarillion = Book(title: "The Silmarillion", author: "JRR Tolkien", pubYear: "15 September 1977", coverURL: "https://vignette.wikia.nocookie.net/lotr/images/5/50/Silmarillion.jpg/revision/latest?cb=20180303011040")

let gondolin = Book(title: "The Fall of Gondolin", author: "JRR Tolkien", pubYear: "30 August 2018", coverURL: "https://vignette.wikia.nocookie.net/lotr/images/7/72/TheFallofGondolin.png/revision/latest/scale-to-width-down/664?cb=20180414125100")

let booklist = [fellowship, towers, king, silmarillion, gondolin]

// MARK: - STEP THREE

// Now we need to publish this data to the server.

// Create a URL to connect to the server. Its address is:
//      https://uofd-tldrserver-develop.vapor.cloud/books

let urlString = "https://uofd-tldrserver-develop.vapor.cloud/books"
let url = URL(string: urlString)!

// Create a URL request to publish the information, based upon the URL you
// just created.

//var request = URLRequest(url: url)

// Add the body to the URL request you just created, by using JSONEncoder.

//this is where I get slightly stuck. How can you add to the body, and not just replace it every time you loop?
//request.httpBody = try? JSONEncoder().encode(fellowship)

// Add a "Content-Type" : "application/json" header to your request, so that
// the server will properly understand the body of your request.

//request.addValue("application/json", forHTTPHeaderField: "Content-Type")

// Set the method of the request to "POST", because we're providing information
// rather than retrieving it.

//request.httpMethod = "POST"

// Create a data task for publishing this element, and kick it off with a resume().

//let task = URLSession(configuration: .ephemeral).dataTask(with: request)
//task.resume()

// MARK: - HELPFUL HINTS
// You might want to create a method for publishing the data, so that you
// can effectively loop over an array of books.
//
// If you visit the URL for the service in a 'GET' request, it will return a
// list of books to you. We'll be using this list of books for Project Three.

func publishData(url: URL, book: Book) {
    var request = URLRequest(url: url)
    request.httpBody = try? JSONEncoder().encode(book)
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpMethod = "POST"
    let task = URLSession(configuration: .ephemeral).dataTask(with: request)
    task.resume()
}

for book in booklist {
    publishData(url: url, book: book)
}
