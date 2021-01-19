#version 330 core

out vec4 FragColor;

uniform sampler2D texture1;
uniform sampler2D texture2;

void main() {
    FragColor = vec4(1, 0.1, 1, 1);
}

