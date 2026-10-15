# closet
A simple WoW: Classic addon to create and delete equipment sets.

Usage:

* `/saveset name` - Overwrites the equipment set named "name" with all equipment currently worn, or creates a set if one doesn't yet exist
* `/deleteset name` or `delset name` - Deletes the equipment set "name" if it exists
* `/listsets` - Lists all currently saved sets for the current character:  

  ![image](https://github.com/RabbleCode/closet/assets/56865013/1a9d56d6-2f66-485d-8ab4-317f08d1cce9)

* `/equipset name` - Equips items from the previously saved set named "name"

Notes:

Classic Era WoW API supports the Blizzard equipment manager functionality and the `/equipset` macro command, but the UI options for creating and modifying sets are disabled.

This addon just creates a couple slash commands to easily interface with the existing Blizzard API to allow creating, editing, and deleting sets.

Once a set is saved, Blizzard fuctionality will automatically display which sets that item belongs to on the item's tooltip as shown here:

![image](https://github.com/RabbleCode/closet/assets/56865013/1b4bbfcc-ecbe-4287-8612-e27a7595ef49)


There are no plans to develop more advanced features like integrating this visually into the "paperdoll" character frame or allowing for editing individual slots at a time. This is all or nothing. When you save a set, it saves everything you're currently wearing with the name you chose.
