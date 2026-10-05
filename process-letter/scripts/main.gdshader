//https://godotshaders.com/shader/animal-well-inspired-crt-effect/

shader_type canvas_item;

uniform bool crt_enabled = true;

uniform float scanLineFac : hint_range(0.0, 1.0) = 0.1;
uniform float scanLineWidth : hint_range(0.0, 0.5) = 0.25;
uniform float nearestFac : hint_range(0.0, 2.0) = 0.0;
uniform float linearFac : hint_range(0.0, 2.0) = 1.3;

uniform bool aberration_enabled = true;
uniform float aberrationFac : hint_range(0.0, 0.01) = 0.001;

const vec2 RESOLUTION = vec2(320.0, 180.0);

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_linear;

void fragment() {
    vec2 uv = SCREEN_UV;

    if (crt_enabled) {
        // Scanline position
        float fy = fract(uv.y * RESOLUTION.y);

        float scanLine = 0.0;

        if (fy < scanLineWidth || fy > 1.0 - scanLineWidth) {
            scanLine = scanLineFac;
        }

        // Chromatic aberration
        float chromaticStrength = aberration_enabled ? 1.0 : 0.0;

        vec4 color = vec4(0.0);

        color.r = texture(
            screen_texture,
            uv - vec2(chromaticStrength * aberrationFac, 0.0)
        ).r;

        color.g = texture(
            screen_texture,
            uv
        ).g;

        color.b = texture(
            screen_texture,
            uv + vec2(chromaticStrength * aberrationFac, 0.0)
        ).b;

        color.a = 1.0;

        // Apply brightness and scanlines
        color = mix(
            color * linearFac,
            vec4(0.0, 0.0, 0.0, 1.0),
            scanLine
        );

        COLOR = color;
    }
    else {
        COLOR = texture(screen_texture, uv);
    }
}