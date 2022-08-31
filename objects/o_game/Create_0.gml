/// @desc



//SET UP THE SHADER VARIABLES
u_specular = shader_get_sampler_index(sh_normal,"specular")
unorm = shader_get_sampler_index(sh_normal,"norm");
view_xy = shader_get_uniform(sh_normal, "view_xy");
light_uniform = shader_get_uniform(sh_normal, "light_pos");




//a surface only to be used for normals
global.norm_surface = surface_create(1920,1280);

//surface only used for specular
global.specular_surface = surface_create(1920,1280);


//a dynamic layer where all the normals are put in
normal_layer = create_normal_layer("normal");

instance_create_depth(x,y,0,o_light);





