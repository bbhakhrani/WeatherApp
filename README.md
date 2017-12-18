Goal:
  Using this open weather api - https://openweathermap.org/api

  1. Initial screen should display the current weather in your city (using iOS location services)
  2. The user should have the option to select a different city from a picker view
    -The new city selected should be persisted even if the app is killed and restarted
    -The user should have an option to go back to using their location to determine the weather on the home screen
  3. Button to see the 5 and 16 day forecasts separately in a new screen
    -Forecasts should be shown in a list (table view) displaying the day, the weather info for that day and the appropriate weather icon
  4. The UI should function for any size device (autolayout)

Accomplished:
  I was able to complete a good portion of the given requirements, Although there are some bugs.
  
  1. The data shows on the inital scree although it takes a few seconds to load. 
  2. the use can select a different city
      -the data for that city loads if the switch is off. This has some issues in the display
      -if the switch is turned back on, the data for the current location is loaded. this has some issues with displaying
      -the data is reset when the app closes. I know I wold need to work with NSUserDefaults to get it working,
          but I didnt get a chance to work on that
  3. I added a tab for the 5 day forecast. The 16 day data is restrincted for paid member, so I did not add ascreen for that  
        although the process would be quite similar to that used in the 5 day forecast
  4. The UI seemed to resize fine based on my limited testing on the simulator. There was an issue I couldn't fix 
        where the top of the view goes under the header at that top of the screen
    
