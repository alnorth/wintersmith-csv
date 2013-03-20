fs = require 'fs'
path = require 'path'
csv = require 'csv'

module.exports = (wintersmith, callback) ->

  class CsvPlugin extends wintersmith.ContentPlugin

    constructor: (@_filename, @_text, @data) ->


    getFilename: ->
      @_filename

    render: (locals, contents, templates, callback) ->
      # return the plain CSV file
      callback null, new Buffer @_text

  CsvPlugin.fromFile = (filename, base, callback) ->
    fs.readFile path.join(base, filename), (error, buffer) ->
      if error
        callback error
      else
        data = []
        csv()
          .from(buffer.toString(), columns: true)
          .on('record', (row, index) -> data.push row)
          .on('end', (count) -> callback null, new CsvPlugin filename, buffer.toString(), data)

  wintersmith.registerContentPlugin 'csv', '**/*.csv', CsvPlugin
  callback() # tell the plugin manager we are done
