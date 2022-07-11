	/* DESTRUCTIBLE TERRAIN - Nocturne Games

	Thank you for buying this asset and I hope that it fullfils your needs, both
	as a learning tool and a tool for making great games!

	This asset has been designed to be as flexible as possible and includes a 
	fully functioning demo where you can create your own destructible terrain, 
	edit it, save it and load it as well as play with it.

	The included Demo permits you to drive a tank around (use the arrow keys left 
	right and up) and shoot rockets (use Space), while the Edit mode permits you
	to "paint" terrain using the LMB and erase terrain using the RMB, and also 
	gives you some extra buttons to change the brush size, save or load and show 
	debug information.

	To use this asset in your own projects, inmport the YYMP project file and 
	only select the "Destructible Terrain" folders for import, ignoring all 
	assets and folders with "DEMO" in the title. Once imported, simply call the 
	"terrain_init()" function from some object or event to initialise the terrain, 
	and then you can use the other scripts to generate or destroy terrain, as well
	as get and set other information (like terrain texture, or debug mode, etc...).

	The asset has a fully functioning save and load system built in, and I recommend
	that you make the most of it to create your levels (as illustrated in the demo)
	and then save them out, since the save function lets you supply a parameter name for
	the files it creates, so you can hook it up with a function like get_save_filename() 
	to generate unique named terrain files. Alternatively, you can also create terrain 
	in the room editor, using the "obj_Terrain_Brush_*" objects. Check out the Demo room 
	to see how these are used and note that while you can scale these brush instances 
	in the room editor, the circular brush must ALWAYS remain circular otherwise you 
	will get weird results (so make sure to scale the X and Y axis equally).

	I also recommend that you open each of the scripts that come with the asset and
	take a moment to read trough all the comments so you have a good idea of how they
	work, what they do and how they can be used. Note that the asset is based off of 
	a single terrain controller object that is created when you call the _init function,
	but you do not have to ever interact with this object directly, as the helper, 
	getter and setter scripts are all designed to do that for you, and from any instance 
	in the game.

	Finally, while the asset is highly optimised, if you compile using the YYC you'll
	find that it is BLINDINGLY FAST! As such, I recommend that all finished products
	using this asset be compiled using the YYC to make the most of the performance
	boost. :)

	I hope you have fun with this, and please take a moment to leave a review on the 
	Marketplace or Itch.io if you'd like to show your appreciation!

	All the best!

	Mark Alexander

	PS: A quick note about pixel art - By default the asset will NOT set any interpolation or 
	display AA options, even though the "smooth" setting is set to true by default, so as to 
	respect the game options and settings of any game this has been added to. This means that
	you must EXPLICITLY set smoothing to enabled or disabled using the "terrain_set_smooth()"
	function if required. Setting this to false will disable AA and linear interpolation - great 
	for pixel art - but if your game already disables these things, then you should not need 
	to call the smooth scripts and can ignre them.

	*/


