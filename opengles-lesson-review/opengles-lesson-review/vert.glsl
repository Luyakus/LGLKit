#version 300 es
precision mediump float;

layout (location = 0) in vec3 aPos;
layout (location = 1) in vec2 aTexcoord;

uniform mat4 model;
uniform mat4 view;
uniform mat4 perspective;
out vec2 texcoord;

void main() {
    gl_Position =  perspective * view * model * vec4(aPos, 1);
    texcoord = aTexcoord;
}

