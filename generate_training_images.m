clc; clear;

n_section_per_image = 30;
rng(0);

max_cols = 640 - 300;
max_rows = 480 - 64;

complete_image_dir = "data/training/complete_images/";
section_dir = "data/training/cropped_sections";
train_image_pattern = fullfile(complete_image_dir, "*.jpg");
train_image_files = dir(train_image_pattern);

for i =1:length(train_image_files);
    base_file_name = train_image_files(i).name;
    full_name = fullfile(complete_image_dir, base_file_name);
    image = imread(full_name);
    cols_coordinate_values = randi([1, max_cols], 1, n_section_per_image);
    rows_coordinate_values = randi([1, max_rows], 1, n_section_per_image);
    for j=1:n_section_per_image
        cropped = imcrop(image, [ ...
            cols_coordinate_values(j), ...
            rows_coordinate_values(j), ...
            299, 63]);
        cropped_filepath = fullfile(section_dir, base_file_name + "_" + j +".jpg");
        imwrite(cropped, cropped_filepath)
    end
end