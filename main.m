clc; clear; close all;

load("data/classificator.mat");

images_dir = "data/test_locator";
test_filename = "P6070099.jpg";

results_dir = "data/results";

rows_step = 5;
cols_step = 10;
section_width = 300;
section_heigth = 64;

n_rows = 480;
n_cols = 640;

image_filename = fullfile(images_dir, test_filename);
image = imread(image_filename);
upper_left_corner = [1,1];

max_row = n_rows - section_heigth;
max_cols = n_cols - section_width;
left_upper_corner = [];
predictor_data = [];
for i=1:rows_step:max_row
    for j=1:cols_step:max_cols
        left_upper_corner = [left_upper_corner; [j, i]];
        disp("row: " + num2str(i) + ", column: " + num2str(j))
        sub_image = imcrop(image, [j, i, section_width, section_heigth]);
        hf = extractHOGFeatures(sub_image);
        predictor_data = [predictor_data; hf];
    end
end
[label, score, cost] = model.predict(predictor_data);
score_plate = score(:, 2);
best_scores_idx = find(score_plate == max(score_plate));

x_rectangle_values = zeros(1, length(best_scores_idx));
y_rectangle_values = zeros(1, length(best_scores_idx));
for i=1:length(best_scores_idx)
    idx = best_scores_idx(i);
    x_rectangle_values(i) = left_upper_corner(idx, 1);
    y_rectangle_values(i) = left_upper_corner(idx, 2);
end

rectangle_position = [floor(mean(x_rectangle_values)), floor(mean(y_rectangle_values))];
plate = imcrop(image, [rectangle_position, section_width, section_heigth]);
imwrite(plate, fullfile(results_dir, "plate_" + test_filename))

figure()
imshow(image)
drawrectangle("Position",[rectangle_position, section_width, section_heigth], "Color", "r");

