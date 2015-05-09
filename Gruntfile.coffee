module.exports = (grunt) ->

	grunt.initConfig

		coffeeify: 
			compile: 
				files: [
					src: ['app/lib/*.coffee', 'app/main.coffee'],
					dest: 'built-app/bundle.js'
	      		]
		copy:
			html:
				src: 'app/index.html'
				dest: 'built-app/index.html'
			assets:
				expand: true
				cwd: 'app/assets/'
				src: '**'
				dest: 'built-app/assets/'
				flatten: true
				filter: 'isFile'
		sass:
			compile:
				files:
					'built-app/style.css': 'app/styles/main.scss'
		watch:
			coffeeify:
				files: ['app/lib/*.coffee', 'app/main.coffee']
				tasks: ['coffeeify:compile']
			copy:
				files: ['app/index.html', 'app/assets/*']
				tasks: ['copy:html', 'copy:assets']
			sass:
				files: ['app/styles/*.scss']
				tasks: ['sass:compile']

					
	grunt.loadNpmTasks 'grunt-coffeeify'
	grunt.loadNpmTasks 'grunt-contrib-copy'
	grunt.loadNpmTasks 'grunt-contrib-sass'
	grunt.loadNpmTasks 'grunt-contrib-watch'
	grunt.registerTask 'default', ['coffeeify', 'copy', 'sass']
