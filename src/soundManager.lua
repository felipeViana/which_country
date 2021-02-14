local soundManager = {}

function soundManager.play(source)

  source:seek(0)
  source:play()
end

return soundManager
