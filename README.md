# GitHub-List
# About The Project
The project provides an opportunity to get a list of repositories according to the filter: current day, last week, and last month. Repositories can be added to favorites, viewed, and removed from the favorites list. A search is implemented for each of the filters. A search is executed for each of the filters.

## Project goal
- Show skill in the use of architectural approaches.
- Show knowledge and ability to use third-party libraries.
- Keep the code clean SOLID, DRY, KISS.
- Show the ability to quickly and accurately write code.

## Architectural solutions
Take the patented model-view-presenter as the basis. Navigation through the application implemented with the help of the coordinator paternoster. MVP has several advantages such as fast implementation in the project, easy to read, responsibility is distributed between the model and the presenter. 

## Technical solutions
- For calls to the server Alamofire is used as it is quite a popular library so stable and easy to use
- The Realm library is used to store data, it is quick to implement and fast to work. It is also popular with developers.
- The popular Kingfisher library is used to work with images. Allows you to cache images.

## Optimization - potential improvements
- It is better to make requests to the server asynchronous (async await)
- When working with the Realm database, you should always keep an eye on the threads. @MainActor async functions.

## Additionally
Сan use SwiftLint to organize your code in a cleaner
