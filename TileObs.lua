TileObs = Class{__includes = Rectangle}

TILE_SIZE=50
TILE_VEC= Vector(TILE_SIZE,TILE_SIZE)
math.randomseed(os.time())

function TileObs:init(x,y,color)
  Rectangle.init(self,Vector(x,y),TILE_VEC)
  if color==nil then
    self.color={ math.random(),math.random() ,math.random()}
  else
    self.color=color
  end
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
