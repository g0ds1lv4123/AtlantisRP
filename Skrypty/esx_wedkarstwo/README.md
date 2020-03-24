# fxserver-esx_fishing

FXServer ESX FISHING

**INSTALLATION**

1) Copy the files to your resources/[esx] folder

```
2) Import esx_fishing.sql in your database
```

3) Add this in your server.cfg :

```
start esx_fishing
```


**USAGE**

1)FISHING: The "fishing zone" has been placed at Del Perro Pier, once you walk to the marker and press "E" to start fishing
you will see a bar at the top of the screen. As the bar fills red it will turn green when full, press "Enter" when 
the bar turns green. Success is generated randomly, so you have to keep pressing it at the right time to try to 
catch a fish. 

2)AFTER CATCH: After you have successfully caught a fish, you can choose to Eat the fish to restore some of your hunger or
you can sell the fish to the resturaunt on Del Perro Pier for money.

3)FISHING LICENSE: A fishing license item is added to your items list along with the fish. This license is placed in the shops for a 1 time cost of $2,500.
When using your inventory you will see the license as a usable item, when the "USE" option is selected, a message will populate the game chat stating 
"VALID 2018 Florida Sportsmans License", you can change what it says in client/main.lua line 109. The license has a removal rate of "0" so it can be used 
and it doesn't leave the users inventory.

**TODO**

1)I am currently working on adding more location options and trying to add bait as an additional usable item and a requirement for fishing.



**ADDITIONAL NOTES**	

I did not create this script from scratch, thru searching the FiveM forums and Google, I found a variety of fishing scripts and used bits and pieces from them 
along with the custom stuff I added to create this. If you have any comments, suggestions or ideas to make it better, please feel free to share!