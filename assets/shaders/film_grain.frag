#include <flutter/runtime_effect.glsl>

uniform sampler2D uTexture;
uniform float uTime;
uniform float uIntensity;
uniform vec2 uResolution;
out vec4 fragColor;

float random(vec2 st) {
  return fract(sin(dot(st.xy, vec2(12.9898, 78.233))) * 43758.5453123);
}

void main() {
  vec2 uv = FlutterFragCoord().xy / uResolution;
  vec4 color = texture(uTexture, uv);

  float grain = random(uv + uTime * 0.01);
  color.rgb += (grain - 0.5) * 0.15 * uIntensity;

  float vignette = 1.0 - length(uv - 0.5) * 1.2;
  color.rgb *= clamp(vignette, 0.0, 1.0);

  color.r *= 1.0 + 0.05 * uIntensity;
  color.b *= 1.0 - 0.05 * uIntensity;

  fragColor = color;
}
