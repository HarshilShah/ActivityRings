//
//  ProgressShader.fsh
//  ActivityRings
//
//  Created by Harshil Shah on 14/10/17.
//  Copyright © 2017 Harshil Shah. All rights reserved.
//

/// This shader simply sets the color at any point to be a mixture of the
/// `start_color` and `end_colors` in the same proportion as it's distance from
/// each end
///
/// The `end_color` represents the color at the end of a full revolution,
/// so for cases when the progress is under a full revolution (i.e. <1), the
/// actual line never is of that color. So a `progress` uniform is used to
/// adjust the proportional distance of a point from the end of a full
/// revolution
void main() {
    float ratio = progress * v_path_distance / u_path_length;
    gl_FragColor = vec4((start_color * (1 - ratio)) + (end_color * ratio), 1.0);
}

