#version 300 es
precision mediump float;

flat in int instanceID;

out vec4 fragColor;

uniform float count;
uniform vec2 countXY;
uniform float time;

void main()
{
    float color = sin(mod(float(instanceID), countXY.x) * 0.15 + time * 0.5 + float(int(float(instanceID) / countXY.x)) * 0.55) * 0.5 + 0.5;
    fragColor = vec4(0, color, 1, 1);
}