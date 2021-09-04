## Weather app with an iconographic charts 

<img src="https://github.com/iosolonevich/ForecastLine/blob/main/ForecastLine/Support/images/main.jpeg" width="250" /><img src="https://github.com/iosolonevich/ForecastLine/blob/main/ForecastLine/Support/images/locations.jpeg" width="250" /><img src="https://github.com/iosolonevich/ForecastLine/blob/main/ForecastLine/Support/images/addlocation.jpeg" width="250" />

* MVVM architecture
* Clean Architecture principles, SOLID principles
* Dependency Injection design pattern
* no storyboards, all UI is done programmatically
* no 3rd party pods (no Alamofire or Charts)

### Work in progress

- [x] main screen with a location list
    - [ ] scrollable chart view for daily/hourly forecast
    - [x] detailed info for current weather
    - [ ] togle button for hourly/daily forecast

- [x] location screen
    - [x] search screen with autocomplete location suggestions
    - [ ] current location option (using a current GPS position)

- [x] settings screen
    - [x] privacy policy
    - [ ] app settings like units switch/dark mode etc.

- [ ] widgets using WidgetKit
- [ ] Apple Watch app using WatchKit
