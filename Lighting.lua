Lighting = Class{}

function Lighting:init(data)
  self.lights=data.lights or {}
  self.obstruct=data.obstruct or {}
  self.buffers={}
  self.itemtree={}
  self.shader=love.graphics.newShader("Light.glsl")
end

function Lighting:addLight(l)
  table.insert(self.lights,l)
end

function Lighting:addObs()
  
end

-- must be called after updating all position
function Lighting:update()

end

function Lighting:lightCanvas()

end

function Lighting:drawLights()

  for k,light in pairs(self.lights) do
    light:Draw(self.shader)
    light:Obsctructions(self.obstruct)
  end
end

function Lighting:Obs()

end
