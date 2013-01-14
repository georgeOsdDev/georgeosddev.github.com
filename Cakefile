log = console.log
crypto = require 'crypto'
{ exec } = require 'child_process'

Coffee =
  cmd: "coffee"
  options: [
    "-c"                                #compile option
    "-o ./javascripts"                  #dest
    "./src/coffee"                      #src
  ]

Coffeelint =
  cmd: "coffeelint"
  options: [
    "-f ./coffeelint.json"              #config file
    "-r"                                #recurisve
    "./src/coffee"                      #src
  ]

Uglifyjs =
  cmd: "uglifyjs"
  options: [
    "--verbose"                         #verbose
    "--overwrite"                       #overwrite
    "./javascripts/app.js"              #src
  ]

Stylus =
  cmd: "stylus"
  options: [
    "./src/stylus"                      #src
    "--compress"                        #compress option
    "--include ./lib/nib/lib"           #use nib
    "--out ./stylesheets"               #dest
  ]

task 'compile', (options) ->
  compile()

task 'coffee', (options) ->
  execGlobalCommand Coffee

task 'uglify', (options) ->
  execGlobalCommand(Uglifyjs)

task 'lint', (options) ->
  execGlobalCommand(Coffeelint)

task 'doc', (options) ->
  execGlobalCommand(Docco)

task 'clean', (options) ->
  clean()

task 'preview',(options) ->
  compile()
  exec "open index.html", (err, stdout, stderr)->
    throw err if err
    log stdout + stderr

compile = ->
    execGlobalCommand Coffeelint
    execGlobalCommand Coffee, ->
      copyJson ->
        execGlobalCommand Uglifyjs
    execGlobalCommand Stylus

execGlobalCommand = (command,callback) ->
  exec "#{command.cmd} #{command.options.join(' ')}", (err, stdout, stderr)->
    throw err if err
    log stdout + stderr
    callback?.apply()

clean = ->
  exec 'rm -rf ./javascripts/*.js', (err, stdout, stderr)->
    throw err if err
    log stdout + stderr
  exec 'rm -rf ./stylesheets/*.css', (err, stdout, stderr)->
    throw err if err
    log stdout + stderr
