#include frex:shaders/api/header.glsl
#include canvas:shaders/pipeline/pipeline.glsl
#include atmospherics:postprocess_config

/***************************************************************
    atmospherics:shaders/pipeline/post/cubic_distortion.frag
****************************************************************/

#define AMOUNT CUBIC_DISTORTION_AMOUNT

uniform sampler2D _cvu_base;

varying vec2 _cvv_texcoord;

void main(void)
{
    float r2 = pow((_cvv_texcoord.x - 0.5), 2) + pow((_cvv_texcoord.y - 0.5), 2);
    float f = 1.0 + r2 * (-0.15 + AMOUNT * sqrt(r2));
    gl_FragColor = texture2D(_cvu_base, vec2((f * (_cvv_texcoord.x - 0.5) + 0.5), (f * (_cvv_texcoord.y - 0.5) + 0.5)));
}
