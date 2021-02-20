#include frex:shaders/api/header.glsl
#include canvas:shaders/pipeline/pipeline.glsl
#include atmospherics:postprocess_config

#define AMOUNT CHROMATIC_ABERRATION_AMOUNT

uniform sampler2D _cvu_base;

varying vec2 _cvv_texcoord;

vec2 barrelDistortion(vec2 uv, float amt)
{
    vec2 cc = (uv - 0.5);
    return (uv + cc * (dot(cc, cc) * 0.015) * amt);
}

void main(void)
{
    if(AMOUNT > 0.0) {
        vec3 color = vec3(0.0);
        for(int i = 0; i < 10; i++) {
            vec3 pure = texture2D(_cvu_base, barrelDistortion(_cvv_texcoord, i * 0.1)).rgb;
            vec3 abb1 = texture2D(_cvu_base, barrelDistortion(_cvv_texcoord, i * 0.1 + AMOUNT)).rgb;
            vec3 abb2 = texture2D(_cvu_base, barrelDistortion(_cvv_texcoord, i * 0.1 - AMOUNT)).rgb;
            color += vec3(abb1.r, pure.g, abb2.b);
        }
        gl_FragColor = vec4(color / 10.0, 1.0);
    }
    else gl_FragColor = texture2D(_cvu_base, _cvv_texcoord);
}
