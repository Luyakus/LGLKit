#version 330 core
in vec4 ourColor;
out vec4 fragColor;
uniform vec4 changeAlpha;

void main() {
    fragColor = ourColor.xyzw - changeAlpha.xyzw;
}
