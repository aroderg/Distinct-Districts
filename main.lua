moonshine = require "moonshine"

function love.load()
  plains =
  {{0, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0, 0}}
  cellColors = {{1, 1, 1, 1}}
end

function love.draw()
  love.graphics.setLineWidth(1)
  love.graphics.setLineStyle("rough")
  local mainUIChain = moonshine.chain(moonshine.effects.gaussianblur)
  mainUIChain.gaussianblur.sigma = 8
  love.graphics.setColor(1, 1, 1, 1)
  mainUIChain.draw(function()
    for i,v in ipairs(plains) do
      for j,w in ipairs(v) do
        love.graphics.rectangle("fill", 610 + 90 * j, 180 + 90 * i, 70, 70)
      end
    end
  end)
  for i,v in ipairs(plains) do
      for j,w in ipairs(v) do
        love.graphics.rectangle("fill", 610 + 90 * j, 180 + 90 * i, 70, 70)
      end
    end
  for i,v in ipairs(plains) do
    for j,w in ipairs(v) do
      love.graphics.rectangle("line", 600 + 90 * j, 170 + 90 * i, 90, 90)
    end
  end
end

function love.update()
end