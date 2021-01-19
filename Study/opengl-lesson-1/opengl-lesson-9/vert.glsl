#version 330 core

layout (location = 0) in vec3 aPos;
layout (location = 1) in vec3 aNormal;

out vec3 ourNormal;
out vec3 fragPos;
uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;

void main() {
    gl_Position = projection * view * model * vec4(aPos, 1);
    ourNormal = aNormal;
    fragPos = vec3(model * vec4(aPos, 1));
}
