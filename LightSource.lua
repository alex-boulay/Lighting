LightSource =Class{}

function LightSource:init(data)
  self.shape=Circle(Vector(data.position.x,data.position.y),data.radius)
  self.color=data.color or {1,1,1}
  self.hasmoved=false --trying to optimise calculus for static lights
  self.canvas=love.graphics.newCanvas()
end

function LightSource:send(shader)
  shader:send("lightpos",{self.shape.c.x,self.shape.c.y})
  shader:send("lightradius",self.shape.r)
  shader:send("lightcolor",self.color)
end

function LightSource:update(x,y)
  if x~=self.shape.x or y~=self.shape.y then
    self.shape.c.x=x
    self.shape.c.y=y
    self.hasmoved=true
  else
    self.hasmoved=false
  end

  --[[ to implement

  trace their shadow polygons
  draw lighting
  optimise segments to take less space
  ]]
end

function LightSource:Obsctructions(Olist)
  local seglist=self:getObsSeg(Olist)
  local shadows={}
  for k,seg in pairs(seglist) do
    table.insert(shadows,self.shape.c:ScreenWallProj(seg,screenbox))
  end
  love.graphics.setColor(0,0,0)
  for k,sha in pairs(shadows) do
    sha:Draw()
  end
end

function LightSource:inRange(Olist)
  local inrange={}
  for k,obs in pairs(Olist) do
    if MScollide(self.shape,obs)then
      table.insert(inrange,obs)
    end
  end
  return inrange
end

function LightSource:getObsSeg(Olist)
  local inrange= self:inRange(Olist)
  local seglist={} --list of obstructing segments
  for k,obs in pairs(inrange) do
    for k1,seg in pairs(obs:OpEdgesP(self.shape.c))do
      table.insert(seglist,seg)
    end
  end
  return seglist
end

function LightSource:Draw(shader)
    self:send(shader)
    love.graphics.setShader(shader)
end
