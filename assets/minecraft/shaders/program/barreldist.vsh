#version 120

attribute vec3 Position;

uniform mat4 ProjMat;
uniform vec2 OutSize;

uniform float Amount;

varying vec2 TexCoord;

void main(void)
{
    gl_Position = vec4((ProjMat * vec4(Position.xy, 0.0, 1.0)).xy, 0.2, 1.0);
    TexCoord = Position.xy / OutSize;
}
