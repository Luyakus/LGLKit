#version 330 core

layout (location = 0) in vec3 aPos;
layout (location = 1) in vec2 aTexcoord;
uniform mat4 trans;
out vec2 ourTexcoord;

void main() {
    gl_Position = trans * vec4(aPos, 1);
    ourTexcoord = aTexcoord;
}

