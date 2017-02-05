module.exports =
  provideLinter: ->
    provider =
      name: 'linter-julia-syntax'
      grammarScopes: ['source.julia']
      scope: 'file'
      lintOnFly: true
      lint: (textEditor)->
        output = []
        inptext = textEditor.getText()
        filePath = textEditor.getPath()
        textarray = inptext.split("\n")

        textarray.forEach (element, index, array) ->
          #console.log index, element
          if element.length > 80
            output.push({
              type: "Info"
              text: "Line lengths exceeds 80 chars"
              range: [[index,80], [index,element.length]]
              filePath
              })
          else if (/\s+$/.test(element))
            output.push({
              type: "Info"
              text: "Unnessessary white space characters"
              range: [[index,element.length], [index,element.length+1]]
              filePath
              })
        output
