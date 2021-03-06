If you like to keep your Magic the Gathering decklists as plain text files you can use this Ruby script to look at pretty versions of them from the command line. I made this tool so I could keep my decklists in a git repository and edit them with my text editor.
Pulls card data from the Scryfall API.

<img src="preview.gif">

# Install
1. Make sure you already have your bin directory added to `$PATH` (you have something like `export PATH=$PATH:~/bin` in your `.bash_profile` or `.bashrc` or whatever)
2. Put `deck` in your bin directory :)
3. Oh yeah I guess you need Ruby installed too


# Usage
Run `deck decklist.txt` where decklist.txt is the relative path to your decklist text file.
Your text file should be formatted like this (you can have unnecessary line breaks):

~~~
Mainboard

4 Foundry Street Denizen
4 Goblin Bushwhacker
4 Goblin Chieftain
4 Goblin Guide
1 Goblin Heelcutter
3 Goblin Piledriver
4 Legion Loyalist
3 Mogg Fanatic
4 Mogg War Marshal
4 Reckless Bushwhacker
19 Mountain
4 Lightning Bolt
4 Goblin Grenade

Sideboard

2 Dragon's Claw
1 Grafdigger's Cage
2 Relic of Progenitus
1 Tormod's Crypt
1 Goblin Rabblemaster
1 Blood Moon
1 Reality Hemorrhage
2 Skullcrack
2 Smash to Smithereens
2 Shattering Spree
~~~
