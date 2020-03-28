#version 330 core

layout (location = 0) in vec3 aPos;
layout (location = 1) in vec3 aColor;
layout (location = 2) in vec2 texcoord;

out vec2 ourTexcoord;
out vec4 ourColor;
void main() {
    gl_Position = vec4(aPos, 1);
    ourTexcoord = texcoord;
    ourColor = vec4(aColor, 1);
}
