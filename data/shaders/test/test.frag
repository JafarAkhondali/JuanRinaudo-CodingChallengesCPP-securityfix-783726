#version 330 core
precision mediump float;

uniform float time;
uniform vec2 speed;
uniform vec4 color;
uniform vec2 bufferSize;
uniform sampler2D texture;

in vec2 texCoord;
out vec4 fragColor;

#define PI 3.141592653589

float easeSoftLoop(float x) {
    x = mod(x, 1);
    float a = mod(x * 2, 2);
    return (x < 0.5) ?
        ((x < 0.25) ? (4 * pow(a, 3)) : (1 - pow(-2 * a + 2, 3) / 2))
        :
        ((x < 0.75) ? (pow(-2*a+2, 3) / 2 + 1) : (-4 * pow(a-2, 3)));
}

float easeSoftAscending(float x) {
    float base = floor(x);
    x = mod(x, 1);
    return base + (
        (x < 0.5) ? (4 * pow(x, 3)) : (1 - pow(-2 * x + 2, 3) / 2)
    );
}

void main()
{
    vec2 uv = texCoord;

    float t = easeSoftAscending(time) * PI;

    float uvFactor = 50;
    float gFactor = 1;
    float bFactor = -1;

    int index = int(mod((uv.x * uvFactor) / (PI * 2) + PI * .25, 2));
    float r = 1 * (1 - sin(uv.x * uvFactor)) * index;

    index = int(mod((uv.x * uvFactor + t * gFactor) / (PI * 2) + PI * .25, 2));
    float g = 1 * (1 - sin(uv.x * uvFactor + t * gFactor)) * index;

    index = int(mod((uv.x * uvFactor + t * bFactor) / (PI * 2) + PI * .25, 2));
    float b = 1 * (1 - sin(uv.x * uvFactor + t * bFactor)) * index;

    fragColor = vec4(r, g, b, 1);
}