# Your init script
#
# Atom will evaluate this file each time a new window is opened. It is run
# after packages are loaded/activated and after the previous editor state
# has been restored.
#
# An example hack to log to the console when each text editor is saved.
#
# atom.workspace.observeTextEditors (editor) ->
#   editor.onDidSave ->
#     console.log "Saved! #{editor.getPath()}"

atom.commands.add 'atom-text-editor', 'hyperqing:reformat-code', ->
  editor = atom.workspace.getActiveTextEditor()
  # 记录光标位置
  cursorBufferPosition = editor.getCursorBufferPosition()
  editor.selectAll()
  editor.autoIndentSelectedRows()
  editor.setCursorBufferPosition(cursorBufferPosition)
