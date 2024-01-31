clc; clear;

train_plate_dir = "data/training/plates";
train_no_plate_dir = "data/training/non_plates";
save_data_dir = "data/training";

train_plate_filenames = dir(fullfile(train_plate_dir, "*.png"));
train_no_plate_filenames = dir(fullfile(train_no_plate_dir, "*.jpg"));

i = 1;

all_plates_hf = [];

% Hog values from plate images
for i=1:length(train_plate_filenames)
    full_name = fullfile(train_plate_dir, train_plate_filenames(i).name);
    image = imread(full_name);
    hf = extractHOGFeatures(image);
    all_plates_hf(i, :) = hf;

end

all_no_plates_hf = [];


% Hog values from non-plate images
for i=1:length(train_no_plate_filenames)
    full_name = fullfile(train_no_plate_dir, train_no_plate_filenames(i).name);
    image = imread(full_name);
    hf = extractHOGFeatures(image);
    all_no_plates_hf(i, :) = hf;

end

save(fullfile(save_data_dir, "hog_features"), "all_no_plates_hf", "all_plates_hf");