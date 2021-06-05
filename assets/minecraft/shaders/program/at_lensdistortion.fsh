#version 120

uniform sampler2D DiffuseSampler;

uniform vec2 Amount;

varying vec2 TexCoord;

vec2 barrelDistortion(vec2 uv, float amt)
{
    vec2 cc = (uv - 0.5);
    return (uv + cc * (dot(cc, cc) * 0.015) * amt);
}

void main(void)
{
    vec3 color = vec3(0.0, 0.0, 0.0);
    vec2 baseUV = barrelDistortion(TexCoord, Amount.x);
    for(int i = 0; i < 10; i++) {
        vec3 pure = texture2D(DiffuseSampler, barrelDistortion(baseUV, i * 0.1)).rgb;
        vec3 abb1 = texture2D(DiffuseSampler, barrelDistortion(baseUV, i * 0.1 + Amount.y)).rgb;
        vec3 abb2 = texture2D(DiffuseSampler, barrelDistortion(baseUV, i * 0.1 - Amount.y)).rgb;
        color += vec3(abb1.r, pure.g, abb2.b);
    }
    gl_FragColor = vec4(color / 10.0, 1.0);
}
