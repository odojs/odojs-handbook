gulp = require 'gulp'

# utils
rename = require 'gulp-rename'
replace = require 'gulp-replace'
concat = require 'gulp-concat'
merge = require 'merge-stream'
sourcemaps = require 'gulp-sourcemaps'
npmpackage = require './package.json'

# interactive builds
gulp.task 'watch', ['watchcoffee'], ->
  gulp.watch 'assets/*.svg', ['svg']
  gulp.watch ['*.styl'], ['style']
  gulp.watch ['server.coffee'], ['html']

# build everything
gulp.task 'build', ['svg', 'style', 'coffee']
gulp.task 'default', ['watch']

# svg
svgmin = require 'gulp-svgmin'
svgstore = require 'gulp-svgstore'

# generate svg symbols, including flat colour clones
gulp.task 'svg', ->
  flat = gulp.src 'assets/*.svg'
    .pipe svgmin()
    .pipe replace /fill\=\"none*\"/g, ''
    .pipe replace /stroke\=\"none*\"/g, ''
    .pipe replace /fill\=\"[^"]*\"/g, 'fill="currentColor"'
    .pipe replace /stroke\=\"[^"]*\"/g, 'stroke="currentColor"'
    .pipe rename suffix: '-flat'
  color = gulp.src 'assets/*.svg'
    .pipe svgmin()
    .pipe replace /fill\=\"none*\"/g, ''
    .pipe replace /stroke\=\"none*\"/g, ''
  merge flat, color
    .pipe svgstore()
    .pipe rename "#{npmpackage.name}-#{npmpackage.version}.min.svg"
    .pipe gulp.dest 'dist'

# style
stylus = require 'gulp-stylus'
autoprefixer = require 'gulp-autoprefixer'
minifycss = require 'gulp-minify-css'

# compress stylus files and library css together
gulp.task 'style', ->
  gulp.src 'client.styl'
    .pipe sourcemaps.init()
    .pipe stylus
      'include css': yes
    .pipe concat "#{npmpackage.name}-#{npmpackage.version}.min.css"
    .pipe autoprefixer browsers: ['last 2 versions']
    .pipe minifycss()
    .pipe sourcemaps.write './'
    .pipe gulp.dest 'dist'

# coffee
browserify = require 'browserify'
source = require 'vinyl-source-stream'
buffer = require 'vinyl-buffer'
uglify = require 'gulp-uglify'
watchify = require 'watchify'
errorify = require 'errorify'
gutil = require 'gulp-util'

# crawl using browserfy and include .coffee files
coffee = (options) ->
  shouldwatch = options?.watch? and options.watch
  browserifyargs =
    entries: './client'
    # output sourcemaps
    debug: yes
    # needed for watchify
    cache: {}
    packageCache: {}
    fullPaths: shouldwatch
  bundler = browserify browserifyargs
  bundler = watchify bundler if shouldwatch
  # plugin to search for .coffee files first
  coffeefirst = (bundle) ->
    extensions = ['.coffee', '.cson', '.js', '.json']
    bundle._mdeps.options.extensions = extensions
    bundle._extensions = extensions
  bundler
    .plugin coffeefirst
    .on 'error', ->
      gutil.log.apply this, arguments
      bundler.end()
  if shouldwatch
    bundler.plugin errorify
    bundler.transform 'caching-coffeeify', global: yes
  else
    bundler.transform 'coffeeify', global: yes
  compressor = ->
    comp = bundler.bundle()
      .on 'error', ->
        gutil.log.apply this, arguments
        comp.end()
      .pipe source "#{npmpackage.name}-#{npmpackage.version}.min.js"
      .pipe buffer()
      .pipe sourcemaps.init loadMaps: yes
    # faster interactive builds
    comp.pipe uglify() unless shouldwatch
    comp
      .pipe sourcemaps.write './'
      .pipe gulp.dest 'dist'
  if shouldwatch
    bundler.on 'update', (files) ->
      for file in files
        gutil.log "M .#{file.substr __dirname.length}"
      compressor()
  compressor()

gulp.task 'coffee', -> coffee()
gulp.task 'watchcoffee', -> coffee watch: yes

gulp.task 'html', ->
  gulp.src 'server.coffee'
