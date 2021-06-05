#version 120

uniform sampler2D DiffuseSampler;
uniform sampler2D DiffuseDepthSampler;
uniform sampler2D TranslucentSampler;
uniform sampler2D TranslucentDepthSampler;
uniform sampler2D ItemEntitySampler;
uniform sampler2D ItemEntityDepthSampler;
uniform sampler2D ParticlesSampler;
uniform sampler2D ParticlesDepthSampler;
uniform sampler2D WeatherSampler;
uniform sampler2D WeatherDepthSampler;
uniform sampler2D CloudsSampler;
uniform sampler2D CloudsDepthSampler;

varying vec2 TexCoord;

struct Layer_t {
    vec4 color;
    float depth;
};

#define NUM_LAYERS 6

Layer_t layers[NUM_LAYERS];

void main(void)
{
    layers[0] = Layer_t(vec4(texture2D(DiffuseSampler, TexCoord).rgb, 1.0), texture2D(DiffuseDepthSampler, TexCoord).r);
    layers[1] = Layer_t(texture2D(TranslucentSampler, TexCoord), texture2D(TranslucentDepthSampler, TexCoord).r);
    layers[2] = Layer_t(texture2D(ItemEntitySampler, TexCoord), texture2D(ItemEntityDepthSampler, TexCoord).r);
    layers[3] = Layer_t(texture2D(ParticlesSampler, TexCoord), texture2D(ParticlesDepthSampler, TexCoord).r);
    layers[4] = Layer_t(texture2D(WeatherSampler, TexCoord), texture2D(WeatherDepthSampler, TexCoord).r);
    layers[5] = Layer_t(texture2D(CloudsSampler, TexCoord), texture2D(CloudsDepthSampler, TexCoord).r);

    for(int i = 0; i < NUM_LAYERS; i++) {
        for(int j = 0; j < NUM_LAYERS - i - 1; j++) {
            int k = j + 1;
            if(layers[j].depth < layers[k].depth) {
                Layer_t save = layers[j];
                layers[j] = layers[k];
                layers[k] = save;
            }
        }
    }

    vec3 color = vec3(0.0);

    for(int i = 0; i < NUM_LAYERS; i++) {
        color *= 1.0 - layers[i].color.a;
        color += layers[i].color.rgb;
    }

    gl_FragColor = vec4(color, 1.0);
}
