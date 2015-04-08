{$$, SelectListView} = require 'atom-space-pen-views'
fs = require 'fs'

module.exports =

class FileSelectListView extends SelectListView
  listInitialized : false
  modalPanel: null

  initialize: (@listOfItems) ->
    super
    @setItems(@listOfItems)
    @modalPanel = atom.workspace.addModalPanel(item: this, visible: false)

  viewForItem: (item) ->
    $$ ->
      @li class: 'two-lines', =>
        @div item, class: 'primary-line'

  cancel: ->
    console.log("cancelled")
    @modalPanel.hide()

  confirmed: (item) ->
    console.log("confirmed", item)
    @modalPanel.hide()
    @openProjectFile(item)

  toggle: ->
    console.log 'OpenFilePkg was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      if @listInitialized == false
        @listInitialized = true
        path_list = atom.project.getPaths()
        file_path = path_list[0] + '/cscope.files'
        # add check to see if files.list exists
        files = fs.readFileSync(file_path, 'utf-8')
        console.log 'Files: ' + files
        tokens = files.split('\n')
        @setItems(tokens)

      @modalPanel.show()
      @storeFocusedElement()
      @focusFilterEditor()

  openProjectFile: (filePath) ->
    atom.workspace.open(filePath)
