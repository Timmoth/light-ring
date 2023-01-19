precision highp float;

uniform float u_time;
uniform vec2 u_size;
uniform float u_lightCount;
uniform float u_radius;
const float TWO_PI = 6.28318530718;
const float brightness = 3.0;

vec3 hsl2rgb(in vec3 c) { // © 2014 Inigo Quilez, MIT license, see https://www.shadertoy.com/view/lsS3Wc
    vec3 rgb = clamp(abs(mod(c.x * 6.0 + vec3(0.0, 4.0, 2.0), 6.0) - 3.0) - 1.0, 0.0, 1.0);
    return c.z + c.y * (rgb - 0.5) * (1.0 - abs(2.0 * c.z - 1.0));
}

void main(void) {
    vec2 uv = gl_FragCoord.xy - u_size / 2.0;

    // Background colour
    vec3 colour = vec3(0, 0.1, 0.2);

    for(float i = 0.; i < u_lightCount; i++) {

        // Light position
        float lightAngle = TWO_PI * i / u_lightCount;
        float x = cos(lightAngle);
        float y = sin(lightAngle);
        vec2 lighPosition = vec2(x, y) * u_radius;

        // Light colour
        float hue = (i + u_time * 5.0) / u_lightCount;
        vec3 lightColour = hsl2rgb(vec3(hue, 1.0, 0.5));
        colour += brightness / abs(length(uv - lighPosition)) * lightColour;
    }

    gl_FragColor = vec4(colour, 1.0);
}