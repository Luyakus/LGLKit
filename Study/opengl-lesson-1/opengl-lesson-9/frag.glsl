
#version 330 core

in vec3 fragPos;
in vec3 ourNormal;

uniform vec3 lightColor;
uniform vec3 aColor;
uniform vec3 lightPos;
uniform vec3 viewPos;

out vec4 fragColor;

void main() {
    float ambientStrength = 0.1;
    vec3 amibent = ambientStrength * lightColor;
    
    vec3 norm = normalize(ourNormal);
    vec3 lightDir = normalize(fragPos - lightPos);
    float diff = max(dot(norm, lightDir), 0);
    vec3 diffuse = diff * lightColor;
    
    float specularStrength = 0.5;
    vec3 viewDir = normalize(viewPos - fragPos);
    vec3 reflectDir = reflect(-lightDir, norm);
    float spec = pow(max(dot(viewDir, reflectDir), 0.0), 32);
    vec3 specular = specularStrength * spec * lightColor;
    
    vec3 result = (amibent + diffuse + specular) * aColor;

    fragColor = vec4(result, 1.0);
}
