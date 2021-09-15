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
  return texturecolor*distv;
}
