
#version 330 core

layout (location = 0) in vec3 aPos;
layout (location = 1) in vec2 aTexcoord;

uniform mat4 model;

out vec2 texcoord;

void main() {
    gl_Position = vec4(aPos, 1) * model;
    texcoord = aTexcoord;
}
