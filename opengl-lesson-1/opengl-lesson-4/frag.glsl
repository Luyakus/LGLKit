#version 330 core

out vec4 FragColor;

in vec2 ourTexcoord;
in vec4 ourColor;
uniform sampler2D texture1;
uniform sampler2D texture2;

void main() {
    FragColor = mix(texture(texture1, ourTexcoord), texture(texture2, ourTexcoord * 2), 0.5) * ourColor; 
}

