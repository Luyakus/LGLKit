#version 300 es
precision mediump float;

uniform sampler2D texture1;
uniform sampler2D texture2;

in vec2 texcoord;

out vec4 fragColor;

void main() {
    fragColor = mix(texture(texture1, texcoord), texture(texture2, texcoord), 0.5);
}
