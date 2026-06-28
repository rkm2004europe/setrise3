#include <flutter/runtime_effect.glsl>

uniform sampler2D uTexture;
uniform float uTime;
uniform float uIntensity;
uniform vec2 uResolution;
out vec4 fragColor;

void main() {
  vec2 uv = FlutterFragCoord().xy / uResolution;
  vec4 color = texture(uTexture, uv);

  float dist = length(uv - 0.5);
  float vignette = smoothstep(0.8, 0.3, dist);
  color.rgb *= mix(1.0, vignette, uIntensity);

  fragColor = color;
}
