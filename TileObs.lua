TileObs = Class{__includes = Rectangle}
if TILE_SIZE==nil then
  TILE_SIZE=50
end
TILE_VEC= Vector(TILE_SIZE,TILE_SIZE)
math.randomseed(os.time())

function TileObs:init(x,y,obst,color)
  Rectangle.init(self,Vector(x,y),TILE_VEC)
  if color==nil then
    self.color={ math.random(),math.random() ,math.random()}
  else
    self.color=color
  end
  self.obst=obst or 0 --boolens to remove Edges
end

function TileObs:Draw()
  if self.color~=nil then
    love.graphics.setColor(self.color)
  end
  Rectangle.Draw(self)
end

function TileObs:Type()
  return "Tile"
end

function TileObs:OpEdgesP(point)
  local result ={}
  local vertices=Rectangle.findVertices(self)
  self.edges=Rectangle.Edges(self)
  if point.x < self.b.x and math.floor(self.obst/2)%2==0 then
    table.insert(result,self.edges[1])
  end
  if point.x >  self.c.x and math.floor(self.obst/8)%2==0 then
    table.insert(result,self.edges[3])
  end
  if point.y <  self.b.y and math.floor(self.obst/4)%2==0  then
    table.insert(result,self.edges[0])
  end
  if point.y > self.c.y and self.obst%2==0 then
    table.insert(result,self.edges[2])
  end
  return result
end
