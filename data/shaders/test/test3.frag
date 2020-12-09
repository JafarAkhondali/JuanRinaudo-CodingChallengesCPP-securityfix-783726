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
    float a = x * 2;
    return (x < 0.5) ?
        ((x < 0.25) ? (4 * pow(a, 3)) : (1 - pow(-2 * a + 2, 3) / 2))
        :
        ((x < 0.75) ? (pow(-2*a+2, 3) / 2 + 1) : (-4 * pow(a-2, 3)));
}

void main()
{
    // float t = sin(time * PI / 3);
    float t = easeSoftLoop(mod(time / 3, 1));
    float abst = abs(t) * 0.2;
    float boxSize = 64;
    float invBoxSize = boxSize / 512f;
    // fragColor = vec4(mod(texCoord.x, invBoxSize) * boxSize, mod(texCoord.y, invBoxSize) * boxSize, 0, 1);//texture2D(texture, mod(texCoord.xy + time * speed, 1)) * color;
    // float x = abs(cos((texCoord.x + PI) + abst));
    // float y = abs(cos((texCoord.y + PI) + abst));
    float s = 250;
    float xMod = abst * cos((texCoord.x) * s) * sin((texCoord.y) * s);
    float yMod = abst * cos((texCoord.x) * s) * sin((texCoord.y) * s);
    float squares = mod(floor((texCoord.x + xMod) / invBoxSize) + floor((texCoord.y + yMod) / invBoxSize) + 1, 2);
    float color = squares;
    fragColor = vec4(color, color, color, 1);//texture2D(texture, mod(texCoord.xy + time * speed, 1)) * color;
}