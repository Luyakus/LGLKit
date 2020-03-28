
#version 330 core

in vec2 ourTexcoord;
uniform sampler2D texture1;

out vec4 fragColor;

void main() {
    fragColor = texture(texture1, ourTexcoord);
}
