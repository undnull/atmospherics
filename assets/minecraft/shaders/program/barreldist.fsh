#version 120

uniform sampler2D DiffuseSampler;

uniform float Amount;

varying vec2 TexCoord;

void main(void)
{
    float r2 = pow((TexCoord.x - 0.5), 2) + pow((TexCoord.y - 0.5), 2);
    float f = 1.0 + r2 * (-0.15 + Amount * sqrt(r2));
    gl_FragColor = texture2D(DiffuseSampler, vec2((f * (TexCoord.x - 0.5) + 0.5), (f * (TexCoord.y - 0.5) + 0.5)));
}
