fs = require 'fs'
path = require 'path'
csv = require 'csv'

module.exports = (env, callback) ->

  class CsvPlugin extends env.ContentPlugin

    constructor: (@_filename, @_text, @data) ->


    getFilename: ->
      @_filename.relative

    getView: ->
      (locals, contents, templates, callback) ->
        # return the plain CSV file
        callback null, new Buffer @_text

  CsvPlugin.fromFile = (filepath, callback) ->
    fs.readFile filepath, (error, buffer) ->
      if error
        callback error
      else
        data = []
        csv()
          .from(buffer.toString(), columns: true)
          .on('record', (row, index) -> data.push row)
          .on('end', (count) -> callback null, new CsvPlugin(filepath, buffer.toString(), data))

  env.registerContentPlugin 'csv', '**/*.csv', CsvPlugin
  callback() # tell the plugin manager we are done
