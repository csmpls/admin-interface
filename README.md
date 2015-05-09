# admin interface

a simple administrator interface for indra-net.

shows who's posted data in the past few seconds (configurable in `server.coffee`), 

make sure you have `node`, `npm` and `grunt`

then just
```npm install```

## directory structure

```
app/ <- this is the webapp 
    styles/ <-- sass files here
    assets/ <-- everything 
	lib/ <- these are your common js-style coffeescript files
	index.html <- the main html template
	main.coffee <- entry point for the webapp  - start reading here
```

`grunt` compiles `app/` to a neat bundle in `built-app/` coffeeify (browserify for coffeescript)

