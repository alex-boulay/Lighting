Lighting = Class{}

local LightSD=[[
#pragma language glsl3
#pragma debug(on)

uniform vec2 lightpos;
uniform float lightradius;
uniform vec3 lightcolor;

vec4 effect( vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords )
{

  float dist=pow(lightpos.x -screen_coords.x,2)+pow(lightpos.y -screen_coords.y,2);
  float distprc =1 - min(1,dist/pow(lightradius,2));
  //vec4 distv=vec4(lightcolor[0]*distprc,lightcolor[1]*distprc,lightcolor[2]*distprc,1);
  vec4 distv=vec4(lightcolor,distprc);
  vec4 texturecolor=Texel(tex,texture_coords);
  return color*texturecolor*distv;
}
]]

function Lighting:init(data)
  self.lights=data.lights or {}
  self.obstruct=data.obstruct or {}
  self.buffers={}
  self.itemtree={}
  self.shader=love.graphics.newShader(LightSD)
  self.canvas=love.graphics.newCanvas()
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


function Lighting:prep()
  love.graphics.push("all")
  love.graphics.setShader(self.shader)
  --love.graphics.setCanvas(self.)
end

--And God said, Let there be light: and there was light.
function Lighting:drawLights()
  for k,light in pairs(self.lights) do
    light:Draw(self.shader)
  end
  love.graphics.pop()
  for k,light in pairs(self.lights)do
    light:Obsctructions(self.obstruct)
  end
end

function Lighting:Obs()

end
