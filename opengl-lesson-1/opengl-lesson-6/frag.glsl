#version 330 core

uniform sampler2D texture1;
uniform sampler2D texture2;
in vec2 ourTexcoord;

out vec4 FragColor;

void main() {
    FragColor = mix(texture(texture2, ourTexcoord), texture(texture1, ourTexcoord), 0.5);
}
