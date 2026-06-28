#include <flutter/runtime_effect.glsl>

uniform sampler2D uTexture;
uniform float uTime;
uniform float uIntensity;
uniform vec2 uResolution;
out vec4 fragColor;

void main() {
  vec2 uv = FlutterFragCoord().xy / uResolution;
  vec2 center = vec2(0.5);
  vec2 dir = uv - center;
  float dist = length(dir);

  float shift = dist * 0.02 * uIntensity;

  float r = texture(uTexture, uv + dir * shift).r;
  float g = texture(uTexture, uv).g;
  float b = texture(uTexture, uv - dir * shift).b;

  fragColor = vec4(r, g, b, 1.0);
}
