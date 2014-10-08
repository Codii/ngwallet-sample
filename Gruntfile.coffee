
APP_ROOT = __dirname

config =
	paths:
		root: APP_ROOT
		front:
			app:     require("path").resolve APP_ROOT, "front/app"
			scripts: require("path").resolve APP_ROOT, "front/app/src"
			test: 	 require("path").resolve APP_ROOT, "front/app/test"
			images:  require("path").resolve APP_ROOT, "front/app/images"
			fonts:   require("path").resolve APP_ROOT, "front/app/font"
			lib:     require("path").resolve APP_ROOT, "front/lib"
			tmp:     require("path").resolve APP_ROOT, "tmp/front"
			dist:    require("path").resolve APP_ROOT, "static/front"
	endpoints:
		api: "http://localhost:8002/api"

module.exports = (grunt) ->

	require('load-grunt-tasks')(grunt)
	require('time-grunt')(grunt)

	# Load liverload for automatic page refresh in browser
	require('connect-livereload')

	grunt.initConfig
		config:    config
		env:       process.env

		# Clean folders
		clean:
			frontTmp:  config.paths.front.tmp
			frontDist: config.paths.front.dist

		# Copy assets to temp folders
		copy:
			options:
				force: true
			frontIndex:
				nonull: true
				src:    '<%= config.paths.front.app %>/index.html'
				dest:   '<%= config.paths.front.dist %>/index.html'
			frontTexts:
				expand: true
				cwd:    '<%= config.paths.front.app %>'
				src:    ['*.txt']
				dest:   '<%= config.paths.front.dist %>/'
			frontImages:
				expand: true
				cwd:    '<%= config.paths.front.app %>/images'
				src:    ['{,images/**/}*.{ico,ppaths.front,gif,jpg,jpeg}']
				dest:   '<%= config.paths.front.dist %>/images'
			frontFonts:
				expand: true
				cwd:    '<%= config.paths.front.app %>/fonts'
				src:    ['{,**/}*']
				dest:   '<%= config.paths.front.dist %>/fonts'

		# Coffee files compilation
		coffee:
			front:
				expand: true
				cwd:    config.paths.front.scripts
				src:    ['{,**/}*.coffee']
				dest:   '<%= config.paths.front.tmp %>/scripts'
				ext:    '.js'

		# Less files compilation
		less:
			front:
				expand: true
				cwd:    config.paths.front.scripts
				src:    ['{,**/}*.less']
				dest:   '<%= config.paths.front.tmp %>/styles'
				ext:    '.css'

		ngtemplates:
			bootstrap:
				cwd: "<%= config.paths.front.lib %>/angular-bootstrap-ui"
				src: "template/**/*.html"
				dest: "<%= config.paths.front.tmp %>/scripts/bootstrap.templates.js"
				options:
					module: "templates"
			front:
				src: "<%= config.paths.front.app %>/**/*.html"
				dest: "<%= config.paths.front.tmp %>/scripts/templates.js"
				options:
					module: "templates"
					url: (url) -> url.substring(url.lastIndexOf("/") + 1).replace('.html', '')


		# Concatenate files. Will put templates / css / js altogether
		concat:
			css:
				dest: '<%= config.paths.front.dist %>/app.css'
				src: [
					'<%= config.paths.front.lib %>/bootstrap/dist/css/bootstrap.css'
					'<%= config.paths.front.lib %>/bootstrap/dist/css/bootstrap-theme.css'
					'<%= config.paths.front.lib %>/font-awesome/css/font-awesome.css'
					'<%= config.paths.front.lib %>/glyphicons/glyphicons.css'
					'<%= config.paths.front.lib %>/glyphicons/halflings.css'
					'<%= config.paths.front.lib %>/angular-ui/build/angular-ui.css'
					'<%= config.paths.front.lib %>/angular/angular-csp.css'
					'<%= config.paths.front.tmp %>/styles/common/common.css'
					'<%= config.paths.front.tmp %>/styles/common/**/*.css'
					'<%= config.paths.front.tmp %>/styles/front/**/*.css'
					'<%= config.paths.front.tmp %>/styles/dashboard/**/*.css'
				]
			js:
				dest: '<%= config.paths.front.dist %>/app.js'
				src: [
					'<%= config.paths.front.lib %>/jquery/dist/jquery.js'
					'<%= config.paths.front.lib %>/lodash/dist/lodash.js'
					'<%= config.paths.front.lib %>/bootstrap/dist/js/bootstrap.js'
					'<%= config.paths.front.lib %>/angular/angular.js'
					'<%= config.paths.front.lib %>/angular-cookies/angular-cookies.js'
					'<%= config.paths.front.lib %>/angular-bootstrap/ui-bootstrap.js'
					'<%= config.paths.front.lib %>/angular-ui/build/angular-ui.js'
					'<%= config.paths.front.lib %>/angular-ui/build/angular-ui-shiv.js'
					'<%= config.paths.front.lib %>/angular-ui-utils/ui-utils.js'
					'<%= config.paths.front.lib %>/angular-ui-utils/ui-utils-ieshiv.js'
					'<%= config.paths.front.lib %>/angular-ui-router/release/angular-ui-router.js'
					'<%= config.paths.front.lib %>/modernizr/modernizr.js'
					'<%= config.paths.front.lib %>/moment/moment.js'
					'<%= config.paths.front.lib %>/moment/lang/fr.js'
					'<%= config.paths.front.lib %>/ng-file-upload/angular-file-upload-shim.js'
					'<%= config.paths.front.lib %>/ng-file-upload/angular-file-upload.js'
					'<%= config.paths.front.lib %>/angular-easyfb/angular-easyfb.js'
					'<%= config.paths.front.tmp %>/scripts/app.js'
					'<%= config.paths.front.tmp %>/scripts/Config.js'
					'<%= config.paths.front.tmp %>/scripts/templates.js'
					'<%= config.paths.front.tmp %>/scripts/bootstrap.templates.js'
					'<%= config.paths.front.tmp %>/scripts/common/**/*.js'
					'<%= config.paths.front.tmp %>/scripts/wallet/**/*.js'
				]

		# Replace tokens in scripts for paths and configuration purposes
		replace:
			livereload:
				src: ['<%= appConfig.ng.dist %>/app.html'],
				overwrite: true,
				replacements: [{
					from: /<!-- LIVERELOAD -->/g,
					to: """\n<script src="/livereload.js"></script>"""
				}]

		karma:
			frontUnit:
				configFile: './front/test/karma-unit.conf.js'
				autoWatch: false
				singleRun: true
			frontUnitAuto:
				configFile: './front/test/karma-unit.conf.js'
				autoWatch: false
				singleRun: true

		# Shell commands used by tasks here
		shell:
			options:
				stdout: true
			reloadnginx:
				command: './bin/deploy'
				options:
					async: true
					stderr: true
					stdout: true

		open:
			front:
				path: "http://localhost:8002"

		# Watched files and triggered actions
		watch:
			front:
				files: [
					'<%= config.paths.front.app %>/{,**/}*.html'
					'<%= config.paths.front.scripts %>/{,**/}*.coffee'
					'<%= config.paths.front.test %>/{,**/}*.coffee'
					'<%= config.paths.front.scripts %>/{,**/}*.less'
					'<%= config.paths.front.images %>/*'
					'<%= config.paths.front.fonts %>/*'
					'<%= config.paths.front.lib %>/*'
					'Gruntfile.coffee'
				]
				tasks: [
					'test'
					'prepareAssets'
				]
				options:
					atBegin:    true
					interrupt:  false
					livereload: config.livereload.port
					interval:   500

	grunt.registerTask 'ngconst', ->
		_ = require('lodash')

		options =
			deps: []
			wrap: '{%= __ngModule %}'
			name: 'env'
			beautify:
				indent_with_tabs: true
			serializer: 'json'
			constants: {}
			values: {}

		options.template = require("path").join(__dirname, 'node_modules', 'grunt-ng-constant', 'tasks', 'constant.tpl.ejs')
		options.dest = config.paths.front.tmp + "/scripts/Config.js"

		options.constants =
			"App":
				endpoints:
					api: config.endpoints.api
				config:
					apis:
						envConfig["_global"]?["apis"]

		stringifyObj = (obj, space) ->
			if _.isUndefined(obj)
				return 'undefined'
			JSON.stringify(obj, null, space)

		templatizeObj = (obj, space) ->
			_.map obj, (val, name) ->
				"name": name
				"value": stringifyObj(val)

		template_data = _.extend({},
			moduleName: options.name
			deps: options.deps
			constants: templatizeObj(options.constants)
			values: templatizeObj(options.values)
		)

		grunt.template.addDelimiters "ngconst", '{%', '%}'

		result = grunt.template.process grunt.file.read(options.template),
			data: template_data
			delimiters: "ngconst"

		grunt.log.write 'Creating module ' + options.name + ' at ' + options.dest + '...'
		grunt.file.write options.dest, result

	###
	Task generating front production files. Static folder is ready to use in production after this task.
	###
	grunt.registerTask  'serve',
		'Configure et deploie client angular',
		(env) ->
			tasks = [
				"prepareAssets"
				"test"
				"watch"
			]
			grunt.task.run tasks
	###
	Task
	###
	grunt.registerTask  'prepareAssets', [
		"clean"
		"coffee"
		"less"
		"copy"
		"ngtemplates"
		"ngconst"
		"concat"
	]

	grunt.registerTask 'test', ['test:unit']
	grunt.registerTask 'test:unit', ['karma:frontUnit']

