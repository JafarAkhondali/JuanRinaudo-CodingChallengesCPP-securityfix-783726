#version 330 core
precision mediump float;

layout (location = 0) in vec3 position;
layout (location = 1) in vec2 origin;

flat out int instanceID;

uniform mat4 projection;
uniform mat4 view;
uniform mat4 parentMVP;
uniform vec2 scale;
uniform float time;
uniform int count;

void main()
{    
    mat4 mPos = mat4(1.0, 0.0, 0.0, 0.0,
        0.0, 1.0, 0.0, 0.0,
        0.0, 0.0, 1.0, 0.0,
        origin.x, origin.y, 0.0, 1.0);
            
    mat4 mScale = mat4(scale.x, 0.0, 0.0, 0.0,
        0.0, scale.y, 0.0, 0.0,
        0.0, 0.0, 1.0, 0.0,
        0.0, 0.0, 0.0, 1.0);

    mat4 model = mPos * mScale;

    mat4 pv = projection * view * model * parentMVP;

    instanceID = gl_InstanceID;
    gl_Position = pv * vec4(position.x, position.y + cos(time * 0.5 + instanceID * .8) * 0.8, position.z, 1.0);
}