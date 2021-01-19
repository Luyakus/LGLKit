#version 300 es

precision mediump float;
in vec3 ourColor;
out vec4 fragColor;

void main() {
    fragColor = vec4(ourColor, 1);
}
