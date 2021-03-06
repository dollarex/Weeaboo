#version 330 core
layout (location = 0) in vec4 aPosition;
layout (location = 1) in vec3 aNormal;
layout (location = 2) in vec2 aTexcoord;
layout (location = 3) in ivec4 aBoneId;
layout (location = 4) in vec4 aBoneWeight;
layout (location = 5) in vec3 aTangent;

uniform mat4 uMVP;
uniform mat4 uModel;

uniform mat4 uBoneTransforms[100];

out vec2 vTexcoord;
out vec3 vFragPos;
out vec3 vNormal;
out vec3 vTangent;

void main()
{
    mat4 bone_transform = uBoneTransforms[aBoneId[0]] * aBoneWeight[0];
    bone_transform = uBoneTransforms[aBoneId[1]] * aBoneWeight[1];
    bone_transform = uBoneTransforms[aBoneId[2]] * aBoneWeight[2];
    bone_transform = uBoneTransforms[aBoneId[3]] * aBoneWeight[3];

    vec4 pos = bone_transform * aPosition;
    vec4 world_pos = uModel * pos;
    gl_Position = uMVP * pos;
    vTexcoord = aTexcoord;
    vFragPos = world_pos.xyz;

    mat3 normal_matrix = transpose(inverse(mat3(uModel * bone_transform)));
    vNormal = normal_matrix * aNormal;
    vTangent = normal_matrix * aTangent;
}

