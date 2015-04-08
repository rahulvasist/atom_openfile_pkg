FileSelectListView = require './open-file-pkg-view'
{CompositeDisposable} = require 'atom'

module.exports = OpenFilePkg =
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace',
      'open-file-pkg:toggle': => @createFileView().toggle()

  deactivate: ->
    @subscriptions.dispose()

  createFileView: ->
    @fileSelectListView = new FileSelectListView()
    @fileSelectListView
