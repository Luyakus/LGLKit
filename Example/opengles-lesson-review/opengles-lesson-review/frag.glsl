#version 300 es
precision mediump float;

uniform sampler2D texture1;
uniform sampler2D texture2;

in vec2 texcoord;

out vec4 fragColor;

//void main() {
//    fragColor = mix(texture(texture1, texcoord), texture(texture2, texcoord), 0.5);
//}

//const float ud = 80.0;
//
//void main() {
//    float radius = 0.2;
//    vec2 origin = vec2(0.5, 0.5);
//    vec2 xy = texcoord;
//    vec2 dxy = xy - origin;
//
//    float dst = length(dxy);
//    float angle = atan(dxy.x, dxy.y) + radians(ud) * (1.0 - (dst/radius) * (dst/radius));
//
//    if (dst <= radius) {
//        xy = vec2(radius, radius) + dst * vec2(cos(angle), sin(angle));
//    }
//    fragColor = texture(texture1, xy);
//}


const float step_size = 0.01;

void main() {
    fragColor = texture(texture1, vec2(floor(texcoord.x/step_size) * step_size, floor(texcoord.y/step_size) * step_size));
}
