#version 330 core
precision mediump float;

flat in int instanceID;

out vec4 fragColor;

uniform int count;
uniform vec2 countXY;
uniform float time;

void main()
{
    float color = sin(mod(instanceID, countXY.x) * 0.15 + time * 0.5 + int(instanceID / countXY.x) * 0.55) * 0.5 + 0.5;
    fragColor = vec4(0, color, 1, 1);
}