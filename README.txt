Type this line of code in your VSCode terminal to save your progress to the output:
-----------------------
cd Original
darklua minify Client Output/Client
darklua minify Server Output/Server
darklua minify Shared Output/Shared
cd ..
rojo serve game.project.json
