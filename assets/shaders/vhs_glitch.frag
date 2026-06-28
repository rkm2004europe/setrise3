#include <flutter/runtime_effect.glsl>

uniform sampler2D uTexture;
uniform float uTime;
uniform float uIntensity;
uniform float uSpeed;
uniform vec2 uResolution;
out vec4 fragColor;

float random(vec2 st) {
  return fract(sin(dot(st.xy, vec2(12.9898, 78.233))) * 43758.5453123);
}

void main() {
  vec2 uv = FlutterFragCoord().xy / uResolution;

  float jitter = step(0.98, random(vec2(floor(uv.y * 50.0), floor(uTime * uSpeed)))) * 0.02 * uIntensity;
  uv.x += jitter;

  float shift = 0.005 * uIntensity;
  float r = texture(uTexture, uv + vec2(shift, 0.0)).r;
  float g = texture(uTexture, uv).g;
  float b = texture(uTexture, uv - vec2(shift, 0.0)).b;

  vec3 color = vec3(r, g, b);

  float scanline = sin(uv.y * uResolution.y * 0.5) * 0.04 * uIntensity;
  color -= scanline;

  float noise = random(uv + mod(uTime, 1.0)) * 0.1 * uIntensity;
  color += vec3(noise * 0.3, noise, noise * 0.5);

  float gray = dot(color, vec3(0.299, 0.587, 0.114));
  color = mix(vec3(gray), color, 0.85);

  fragColor = vec4(color, 1.0);
}
