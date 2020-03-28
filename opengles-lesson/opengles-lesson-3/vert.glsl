#version 300 es

layout (location = 0) in vec3 aPos;
layout (location = 1) in vec2 aTexcoord;

out vec2 ourTexcoord;

void main() {
    gl_Position = vec4(aPos, 1.0);
    ourTexcoord = aTexcoord;
}
