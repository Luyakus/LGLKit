#version 300 es
precision mediump float;

uniform sampler2D texture1;
uniform sampler2D texture2;

in vec2 ourTexcoord;
out vec4 fragColor;

void main() {
    fragColor = mix(texture(texture1, ourTexcoord), texture(texture2, ourTexcoord), 0.5);
}
