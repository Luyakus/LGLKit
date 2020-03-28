#version 330 core

in vec2 ourTexcoord;

uniform sampler2D texture1;
uniform sampler2D texture2;

out vec4 FragColor;

void main() {
    FragColor = mix(texture(texture1, ourTexcoord), texture(texture2, ourTexcoord), 0.5);
}
