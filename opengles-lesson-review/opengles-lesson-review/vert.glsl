#version 300 es
precision mediump float;

layout (location = 0) in vec3 aPos;
layout (location = 1) in vec2 aTexcoord;

uniform mat4 scale;
uniform mat4 rotate;
out vec2 texcoord;

void main() {
    gl_Position = vec4(aPos, 1) * scale * rotate;
    texcoord = aTexcoord;
}

